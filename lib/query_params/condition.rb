require "query_params"

module Condition

  OPERATORS = { "=" => "eq", ">=" => "ge", "<=" => "le", "between" => "bt", "in" => "in" }

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

    condition = condition.gsub(/ in\(/i, ' in (')

    tokens = condition.split(" ")
    
    raise(ArgumentError, "Invalid condition: #{condition}. Probably, the operator was not separated by space.") if tokens.size < 3

    field = tokens[0].strip
    operator = tokens[1].strip.downcase
    value = tokens[2..tokens.size].join(" ").strip.gsub(/['"]/,"")
    
    raise(ArgumentError, "Invalid operator. Accepted tokens: #{OPERATORS.values}") if OPERATORS[operator].nil?

    if operator == "between"
      bt_values = value.downcase.split(' and ')
      # queryParam.bt('age', 18, 21)
      self.send(OPERATORS[operator], field, bt_values[0], bt_values[1])
    elsif operator == "in"
      # queryParam.in('age', [1,2,3])
      self.send(OPERATORS[operator], field, value.strip[1..-2].split(","))
    else
      # queryParam.eq('age', 18)
      self.send(OPERATORS[operator], field, value)
    end
  end

end