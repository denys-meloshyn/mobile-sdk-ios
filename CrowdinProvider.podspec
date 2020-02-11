#
# Be sure to run `pod lib lint CrowdinSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'CrowdinProvider'
  spec.version          = '1.1.0'
  spec.summary          = 'Crowdin iOS SDK delivers all new translations from Crowdin project to the application immediately'
  
  spec.description      = <<-DESC
  
  Crowdin iOS SDK delivers all new translations from Crowdin project to the application immediately. So there is no need to update this application via App Store to get the new version with the localization.

  The SDK provides:

  Over-The-Air Content Delivery – the localized files can be sent to the application from the project whenever needed
  Real-time Preview – all the translations that are done via Editor can be shown in the application in real-time
  Screenshots – all screenshots made in the application may be automatically sent to your Crowdin project with tagged source strings
  
  DESC
  
  spec.homepage         = 'https://github.com/crowdin/mobile-sdk-ios'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'Crowdin' => 'support@crowdin.com' }
  spec.source           = { :git => 'https://github.com/crowdin/mobile-sdk-ios.git', :tag => spec.version.to_s }
  spec.social_media_url    = 'https://twitter.com/crowdin'
  
  spec.ios.deployment_target = '9.0'
  
  spec.frameworks = 'UIKit'
  spec.static_framework = true
  spec.swift_version = '4.2'
  
  spec.name = 'CrowdinProvider'
  spec.source_files = 'CrowdinSDK/Classes/Providers/Crowdin/**/*.swift'
  spec.dependency 'CrowdinSDK'
  spec.dependency 'CrowdinAPI'
  
  spec.test_spec 'CrowdinProvider_Tests' do |test_spec|
    test_spec.source_files = 'CrowdinSDK/Tests/CrowdinProvider/*.swift'
  end
end
