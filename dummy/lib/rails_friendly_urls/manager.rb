
module RailsFriendlyUrls
  class Manager

    def self.urls
      # This check is required because when migrating database, rake loads the full
      # Rails environment, that includes the routes, that will call this method
      # that will fail as the table doesn't exists yet.
      if ActiveRecord::Base.connection.table_exists? 'my_friendly_urls'
        MyFriendlyUrl.all
      else
        []
      end
    end

  end
end
