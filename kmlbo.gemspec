Gem::Specification.new do |s|
  s.name        = 'kmlbo'
  s.version     = '0.0.2'
  s.date        = '2012-11-13'
  s.summary     = "A library and utility for working with KML, Ruby and the Google Maps API."
  s.description = "A Gem for converting kml path data to ruby arrays, and applying douglas peucker path simplification."
  s.author      = "Josh Cronemeyer"
  s.email       = 'joshuacronemeyer@gmail.com'
  s.homepage    = 'https://github.com/joshuacronemeyer/kmlbo'
  s.required_ruby_version = ">= 1.9.3"
  s.files = [
    "Rakefile",
    "README.md",
    "bin/kmlbo",
    "lib/kmlbo.rb",
    "lib/kmlbo/kml.rb",
    "lib/kmlbo/g_polyline.rb",
    "lib/kmlbo/pointlist.rb",
    "lib/kmlbo/output.kml.erb"
  ]
  s.test_files = [
    "test/data.rb",
    "test/pointlist_test.rb",
    "test/g_polyline_test.rb",
    "test/sample.kml"
  ]
  s.executables = ['kmlbo']
  s.add_development_dependency('rake')
end