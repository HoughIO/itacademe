class Article < ActiveRecord::Base
  attr_accessible :title, :body, :date_published
  validates :title, presence: true
  validates :body, presence: true
  validates :date_published, presence: true
end
