class MyFriendlyUrlsController < ApplicationController

  before_filter :load_urls

  def index
    @url = MyFriendlyUrl.new
  end

  def create
    @url = MyFriendlyUrl.new params[:my_friendly_url]
    if @url.save
      flash[:success] = 'Friendly URL successfully created'
      redirect_to action: :index
    else
      flash[:error] = 'An error occurred saving friendly url'
      render :index
    end
  end

  protected

    def load_urls
      @urls = MyFriendlyUrl.all
    end

end
