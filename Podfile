workspace 'Autumn.xcworkspace'
platform :ios, '10.0'

# target 'AutumnFramework' do
# 	use_frameworks!
# 	project 'AutumnFramework/AutumnFramework.xcodeproj'
# 	pod 'Alamofire', '~> 4.5', :inhibit_warnings => true
# end

target 'AutumnDemo' do
	use_frameworks!
	inherit! :search_paths
	project 'AutumnDemo/AutumnDemo.xcodeproj'
	pod 'Alamofire', '~> 4.5', :inhibit_warnings => true
#	pod 'autumn', :path => 'autumn.podspec'
end

target 'AutumnDemoUITests' do
	use_frameworks!
	inherit! :search_paths
	project 'AutumnDemo/AutumnDemo.xcodeproj'
	pod 'Alamofire', '~> 4.5', :inhibit_warnings => true
#	pod 'autumn', :path => 'autumn.podspec'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	end
end
