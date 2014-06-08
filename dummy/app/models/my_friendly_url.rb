class MyFriendlyUrl < ActiveRecord::Base

  include RailsFriendlyUrls::FriendlyUrl

  attr_accessible :action, :controller, :defaults, :path, :slug

  validates :action, presence: true
  validates :controller, presence: true
  validates :path, presence: true
  validates :slug, presence: true

  serialize :defaults

  before_validation :set_destination_data
end
