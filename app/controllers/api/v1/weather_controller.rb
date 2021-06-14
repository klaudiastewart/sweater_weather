class Api::V1::WeatherController < ApplicationController
  def forecast
    if params[:location].nil? || !params[:location].present?
      return bad_params_400("Location not found")
    else
      @forecast = WeatherFacade.get_forecast(params[:location])
      return bad_params_400(@forecast) if @forecast.class == String
      render json: ForecastSerializer.new(@forecast)
    end
  end
end
