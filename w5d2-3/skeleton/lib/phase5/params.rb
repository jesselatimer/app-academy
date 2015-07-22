require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = parse_www_encoded_form(req.query_string)
      @params.merge!(parse_www_encoded_form(req.body))
      @params.merge!(route_params)
    end

    def [](key)
      @params[key.to_s] || @params[key.to_sym]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params_hash = {}
      return params_hash unless www_encoded_form

      array = URI.decode_www_form(www_encoded_form)
      array.each do |key_string, value|
        keys = parse_key(key_string)
        deep_merge!(params_hash, construct_hash(keys, value))
      end

      params_hash
    end

    def deep_merge!(hash1, hash2)
      hash1.merge!(hash2) do |k, v1, v2|
        v1.is_a?(Hash) && v2.is_a?(Hash) ? deep_merge!(v1, v2) : v2
      end
    end

    def construct_hash(keys, value)
      return { keys.first => value } if keys.length == 1
      { keys.first => construct_hash(keys.drop(1), value) }
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
