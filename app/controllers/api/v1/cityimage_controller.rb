class Api::V1::CityimageController < ApplicationController
  def background
    if params[:location].nil? || !params[:location].present?
      return bad_params_400("Location not found")
    else
      @background = CityimageFacade.get_background_image(params[:location])
    end
  end
end
