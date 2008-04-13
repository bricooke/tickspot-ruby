class TickspotEntry
  def initialize(parsed)
    @hash = parsed
  end
  
  def id
    self.method_missing(:id)
  end
  
  def method_missing(method, *args)    
    if @hash.has_key?(method.to_s.singularize)
      entry = @hash[method.to_s.singularize]
      if method.to_s.pluralize == method.to_s && entry.class == Array
        return entry.collect {|e| TickspotEntry.new(e)}
      else
        return entry[0] unless entry[0].class == Hash && entry[0].has_key?("content")
        return entry[0]["content"]
      end
    elsif @hash.has_key?(method.to_s)
      entry = @hash[method.to_s]
      return entry[0] unless entry[0].class == Hash && entry[0].has_key?("content")
      return entry[0]["content"]
    else
      super 
    end
  end
end
