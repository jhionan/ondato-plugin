#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ondato_skd.podspec' to validate before publishing.
#

Pod::Spec.new do |s|
  s.name             = 'ondato_skd'
  s.version          = '2.1.0'
  s.summary          = 'Implement ondato SDK for android and ios'
  s.description      = <<-DESC
Implement ondato SDK for android and ios
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.'}

  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'

  s.dependency 'OndatoSDKiOS', '~> 1.8.9'

  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
end
