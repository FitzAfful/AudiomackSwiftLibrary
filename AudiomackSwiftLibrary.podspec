#
# Be sure to run `pod lib lint AudiomackSwiftLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AudiomackSwiftLibrary'
  s.version          = '0.2.0'
  s.summary          = 'A wrapper library for Audiomacks API on iOS built in Swift
'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = 'A wrapper library for Audiomack`s API on iOS built in Swift.'

  s.homepage         = 'https://github.com/Fitzafful/AudiomackSwiftLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fitzafful' => 'fitzafful@gmail.com' }
  s.source           = { :git => 'https://github.com/Fitzafful/AudiomackSwiftLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<@Bra_Gerald>'

  s.swift_version = '5.0'
  s.ios.deployment_target = '8.0'

  s.source_files = 'AudiomackSwiftLibrary/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AudiomackSwiftLibrary' => ['AudiomackSwiftLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
