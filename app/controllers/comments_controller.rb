class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :find_parent, only: :create

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create

    @comment = @parent.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.save
        redirect_back(fallback_location: root_path)

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      @comment.body = @comment.body + " </i></b></em></s></a></small> <i><small>(edited by #{view_context.link_to current_user.name, user_path(current_user)} " + @comment.updated_at.strftime("%l:%M%P on %B %e, %Y") + ")</i></small>"
      @comment.save!
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end

  def find_parent
    if params[:comment_id]
      @parent = Comment.find_by_id(params[:comment_id])
    elsif params[:video_id]
      @parent = Video.find_by_id(params[:video_id])
    end
  end
end
