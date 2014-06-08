class CreateMyFriendlyUrls < ActiveRecord::Migration
  def change
    create_table :my_friendly_urls do |t|
      t.string :path
      t.string :slug
      t.string :controller
      t.string :action
      t.string :defaults

      t.timestamps
    end
  end
end
