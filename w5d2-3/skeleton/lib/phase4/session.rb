require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookies = req.cookies.select { |c| c.name == "_rails_lite_app" }
      cookie = JSON.parse(cookies.first.value) unless cookies.empty?
      @content = cookie || {}
    end

    def [](key)
      @content[key]
    end

    def []=(key, val)
      @content[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie = WEBrick::Cookie.new("_rails_lite_app", @content.to_json)
      res.cookies << cookie
    end
  end
end
