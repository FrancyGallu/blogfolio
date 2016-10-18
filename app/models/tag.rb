class Tag < ActiveRecord::Base
  # config for friendly_id gem --> use :name instead of :id in urls
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :posts

  validates_presence_of :name
end
