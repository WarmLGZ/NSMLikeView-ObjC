#
# Be sure to run `pod lib lint NSMLikeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NSMLikeView'
  s.version          = '0.1.1'
  s.summary          = 'NSMLikeView is a view of showing like animation.'

  s.homepage         = 'https://github.com/WarmLGZ/NSMLikeView-ObjC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguozhi' => 'liguozhi@xinpianchang.com' }
  s.source           = { :git => 'https://github.com/WarmLGZ/NSMLikeView-ObjC.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'NSMLikeView/Classes/**/*'
end
