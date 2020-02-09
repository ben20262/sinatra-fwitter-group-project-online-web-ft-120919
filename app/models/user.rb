class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweets

  def slug
    slug_u = self.username.split(" ")
    slug_u.map! {|w| w.downcase}
    slug_u.join("-")
  end

  def self.find_by_slug (slug_u)
    self.all.select {|s| s.slug == slug_u}.first
  end
end
