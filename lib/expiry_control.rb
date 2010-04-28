class ActionController::Base
  
  after_filter :_set_expires_header
  
  private
  
  def _set_expires_header
    et = ExpiryControl.expiration_time(self)
    expires_in et, :public => true if et
  end
  
end

module ExpiryControl
  
  def self.configure
    @@config ||= Config.new
    yield @@config
  end
  
  def self.expiration_time(controller)
    @@config.expiration_time(controller) if @@config
  end
  
  class Config

    def initialize
      @config = {}
    end

    def cache(path, options)
      raise "Missing expiration time!" unless options[:for]
      raise "You cannot use :if and :unless at the same time!" if [:if, :unless].all? {|o| options[o]}
      @config[path] = options
    end

    def default(time)
      @config[:default] = time
    end
    
    def expiration_time(controller)
      ca_string = "#{controller.controller_name}##{controller.action_name}"
      request_config = @config[ca_string]
      request_config ||= @config[controller.controller_name]
      request_config ||= @config[:default]
      request_config ||= {}
      if [:if, :unless].any? {|o| request_config[o]}
        r = request_config[:if].call(controller) if request_config[:if]
        r = !request_config[:unless].call(controller) if request_config[:unless]
        if r
          request_config[:for]
        else
          nil
        end
      else
        request_config[:for]
      end
    end
  end
  
end
