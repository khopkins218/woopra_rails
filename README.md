# WoopraRails

A gem for Ruby on Rails (version 3 and higher, wont work with Rails 4) to connect through the HTTP API interface to log pageviews, identities, and custom events to Woopra Analytics

## Installation

Add this line to your application's Gemfile:

    gem 'woopra_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install woopra_rails

## Initial setup
  Within your app/config directory, add the file 'woopra.yml' that looks like the following (but with your account):

    development:
      account: woopra-rails
      dryrun: true
    test:
      account: woopra-rails
      dryrun: true
    production:
      account: woopra-rails
      dryrun: false

  Next setup an initializer to load the necessary configuration.  Add an initializer to app/config/initializers with the following content:

    begin
      WoopraRails.config = YAML.load_file(Rails.root.join("config","woopra.yml"))[Rails.env]
      WoopraRails.init
    end

  At this point, Woopra should initialize on app load and be ready for usage.

## Usage
  All API actions return a WoopraRails::Response object.  To check for success, assign the return to a variable, e.g. response, and call success? for a boolean return
    
    response = WoopraRails.identify("me")
    response.success? #returns true

  Identify the current user:
    
    response = WoopraRails.identify("me@kevinlhopkins.com")
  
  Log a pageview:
    
    WoopraRails.log_pageview("Page Title", "/path/to/this/page")

  Log a custom event:
  This functionality is pretty extensible.  It expects an event name, and a hash of params that are turned into Woopra event descriptors.
    
    WoopraRails::log_event(
      "my_test_event",
      {
        user_name: "Kevin Hopkins",
        user_state: "Virginia",
        user_skills: "Development, Rails, Woopra, Analytics"
      }
    )


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
