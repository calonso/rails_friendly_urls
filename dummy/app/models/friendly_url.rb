class FriendlyUrl < ActiveRecord::Base

  include RailsFriendlyUrls::Manager

  serialize :defaults, Hash

  validates :path, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true, if: :path
  validates :controller, presence: true, if: :path
  validates :action, presence: true, if: :controller

  def self.each_url(&block)
    self.find_each block
  end
  
end
