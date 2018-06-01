class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  	@posts = Post.all.where("is_archive =? ",false)
  end
  def new
  	@post = Post.new
  end
  def create
  	@post = Post.create(post_params)
    image = params[:post][:avatar]
    post_id = @post.id
    params[:post][:avatar].each do |image|
      @picture_post = Picture.create(:name => image,:imageable_id => post_id,:imageable_type => "Post")
    end
  	@post.user_id = current_user.id
  	@post.save
  	redirect_to root_url
  end

  def show 
    @post = Post.find_by_id(params[:id])
    @comment = Comment.new
    if @post.present?
      comments = Comment.where("commentable_id =?","#{@post.id}")
      @comments = comments.where("is_archive =? ",false)
    end
  end

  def create_comment
    post_id = params[:post_id]
    post_text = params[:comment][:comment]
    image = params[:comment][:avatar]
    @post = Post.find_by_id(params[:post_id])
    post_comment = @post.comments.create(:comment => post_text,:commentable_id => post_id,:user_id => current_user.id,:avatar => image)
    @picture_comment = Picture.create(:name => image,:imageable_id => post_comment.id,:imageable_type => "Comment")
    redirect_to :back
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.present?
      if params[:title].present?
        @post.update_attribute(:title,params[:title])
      else
        @post.update_attribute(:description,params[:description])
        #render text: "sucess"
      end
    end
    render text: "sucess"
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
    if if_like.eql? "false"
      po = @post.likes.where("user_id =?", current_user.id)
      if po.empty?
        @like = Like.create(:is_liked => true,:user_id => current_user.id,:post_id => @post.id)
      end
    else
      po = @post.likes.where("user_id =?", current_user.id)
      po.first.destroy
    end
    redirect_to :back
  end




	private
	def post_params
	  params.require(:post).permit(:title,:description,:avatar)
	end
end
