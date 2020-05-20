class PingController < ActionController::API

  def ping
    render json: {ping: "pong"}
  end
end