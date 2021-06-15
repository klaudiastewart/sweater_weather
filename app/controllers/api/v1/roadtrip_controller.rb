class Api::V1::RoadtripController < ApplicationController
  def index
    # require "pry"; binding.pry
    if !params[:origin].present? || !params[:destination].present?  || !params[:api_key].present?
      return bad_params_400("Missing params")
    else
      trip = RoadtripFacade.get_road_trip(params[:origin], params[:destination])
    end
  end
end
