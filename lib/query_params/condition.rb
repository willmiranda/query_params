require "query_params"

module Condition

  OPERATORS = { "=" => "eq", ">=" => "ge", "<=" => "le" }

  def set_conditions(conditions)
    
    if conditions.kind_of?(Array)
      conditions.each do |condition|
        set_query(condition)
      end
    else
      set_query(conditions)
    end
  end

  def set_query(condition)
    tokens = condition.split(" ")
    
    raise(ArgumentError, "Invalid condition: #{condition}. Send operator separate for space.") if tokens.size < 3

    field = tokens[0].strip
    operator = tokens[1].strip
    value = tokens[2..tokens.size].join(" ").strip.gsub(/['"]/,"")
    
    raise(ArgumentError, "Invalid operator. Accepted tokens: #{OPERATORS.values}") if OPERATORS[operator].nil?

    self.send(OPERATORS[operator], field, value)
  end

end