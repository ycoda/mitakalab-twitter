class TweetsController < ApplicationController
  def index
    @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(title: params[:tweet][:title], content: params[:tweet][:content], user_id: current_user.id)
    if @tweet.save
      redirect_to tweets_path
    else
      render 'new'
    end
  end
end
