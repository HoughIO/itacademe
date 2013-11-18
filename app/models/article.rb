class Article < ActiveRecord::Base
  attr_accessible :title, :body
  validates :title, presence: true,
                    length: { minimum: 5 }
  validates :body, presence: true,
                    length: { minimum: 5 }
end
