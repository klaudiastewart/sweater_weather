class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :image_url, :source, :author
end
