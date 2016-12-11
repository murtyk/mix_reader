module MixReader
  class Events < MixReader::Base
    EVENT_SELECTORS = %w(from_date to_date event_selectors)
    JQL_SCRIPT_MAIN = 'PARAMS function main(){return Events(params)}'
    JQL_SCRIPT_PARAMS = "params = PARAMS_HASH;"

    attr_accessor :selectors

    def initialize(args)
      super
      extract_selectors
    end

    def build_script
      params = JQL_SCRIPT_PARAMS.sub("PARAMS_HASH", selectors)
      @script = JQL_SCRIPT_MAIN.sub("PARAMS", params)
    end

    def extract_selectors
      query_filters = {}
      EVENT_SELECTORS.each do |key|
        value = self.filters.delete(key.to_sym)
        query_filters[key.to_sym] = value unless value.nil?
      end
      @selectors = query_filters.to_json
    end
  end
end
