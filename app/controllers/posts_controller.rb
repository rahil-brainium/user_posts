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
  	@post.user_id = current_user.id
  	@post.save
  	redirect_to root_url
  end
  def show
  	@post = Post.find_by_id(params[:id])
    @comment = Comment.new
    if @post.present?
      @comments = Comment.where("commentable_id =?","#{@post.id}") 
    end
  end 
  def create_comment
    post_id = params[:post_id]
    post_text = params[:comment][:comment]
    image = params[:comment][:avatar]
    @post = Post.find_by_id(params[:post_id])
    post_comment = @post.comments.create(:comment => post_text,:commentable_id => post_id,:user_id => current_user.id,:avatar => image)
    redirect_to :back
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.present?
      if params[:title].present?
        @post.update_attribute(:title,params[:title])
        render text: "sucess"
      else
        @post.update_attribute(:description,params[:description])
        render text: "sucess"
      end
    end
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
      redirect_to root_url
      end
  end



	private
	def post_params
	  params.require(:post).permit(:title,:description,:avatar)
	end
end
