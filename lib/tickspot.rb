require 'active_support'
require 'active_support/inflector'
require 'rubygems'
require 'net/http'
require 'xmlsimple'
require File.dirname(__FILE__) + '/tickspot_entry'

class Tickspot
  VERSION = '0.1.0'
  
  def initialize(domain, email, password)
    @domain = domain
    @email = email
    @password = password
  end

  def users(params={})
    te = request("users", params)
    te.empty? ? [] : te.users
  end

  def projects
    te = request("projects")
    te.empty? ? [] : te.projects
  end

  def tasks(project_id)
    te = request("tasks", :project_id => project_id)
    te.empty? ? [] : te.tasks
  end

  def entries(start_date, end_date, params={})
    te = request("entries", params.merge({:start_date => start_date, :end_date => end_date}))
    te.empty? ? [] : te.entries 
  end

  class Unauthorized < RuntimeError
    def message
      "You are not authorized to perform this action.  If your login information is correct, you may be calling at admin-only action.  See http://tickspot.com/api/ for more information."
    end
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
      raise Unauthorized if response.is_a? Net::HTTPUnauthorized
      ret = TickspotEntry.new(XmlSimple.xml_in(response.body))
    }
    ret
  end
end
