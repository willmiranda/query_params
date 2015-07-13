require "query_params/version"
require "query_params/filter"
require "query_params/condition"

module URI
  class QueryParams

    include Filter

    def initialize(base_uri = "")
      @base_uri = base_uri.nil? ? "" : base_uri
      @params = []
      @query = ""
    end

    def build_uri()
      uri = ""
      unless @base_uri.empty?
        uri += uri.include?('?') ? "&" : "?"
      end
      unless @query.empty?
        uri += "#{@query}" 
        uri += "&" unless @params.empty?
      end
      uri += "filters=#{ERB::Util.url_encode(@params.join("|"))}" unless @params.empty?
      uri = "" if uri.length == 1
      "#{@base_uri}#{uri}"
    end

    def self.build_uri(options = {})
      queryParams = QueryParams.new(options[:base_uri])
      Condition.build_uri(queryParams, options[:conditions]) if options[:conditions]
      queryParams.full_text_search(options[:q]) if options[:q]
      queryParams.build_uri()
    end
  end
end