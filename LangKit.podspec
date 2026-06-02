#
# Be sure to run `pod lib lint LangKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LangKit'
  s.version          = '0.1.1'
  s.summary          = 'A short description of LangKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fenghanxu/LangKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fenghanxu' => '1162851277@qq.com' }
  s.source           = { :git => 'https://github.com/fenghanxu/LangKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  #最低支持的系统
  s.ios.deployment_target = '10.0'
  
  # 头文件
  s.public_header_files = ["Sources/**/*.h","Sources/*/**/*.h","Sources/*/*/**/*.h"]

  # 项目文件
  s.source_files = ["Sources/**","Sources/*/**","Sources/*/*/**"]
  
  # 系统框架
  s.frameworks = 'UIKit', 'Foundation'
  
  # 内存管理模式
  s.requires_arc = true
  


  
end
