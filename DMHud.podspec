#
#  Be sure to run `pod spec lint DMHud.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "DMHud"
  s.version      = "0.0.2"
  s.summary      = "一个简单的toast提示工具"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
  					一个简单的toast提示工具,用于系统提示等场景
                   DESC

  s.homepage         = 'https://github.com/DMDavid'

  s.license              = { :type => "MIT", :file => "LICENSE" }

  s.author           = { 'DMDavid' => '894566327@qq.com' }

  s.source       = { :git => "https://github.com/DMDavid/DMHud.git", :tag => "#{s.version}" }

  s.source_files  = 'DMHud/Classes/*.{h,m}'

  s.ios.deployment_target = '8.0'



end
