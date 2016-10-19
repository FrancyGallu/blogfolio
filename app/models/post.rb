class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  has_and_belongs_to_many :tags

  validates_presence_of :title

  def get_tag_list
    self.tags.map(&:id).map(&:to_s)
  end
end
