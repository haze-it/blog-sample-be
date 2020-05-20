class Api::V1::UsersController < ApplicationController
  before_action :authenticate, only: [:profile]

  def profile
  end

  def create
    user_param = user_params(params)
    user = User.new(user_param)

    if user.invalid?
      errors = user.errors
      render json: { error: errors }, status: 400
      return
    end

    user.save!
    token_set(user)
  end

  def signin
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    raise 'Authentication Failed' if !user # nil or false

    token_set(user)
  end

  def auth
    authenticate
    render json: {'status': 'ok'}
  end

  private

  def user_params(params)
    params.permit(:name, :email, :password)
  end

  def token_set(user)
    @token = jwt_encode(user.id)
    @user = user
    response.headers['X-Authentication-Token'] = @token
  end
end