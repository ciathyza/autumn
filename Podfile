workspace 'autumn.xcworkspace'
platform :ios, '10.0'
inhibit_all_warnings!

target 'AutumnFramework' do
	project 'AutumnFramework/AutumnFramework.xcodeproj'
	use_frameworks!
	pod 'Alamofire', '~> 4.5'
end

target 'AutumnDemo' do
	project 'AutumnDemo/AutumnDemo.xcodeproj'
	use_frameworks!
	inherit! :search_paths

	target 'AutumnDemoUITests' do
		use_frameworks!
		inherit! :search_paths
		pod 'Autumn', :path => 'autumn.podspec'
	end
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	end
end
