require 'httparty'
module MixReader
  class Base
    include HTTParty

    MIXPANEL_JQL_URL = "https://mixpanel.com/api/2.0/jql"

    attr_accessor :filters, :script, :options

    class << self
      def query(args)
        raise "invalid arguments" unless args.is_a?(Hash)

        new(args).query
      end
    end

    def initialize(args)
      raise "can not instantiate base class" if class_name == "Base"
      @filters = args
    end

    def query
      build_script
      build_options
      query_and_init_objects
    end

    private

    def query_and_init_objects
      response = send_request
      data = response.parsed_response
      data.map do |item|
        item_data = item["properties"]
        h = {}
        item_data.each{ |k, v| h[k[1..-1]] = v if k[0] == '$' }
        item_data["class_name"] = class_name
        item_data
      end
    end

    def send_request
      self.class.send("post", MIXPANEL_JQL_URL, @options)
    end

    def build_options
      @options = {
        basic_auth: { username: api_secret },
        body: { script: script }
      }
    end

    def m_key(key)
      return key unless key[0] >= 'a' && key[0] <= 'z'
      '$' + key
    end

    def class_name
      self.class.name.split("::").last
    end

    def api_secret
      MixReader::configuration.api_secret
    end
  end
end
