class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  	@posts = Post.all.where("is_archive =? ",false).order(created_at: :desc)
  end
  def new
  	@post = Post.new
    @post_pictures = Picture.new
  end

  def create
    params[:post][:user_id] = current_user.id
    @post = Post.create(post_params)
    if params[:post][:picture].present?
      params[:post][:picture][:image].each do |image|
        @picture_post = Picture.create(:image => image,:imageable => @post)
      end
    end
  	redirect_to root_url
  end

  def show 
    @post = Post.find_by_id(params[:id])
    @comment_pictures = Picture.new
    @comment = Comment.new
    if @post.present?
      @comments = Comment.where("commentable_id =? and is_archive=?","#{@post.id}",false)
    end
  end

  def create_comment
    post_text = params[:comment][:comment]
    @post = Post.find_by_id(params[:post_id])
    post_comment = @post.comments.create(:comment => post_text,:commentable => @post,:user_id => current_user.id)
    if params[:comment][:picture].present?
      params[:comment][:picture][:image].each do |image|
        @picture_comment = Picture.create(:image => image,:imageable => post_comment)
      end
    end
    redirect_to :back
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.present?
      if params[:title].present?
        @post.update_attribute(:title,params[:title])
      else
        @post.update_attribute(:description,params[:description])
      end
    end
    render text: "success"
  end

  def update_comment
    @post = Post.find_by_id(params[:id])
    comment_id = params[:comment_id].to_i
    comment_val = params[:comment_val]
    @post.comments.each do |c|
      if c.id == comment_id
        c.update_attribute(:comment,comment_val)
      end 
    end
    render text: "success"
  end
  def delete_post
    @post = Post.find_by_id(params[:post_id])
    if @post.present?
      @post.update_attribute(:is_archive,true)
      end
    render json: @post.id
  end

  def delete_comment
    comment_id = params[:id].to_i
    @post = Post.find_by_id(params[:post_id])
    if @post.present?
      @post.comments.each do |c|
        if c.id == comment_id
          c.update_attribute(:is_archive,true)
        end 
      end
    end
    redirect_to :back
  end

  def like_post
    @post = Post.find_by_id(params[:id])
    if_like = params[:like_boolean].to_s
    @like = @post.likes.where("user_id=?",current_user.id).first
    if @like.present?
      if if_like.eql? "true"
        @like.update_attribute(:is_liked,false)
      else
        @like.update_attribute(:is_liked,true)
      end
    else
      @like = Like.create(:is_liked => true,:user_id => current_user.id,:post_id => @post.id)
    end


    render json: {post_id: @post.id,is_like: @like.is_liked}
    # if if_like.eql? "false"
    #   po = @post.likes.where("user_id =?", current_user.id)
    #   if po.empty?
    #     @like = Like.create(:is_liked => true,:user_id => current_user.id,:post_id => @post.id)
    #     render json: @like
    #   else
    #     @like = Like.where()
    # else
    #   po = @post.likes.where("user_id =?", current_user.id)
    #   po.first.update_attribute(:is_liked=>true)
    #   render json: @like
    #   # render text: "false"
    # end
  end




	private
	def post_params
	  params.require(:post).permit(:title,:description,:user_id)
	end
end
