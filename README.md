#Rails Friendly Urls Engine


Rails Gem to easily configure any url as a friendlier one.

##Features

* Allows customisation of **ABSOLUTELY** any url into a friendlier one.
* Takes care of named routes and both url and path helpers so that there's no need to change a single line of code when adding a new friendly url.
* When a friendly URL is defined to substitute another one. The non-friendly one is automatically configured to redirect to the friendly path so that you're not penalised by search engines.
* Doesn't force any particular storage for the friendly url's data.
* Includes a running example for demonstration purposes.

##Installation

Installing this gem only requires you to add the following line to your `Gemfile`

```ruby
gem 'rails_friendly_urls', git: 'https://github.com/calonso/rails_friendly_urls', branch: 'rails3'
```

And run

```
$ bundle install
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

But we only need to care about setting up the first two of them, the Rails Friendly URLs Engine will take care of the others. Finally, to make our new model be manageable by the engine we just need to include the `RailsFriendlyUrls::FriendlyUrl` module in it and make sure that we instruct the engine to compute the controller, action and defaults fields for us before saving our instances by invoking the `set_destination_data` method.

As a guide, you can see the code of my [`dummy/app/models/my_friendly_url.rb`](https://github.com/calonso/rails_friendly_urls/blob/rails3/dummy/app/models/my_friendly_url.rb "my_friendly_url.rb")

Just a reminder that you must make your storage engine to manage the defaults field as a hash.

###2. The Manager

We need to complete the `RailsFriendlyUrls::Manager` class with, at least, a method that returns all the urls to be injected. This particular implementation will depend on your previously chosen storage method. Once again, the best explanation I can give you is the code of my [`dummy/lib/rails_friendly_urls/manager.rb`](https://github.com/calonso/rails_friendly_urls/blob/rails3/dummy/lib/rails_friendly_urls/manager.rb "manager.rb")

###3. URL injection

And last but not least!! We need to let the Rails Friendly URLs Engine perform its magic by instructing it to inject the urls when loading routes. It is as simple as adding this line as the very first one of your routes.rb routes drawing block.

```ruby
RailsFriendlyUrls::Manager.inject_urls self
```

And that's all!! From this moment, you can define any url substitution and it'll simply work!

##Example project

The gem includes an example project should you need it as a guide or to try this gem's capabilities quickly.

To run it simply:

1. `$ rake db:migrate`
2. `$ rails s`
3. Open 0.0.0.0:3000/my_friendly_urls in your favourite browser
4. Insert /my_friendly as slug and /my_friendly_urls as path
5. Save
6. Restart rails server
7. Refresh the page and see what happened in your browser's address bar!
