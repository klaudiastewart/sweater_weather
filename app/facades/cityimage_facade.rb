class CityimageFacade
  class << self
    def get_background_image(location)
      background = UnsplashService.get_city_image(location)
      Image.new(background.first)
    end
  end
end
