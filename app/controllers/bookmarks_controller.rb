class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "Bookmark saved!"
      redirect_to @topic
    else
      flash[:alert] = "There was a problem saving the bookmark, please try again."
      render :new
    end

  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    @topic = Topic.find(params[:topic_id])

    if @bookmark.save
      flash[:notice] = "Bookmark was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "Error saving bookmark. Please try again."
      render :edit
    end
  end

def destroy
  @bookmark = Bookmark.find(params[:id])
  @topic = Topic.find(params[:topic_id])

  if @bookmark.destroy
    flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
    redirect_to @topic
  else
    flash.now[:alert] = "There was an error deleting the bookmark."
    render :show
  end
end

  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end