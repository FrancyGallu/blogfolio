class Post < ActiveRecord::Base
  # config for friendly_id gem --> use :title instead of :id in urls
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author, class_name: 'User'

  has_and_belongs_to_many :tags

  validates_presence_of :title

  def get_tag_list
    self.tags.map(&:id).map(&:to_s)
  end

  def creation_year
    self.created_at.year
  end

  def self.by_creation_year(year)
    where('extract(year from created_at) = ?', year)
  end
end
