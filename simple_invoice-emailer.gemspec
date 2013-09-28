# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "simple_invoice-emailer"
  s.version     = "0.0.0"
  s.authors     = ["Joel Plane"]
  s.email       = ["joel.plane@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{emailer for SimpleInvoice}
  s.description = %q{sends SimpleInvoices via email}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "text-table"
  s.add_development_dependency "rspec"
end
