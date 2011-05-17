spec = Gem::Specification.new do |s|
  s.name = 'quickbooks'
  s.version = '0.0.1'

  s.summary = "QuickBooks XML API"
  s.description = %{A QuickBooks QBXML wrapper for Ruby}
  s.files = Dir['lib/**/*.rb'] + Dir['xml_schema/*.xml'] + Dir['sample_data/*.xml'] + ['ruby_schema']
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Alex Skryl"
  s.email = "rut216@gmail.com"
  s.homepage = "http://github.com/skryl"

  s.add_dependency(%q<activesupport>, [">= 0"])
  s.add_dependency(%q<nokogiri>, [">= 0"])
  s.add_dependency(%q<ruby2ruby>, ["= 1.2.1"])
end
