module MixReader
  class People < MixReader::Base
    JQL_SCRIPT_MAIN = 'PARAMS function main(){ SCRIPT_QUERY }'
    JQL_SCRIPT_CLASS = 'return People()'
    JQL_SCRIPT_FILTER = '.filter(function(entity){ return FILTER_STRING });'
    JQL_SCRIPT_PARAMS = "params = PARAMS_HASH;"

    def build_script
      params = ""
      query_string = JQL_SCRIPT_CLASS

      if filters.any?
        query_string += JQL_SCRIPT_FILTER.sub("FILTER_STRING", filter_string)
        params = JQL_SCRIPT_PARAMS.sub("PARAMS_HASH", filters.to_json)
      end
      @script = JQL_SCRIPT_MAIN.sub("SCRIPT_QUERY", query_string).sub("PARAMS", params)
    end

    def filter_string
      return "" unless filters.any?

      equal_filters = filters.clone

      predicates =  equal_filters
                     .map{ |k, v| "entity.properties.#{m_key(k.to_s)} == params.#{k}" }

      predicates.join("&&") + ";"
    end
  end
end
