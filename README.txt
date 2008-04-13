= tickspot-ruby

http://github.com/bricooke/tickspot-ruby

== DESCRIPTION:

Ruby wrapper around the Tickspot API 
http://tickspot.com/api

== SYNOPSIS:

ts = Tickspot.new("company.tickspot.com", "email@example.com", "password")

ts.users[0].email
=> "email@example.com"

ts.users[0].created_at
=> "Fri May 11 15:00:08 EDT 2007"


ts.projects[0].name
=> "Best Project Ever"

ts.tasks(ts.projects[0].id)[0].sum_hours
=> "5.5"

ts.entries(5.years.ago, Time.now, :project_id => ts.projects[0].id)[0].hours
=> "0.5"

== REQUIREMENTS:

activesupport xml-simple

== INSTALL:

sudo gem install tickspot-ruby

== LICENSE:

(The MIT License)

Copyright (c) 2008 Brian Cooke

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
