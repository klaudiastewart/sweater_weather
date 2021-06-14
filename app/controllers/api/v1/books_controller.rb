class Api::V1::BooksController < ApplicationController
  def search
    if params[:location].present? && params[:quantity].present?
      location_and_quantity = (params[:location], params[:quantity]
      # book = params[:param]
      object = BookFacade.get_books(location_and_quantity)
      render json: BookSerializer.new(object)
    else
      return bad_params_400("Book not found")
    end
  end
end
