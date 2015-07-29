class TweetsController < ApplicationController

  before_action :redirect, except: :index

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order('created_at DESC')
  end

  def new
  end

  def create
    #tweet = Tweet.new(tweet_params)
    #tweet.user_id = current_user.id
    #tweet.save
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
        tweet.destroy
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(text: tweet_params[:text],image: tweet_params[:image])
    end
  end

  private
  def tweet_params
    params.permit(:image,:text)
  end

  def id_params
    params.permit(:id)
  end

  def redirect
    redirect_to action: :index unless user_signed_in?
  end

end