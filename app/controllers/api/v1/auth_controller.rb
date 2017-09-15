class Api::V1::AuthController < ApplicationController
  before_action :authorize_user!, only: [:show]

  def show
    render json: {
      id: current_user.id,
      email: current_user.email
    }
  end

  def create
     user = User.find_by(email: params[:email])
     if user.present? && user.authenticate(params[:password])
       created_jwt = issue_token({
         id: user.id,
         email: user.email
         })
       render json: {id: user.id, email: user.email, name: user.name, jwt: created_jwt}
     else
       render json: { error: ['Invaid Email or Password'] }, status: 422
     end
  end






end
