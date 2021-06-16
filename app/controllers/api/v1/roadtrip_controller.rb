class Api::V1::RoadtripController < ApplicationController
  def index
    if !params[:origin].present? || !params[:destination].present?
      return bad_params_400("Missing or bad params")
    elsif !params[:api_key].present? || User.find_by_api_key(params[:api_key]).nil?
      return bad_params_401("Unauthorized")
    else
      trip = RoadtripFacade.get_road_trip(params[:origin], params[:destination])
      return bad_params_400(trip) if trip.class == String
      render json: RoadtripSerializer.new(trip)
    end
  end
end
