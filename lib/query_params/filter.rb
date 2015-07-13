module Filter
  
  def full_text_search(query)
    @query = "q=#{query.strip}"
  end

  def q(query)
    full_text_search(query)
  end

  def equal(key, value)
    if value.kind_of?(Array)
      @params.push("#{key}::in(#{value.join(",")})")
    else
      @params.push("#{key}::eq(#{value})")
    end
  end

  def eq(key, value)
    equal(key, value)
  end

  def greater_and_equal(key, value)
    @params.push("#{key}::ge(#{value})")
  end
    
  def ge(key, value)
    greater_and_equal(key, value)
  end

  def less_and_equal(key, value)
    @params.push("#{key}::le(#{value})")
  end

  def le(key, value)
    less_and_equal(key, value)
  end

  def between(key, range_ini, range_end)
    @params.push("#{key}::bt(#{range_ini},#{range_end})")
  end

  def bt(key, range_ini, range_end)
    between(key, range_ini, range_end)
  end

end