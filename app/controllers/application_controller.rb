class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # def record_not_found(message)
  #   bad_params(message)
  # end

  def bad_params_400(message)
    body = ({
      error: "#{message}",
      status: 400
      }).to_json
    render json: JSON.parse(body, :quirks_mode => true), status: 400
  end
end
