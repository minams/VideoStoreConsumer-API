class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  def available_inventory
    self.inventory - Rental.where(movie: self, returned: false).length
  end

  def image_url
    orig_value = read_attribute :image_url
    if !orig_value
      MovieWrapper::DEFAULT_IMG_URL
    elsif !orig_value.include?("https://image.tmdb.org/t/p/w185") && external_id
      MovieWrapper.construct_image_url(orig_value)
    else
      orig_value
    end
  end
end
