class UsersController < ApplicationController
  def index
    @users = User.where("id != ?", current_user.id)
    @followings =current_user.followings.pluck(:user_id)
  end
  def profile
  @user=User.find_by(:id=>params[:user_id])
  end

  def followings
    @user=User.find_by(:id=>params[:user_id])
    @followings=@user.followings
  end

  def followers
    @user=User.find_by(:id=>params[:user_id])
    @followers=User.where("id in (?)",@user.followers.pluck(:following_id))

  end

  def follow
    is_already_followed = current_user.followings.where(:user_id => params[:user_id])
    unless is_already_followed.present?
      current_user.followings.create({:user_id => params[:user_id]})
      flash[:success] = "Successfully followed"
    else
      flash[:alert] = "Already following."
    end
    redirect_to all_users_path
  end

  def unfollow
    is_already_followed = current_user.followings.where(:user_id => params[:user_id])
    if is_already_followed.present?
      is_already_followed.first.delete
      flash[:success] = "Successfully unfollowed"
    else
      flash[:alert] = "User not followed by you."
    end
    redirect_to all_users_path
  end

end
