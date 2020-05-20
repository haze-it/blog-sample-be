class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from RuntimeError, with: :unauthorized

  def authenticate
    raise 'Authorization Header is Blank.' if request.headers['Authorization'].blank?

    encoded_token = request.headers['Authorization'].split('Bearer ').last
    begin
      payload = jwt_decode(encoded_token).first
      @current_user = User.find(payload["user_id"].to_i)
    rescue
      raise 'Expired Token.'
    end
  end

  def current_user
    @current_user
  end

  def not_found(exception)
    # bugsnag_notify(exception)
    render json: { error: 'Not Found.' }, status: 404
  end

  def unauthorized(message = 'Unauthorized')
    render json: { error: message }, status: 401
  end

  # JWT
  def jwt_encode(user_id)
    expores_in = 1.week.from_now.to_i
    preload = { user_id: user_id, exp: expores_in }
    JWT.encode(preload, 'SECRET_KEY', 'HS256')
  end

  private

  def jwt_decode(token)
    decoded_token = JWT.decode(token, 'SECRET_KEY', true, { algorithm: 'HS256' })
  end
end
