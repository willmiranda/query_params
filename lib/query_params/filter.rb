module Filter
  
  def full_text_search(query)
    @query = "q=#{query.strip}" unless query.to_s.empty?
  end

  def q(query)
    full_text_search(query)
  end

  def equal(key, value)
    if value.kind_of?(Array)
      @params.push("#{key}::in(#{value.join(",")})") unless value.to_s.empty?
    else
      @params.push("#{key}::eq(#{value})") unless value.to_s.empty?
    end
  end

  def eq(key, value)
    equal(key, value)
  end

  def in(key, values)
    @params.push("#{key}::in(#{values.join(",")})") unless values.to_s.empty?
  end

  def greater_and_equal(key, value)
    @params.push("#{key}::ge(#{value})") unless value.to_s.empty?
  end
    
  def ge(key, value)
    greater_and_equal(key, value)
  end

  def less_and_equal(key, value)
    @params.push("#{key}::le(#{value})") unless value.to_s.empty?
  end

  def le(key, value)
    less_and_equal(key, value)
  end

  def between(key, range_ini, range_end)
    @params.push("#{key}::bt(#{range_ini},#{range_end})") if !range_ini.to_s.empty? && !range_end.to_s.empty?
  end

  def bt(key, range_ini, range_end)
    between(key, range_ini, range_end)
  end

end
