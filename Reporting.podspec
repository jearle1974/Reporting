Pod::Spec.new do |spec|

  spec.name         = "Reporting"
  spec.version      = "1.0.1"
  spec.summary      = "Xcode debug logging helper"
  spec.homepage     = "https://github.com/jearle1974/Reporting.git"
  spec.license      = "MIT"
  spec.author             = { "Jason Earle" => "j.earle@live.ca" }
  spec.source       = { :git => "https://github.com/jearle1974/Reporting.git" }
  spec.source_files  = "Reporting", "Reporting/**/*.{h,m,swift}"
  spec.swift_version = '5.0'
  spec.requires_arc = true
  spec.ios.deployment_target = '12.0'

end
