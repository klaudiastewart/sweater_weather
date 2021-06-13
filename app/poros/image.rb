class Image
  attr_reader :id,
              :description,
              :image_url,
              :source,
              :author

  def initialize(data)
    @id = nil
    @description = data[:alt_description]
    @image_url = data[:urls][:regular]
    @source = data[:links][:html]
    @author = data[:user][:id]
  end
end
