class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index


  end

  def my_tweets
    @my_tweets=Tweet.where("user_id in (?)",current_user.followings.pluck(:user_id))
  end


  def new
    @tweets=Tweet.new
  end

  def create
    params["tweet"]["user_id"]=current_user.id
    tweet_data=Tweet.new(model_params)
    if tweet_data.save
      flash[:success] = "Successfully created"
    else
      flash[:error] = "Somthing went wrong"
    end
    redirect_to root_path
  end

  private
  def model_params
    params.require(:tweet).permit(:title,:content,:user_id)
  end
end
