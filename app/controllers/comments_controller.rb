class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  load_and_authorize_resource
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(post_id: params[:post_id], author_id: current_user.id, text: params[:text])
    if @comment.save
      flash[:notice] = 'Comment was successfully created. ✅👍'
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    flash[:notice] = 'Comment was successfully deleted. ✅👍'
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
