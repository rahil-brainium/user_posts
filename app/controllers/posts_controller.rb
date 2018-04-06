class PostsController < ApplicationController

  def index
  	@posts = Post.all
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
    @post = Post.find_by_id(params[:post_id])
    post_comment = @post.comments.create(:comment => post_text,:commentable_id => post_id,:user_id => current_user.id)
    redirect_to :back
  end






	private
	def post_params
	  params.require(:post).permit(:title,:description,:avatar)
	end
end
