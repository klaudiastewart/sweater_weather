class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination, :forecast, :books_found, :books 
end
