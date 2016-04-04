require_relative 'lib/ffi-rexif/version'

Gem::Specification.new do |s|
  s.name      = 'ffi-rexif'
  s.version   = LibExif::VERSION
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A low-level Ruby FFI wrapper for libexif.'
  s.description = 'A low-level Ruby FFI wrapper for libexif.'
  
  s.homepage  = 'https://github.com/amclain/ffi-rexif'
  s.authors   = ['Alex McLain']
  s.email     = ['alex@alexmclain.com']
  s.license   = 'MIT'
  
  s.files     = [
      'LICENSE',
      'README.md',
    ] +
    Dir[
      'lib/**/*',
      'doc/**/*',
    ]

  s.add_dependency 'ffi', '~>1.9'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'rspec', '~>3.4'
  s.add_development_dependency 'rspec-its', '~> 1.2'
  s.add_development_dependency 'fivemat'
end
