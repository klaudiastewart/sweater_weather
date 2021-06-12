class Api::V1::WeatherController < ApplicationController
  def forecast
    if params[:location].nil? || !params[:location].present?
      return record_not_found("Record not found")
    else
      @forecast = WeatherFacade.get_forecast(params[:location])
      render json: ForecastSerializer.new(@forecast)
    end
  end
end
