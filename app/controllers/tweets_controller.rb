class TweetsController < ApplicationController
  def index
    @tweets = Tweet.page(params[:page]).per(10)
  end

  def show
  end

  def new
  end

  def create
    @tweet = Tweet.new(title: params[:tweet][:title], content: params[:tweet][:content])
    if @tweet.save
      redirect_to '/tweets/index'
    else
      render 'new'
    end 
  end
end
