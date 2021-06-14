class Api::V1::BooksController < ApplicationController
  def search
    if params[:location].present? && params[:quantity].present?
      location = params[:location]
      quantity = params[:quantity]
      object = BookFacade.get_books(location, quantity)
      render json: BookSerializer.new(object)
    else
      return bad_params_400("Book not found")
    end
  end
end
