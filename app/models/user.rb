class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :password, :studentnumber, :maycontact, :classnumber, :password_confirmation
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create}
  validates_presence_of :classnumber
end
