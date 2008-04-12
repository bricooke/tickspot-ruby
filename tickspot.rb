require 'rubygems'
require 'net/http'
require 'active_support'
require 'xmlsimple'

# Usage:
# ts = Tickspot.new("company.tickspot.com", "email@example.com", "password")
# users = ts.users
# users[0].email => "email@example.com"
# 
# Refer to http://tickspot.com/api/ to see all the fields returned
# 
class Tickspot
  def initialize(domain, email, password)
    @domain = domain
    @email = email
    @password = password
  end
  
  def users
    te = request("users")
    te.users
  end
  
private
  def request(path, params={})
    request = Net::HTTP::Post.new("/api/" + path)
    request.form_data = {
      'email'       => @email, 
      'password'    => @password
    }.merge(params)

    ret = nil
    Net::HTTP.new(@domain).start {|http| 
      response = http.request(request)
      ret = TickspotEntry.new(XmlSimple.xml_in(response.body))
    }
    ret
  end
end



class TickspotEntry
  def initialize(parsed)
    @hash = parsed
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
    else
      super 
    end
  end
end