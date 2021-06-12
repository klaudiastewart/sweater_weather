class Api::V1::WeatherController < ApplicationController
  def forecast
    if params[:location].nil? || !params[:location].present?
      # render 400 or 404
    else
      @forecase = WeatherFacade.get_forecast(params[:location])
  end
end
