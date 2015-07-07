require "query_params"

class Condition

  OPERATORS = { "=" => "eq", ">=" => "ge", "<=" => "le" }

  def self.build_uri(queryParams, conditions)
    
    if conditions.kind_of?(Array)
      conditions.each do |condition|
        set_query(queryParams, condition)
      end
    else
      set_query(queryParams, conditions)
    end
  end

  def self.set_query(queryParams, condition)
    tokens = condition.split(" ")
    
    raise(ArgumentError, "Invalid condition: #{condition}. Send operator separate for space.") if tokens.size < 3

    field = tokens[0].strip
    operator = tokens[1].strip
    value = tokens[2..tokens.size].join(" ").strip.gsub(/['"]/,"")
    
    raise(ArgumentError, "Invalid operator. Accepted tokens: #{OPERATORS.values}") if OPERATORS[operator].nil?

    queryParams.send(OPERATORS[operator], field, value)
  end

end