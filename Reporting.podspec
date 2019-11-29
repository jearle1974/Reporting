#
#  Be sure to run `pod spec lint Reporting.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "Reporting"
  spec.version      = "1.0.0"
  spec.summary      = "Xcode debug logging helper"
  spec.homepage     = "https://github.com/jearle1974/Reporting.git"
  spec.license      = "MIT"
  spec.author             = { "Jason Earle" => "j.earle@live.ca" }
  spec.source       = { :git => "https://github.com/jearle1974/Reporting.git", :tag => "1.0.0" }
  spec.source_files  = "Reporting", "Reporting/**/*.{h,m,swift}"

end
