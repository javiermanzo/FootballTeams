source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
inhibit_all_warnings!

platform :ios, '14.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end

def shared_pods
  pod 'Kingfisher', '7.5.0'
  pod 'PocketSVG',  '2.7.2'
end

target 'FootballTeams' do
    shared_pods
end
