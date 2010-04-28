Rails 2.3 allows you to set the Expires header using the expires_in
method. However this couples your caching strategy with your controller
code. And it spreads out the caching configuration all over the place.
This plugin allows you to keep your caching configuration in one place
out of the controllers.

Install
=======

Install as a gem (`gem install expiry_control`) and add it in your
`environmen.rb` file.

Usage
=====

Create a file somewhere, maybe in `config/initializers` that will contain
your configuration. The name doesn't matter. Your configuration will go
into the following block of code:

    ExpiryControl.configure do |config|
      # configuration goes here
    end

Just like when you configure your routes you call methods on the object
passed into the block:

    # Set Expires header to 1 hour for the whole blog controller
    config.cache "blog", :for => 1.hour
    
    # Set Expires header to 5 minutes for a special action, this overrides
    # the controller wide setting
    config.cache "blog#special", :for => 5.minutes
    
    # Set a default caching time
    config.default 1.minute

This is all there is to it for the basic usage. Note that more specialized
rules take precedence. Specifically, the code first looks for a rule at
the action level (or rather action in a specific controller), then at the
controller level and the it uses the default rule (if it exists).

Sometimes however this is not enough and you need to make the caching
optional. For these cases you can use `:if` and `:unless` like you would
use in validations. Note, that you have to use a `Proc` symbols or strings
are not supported. This `Proc` gets passed the controller object for
maximum flexibility.

    # Only cache if 'cache' param is set
    config.cache "blog", :for => 1.hour, :if => Proc.new {|controller| controller.params["cache"]}
