class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!, only: [:edit, :user_saved_articles, :delete_user_saved_article]

  def create
    puts 'in create'
    if !User.find_by(email: params[:email])

      user = User.new(user_params)
      if user.valid?
        puts 'in valid'
        user.save
        created_jwt = issue_token({
          id: user.id,
          email: user.email
          })
        render json: {id: user.id, email: user.email, name: user.name, jwt: created_jwt}
      else
        render json: {error: user.errors.full_messages}
      end
    else
      render json: {error: ["User Email Already Exists"]}
    end
  end

  def edit
    # byebug
    user = User.find_by(email: current_user.email)
    user.update(interests: params[:interests])
    if user.save
      render json: user
    else
      render json: {error: user.errors.full_messages}
    end
  end

  def user_saved_articles
    # byebug
    user = User.find_by(email: current_user.email)
    if user
      saved_articles = user.saved_articles.all
      render json: saved_articles
    else
      render json: {error: user.errors.full_messages}
    end
  end

  def delete_user_saved_article
    # byebug
    user = User.find_by(email: current_user.email)
    article = SavedArticle.find(params[:id])
    article.destroy
    articles = user.saved_articles.all

    render json: articles
  end

private
  def user_params
    params.permit(:name, :email, :password, :interests, :id)
  end

  def user_interests
    params.permit(:interests)
  end
end
