class Work < ActiveRecord::Base
  validates_presence_of :name, :cover_image_url, :description

  paginates_per 15
end
