#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint al_push_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'al_push_plugin'
  s.version          = '0.0.1'
  s.summary          = '阿里云直播推流插件'
  s.description      = <<-DESC
阿里云直播推流插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AlivcLivePusher','4.4.1'
  s.dependency 'Queen','2.0.0-official-lite'
  s.vendored_frameworks = 'Frameworks/AliyunQueenUIKit.framework' , 'Frameworks/opencv2.framework'
  s.public_header_files = 'Classes/**/*.h'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
