#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "ImpDateTimeSelector"
  s.version      = "0.1.0"
  s.summary      = "A date time selector with a different approach for the impatient."
#
  s.homepage     = "https://github.com/grillbiff/ImpDateTimeSelector"
 # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "Erik Johansson" => "erik.gustaf.johansson@gmail.com" }
  s.source       = { :git => "ttps://github.com/grillbiff/ImpDateTimeSelector", :tag => s.version.to_s }

   s.platform     = :ios, '6.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
