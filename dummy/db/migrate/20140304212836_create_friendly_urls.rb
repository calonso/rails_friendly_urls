class CreateFriendlyUrls < ActiveRecord::Migration
  def change
    create_table :friendly_urls do |t|
      t.string :path
      t.string :slug
      t.string :controller
      t.string :action
      t.text :defaults

      t.timestamps
    end
  end
end
