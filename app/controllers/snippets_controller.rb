class SnippetsController < ApplicationController
  
  def home
  end

  def index
  end

  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(params[:snippet])
    if @snippet.save
      respond_to do |format|
        format.html { redirect_to @snippet }
      end
    end
  end


  def update
    @snippet = Snippet.find(params[:id])
    if @snippet.update_attributes(params[:snippet])
      respond_to do |format|
        format.html { redirect_to @snippet }
      end
    end
  end

end
