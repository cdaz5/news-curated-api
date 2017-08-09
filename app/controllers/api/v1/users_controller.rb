class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      created_jwt = issue_token({email: user.email})
      render json: {email: user.email, jwt: created_jwt}
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  def edit
    user = User.first
    #find_by(email: current_user.email)
    user.update(interests: params[:interests])
    if user.save
      render json: user
    else
      render json: {error: user.errors.full_messages}
    end
  end

private
  def user_params
    params.permit(:name, :email, :password, :interests)
  end
end
