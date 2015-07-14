require "query_params"

module Condition

  OPERATORS = { "=" => "eq", ">=" => "ge", "<=" => "le", "between" => "bt" }

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
    operator = tokens[1].strip.downcase
    value = tokens[2..tokens.size].join(" ").strip.gsub(/['"]/,"")
    
    raise(ArgumentError, "Invalid operator. Accepted tokens: #{OPERATORS.values}") if OPERATORS[operator].nil?

    if operator != "between"
      # queryParam.eq('age', 18)
      self.send(OPERATORS[operator], field, value)
    else
      bt_values = value.downcase.split(' and ')
      # queryParam.bt('age', 18, 21)
      self.send(OPERATORS[operator], field, bt_values[0], bt_values[1])
    end
  end

end