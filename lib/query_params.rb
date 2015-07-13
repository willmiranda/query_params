require "query_params/version"
require "query_params/filter"
require "query_params/condition"

module URI
  class QueryParams

    include Filter
    include Condition

    def initialize(base_uri = "")
      @base_uri = base_uri.nil? ? "" : base_uri
      @params = []
      @query = ""
      @filter_param_name = "filters"
    end

    def set_filter_param_name(name = @filter_param_name)
      @filter_param_name = name
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
      uri += "#{@filter_param_name}=#{build_filters()}" unless @params.empty?
      uri = "" if uri.length == 1
      "#{@base_uri}#{uri}"
    end

    def self.build_uri(options = {})
      queryParams = QueryParams.new(options[:base_uri])
      queryParams.set_conditions(options[:filters]) if options[:filters]
      queryParams.full_text_search(options[:q]) if options[:q]
      queryParams.filter_param_name(options[:filter_param_name]) if options[:filter_param_name]
      queryParams.build_uri()
    end

    def self.filters(filters)
      if filters.nil? || filters.empty?
        raise(ArgumentError, "Missing required parameter filters. Example: ['age >= 18']")
      end
      queryParams = QueryParams.new()
      queryParams.set_conditions(filters)
      queryParams.build_filters()
    end

    def build_filters()
      ERB::Util.url_encode(@params.join("|"))
    end
  end
end