#Rails Friendly Urls Engine [![Build Status](https://travis-ci.org/calonso/rails_friendly_urls.svg?branch=master)](https://travis-ci.org/calonso/rails_friendly_urls)

Rails Gem to easily configure any url as a friendlier one. 

##Features

* Allows customisation of **ABSOLUTELY** any url into a friendlier one.
* Takes care of the parameters you defined in your original route and will pass them into the controller when the friendly url is invoked.
* Takes care of named routes and both url and path helpers so that there's no need to change a single line of code when adding a new friendly url.
* When a friendly URL is defined to substitute another one. The non-friendly one is automatically configured to redirect to the friendly path so that you're not penalised by search engines.
* Doesn't force any particular storage for the friendly url's data.

##Example application

You can see the gem running live in the following url:

##Installation

Installing this gem only requires you to add the following line to your `Gemfile`

```ruby
gem 'rails_friendly_urls', git: 'https://github.com/calonso/rails_friendly_urls'
```

Run

```
$ bundle install
$ rails generate rails_friendly_urls:install
```

##Setup

Here I detail you the steps that I followed to set up the friendly urls engine in the example application, so most of them should be the same for you, some others slightly different, but don't worry, you'll see appropriated explanations while reading this steps.

###1. Friendly URLs Storage 

First of all we need to decide our urls storage technology, in my case I decided to use a standard activerecord rails model, but I guess that a YAML file could do the job as well or any other persistence technology.

5 fields are required to be stored to be able to build a friendly url. They are:

1. Path
2. Slug
3. Controller
4. Action
5. Defaults

Just a reminder that you must make your storage engine to manage the defaults field as a hash.

Once you've done it, remember to include the `RailsFriendlyUrls::FriendlyUrl` module in that class so that you can use `set_destination_data!` method. That method will complete all your `controller`, `action` and `defaults` fields once you've provided `path` and `slug`.

###2. The Manager

After running the bundled installer (`$ rails generate rails_friendly_urls:install`) a new but incomplete file appears at `config/initializers/friendly_urls_manager.rb`. We need to complete the `urls` method in that file to make it return the list of friendly url objects (objects that simply respond to the five methods described above, i.e: path, slug, controller, action and defaults)

In my example project this is the final implementation:

```
# FriendlyUrls Manager contents
class RailsFriendlyUrls::Manager 
  def self.urls
    ::FriendlyUrl.all
  end
end
```

Simple, huh?

###3. URL injection

As part of the installation process, a new line is inserted on top of the `routes.rb` file that simply invokes the friendly urls engine to do its magic.

##Caveats

* At the moment, only GET requests are supported.
* At the moment, the rails application has to be restarted for the new urls to start working.
