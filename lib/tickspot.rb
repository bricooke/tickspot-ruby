require 'rubygems'
require 'net/http'
require 'xmlsimple'
require 'activesupport'
require File.dirname(__FILE__) + '/tickspot_entry'

class Tickspot
  VERSION = '0.1.0'
  
  def initialize(domain, email, password)
    @domain = domain
    @email = email
    @password = password
  end

  def users
    te = request("users")
    te.users
  end

  def projects
    te = request("projects")
    te.projects
  end

  def tasks(project_id)
    te = request("tasks", :project_id => project_id)
    te.tasks
  end

  def entries(start_date, end_date, params={})
    te = request("entries", params.merge({:start_date => start_date, :end_date => end_date}))
    te.entries
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
