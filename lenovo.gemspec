Gem::Specification.new do |s|
  s.name        = 'cnos-rbapi'
  s.version     = '0.0.0'
  #s.date        = '10-16-2017'
  s.summary     = "Library Implementation for REST API's"
  s.description = "Lib for REST API's using Ruby"
  s.authors     = ["Coleen Quadros, Arun Lankapalli"]
  s.email       = 'cquadros@lenovo.com,arun, alankalapall@lenovo.com'
  s.files       = ["lib/cnos-rbapi.rb"] + Dir["lib/cnos-rbapi/*.rb"]
  s.homepage    = 'http://rubygems.org/gems/lenovo-rbapi'
  s.licenses     = ['Copyright (C) 2017 Lenovo, Inc','BSD-3-Clause']
  s.extra_rdoc_files = ['README.md', 'LICENSE.md', 'vlagTest.rb', 'vlanTest.rb']
end
