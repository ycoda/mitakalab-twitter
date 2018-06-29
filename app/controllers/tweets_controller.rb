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
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to tweets_path
    else
      render 'new'
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  end

  private
    def tweet_params
      params.require(:tweet).permit(:title, :content)
    end
end
