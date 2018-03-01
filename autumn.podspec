Pod::Spec.new do |spec|
	spec.name           = 'autumn'
	spec.version        = '1.0.0'
	spec.license        = { :type => "Proprietary", :file => "LICENSE" }
	spec.homepage       = 'https://github.com/ciathyza/autumn'
	spec.authors        = { "Ciathyza" => "ciathyza@ciathyza.com" }
	spec.summary        = 'An automation framework for iOS projects utilizing XCTest.'
	spec.platform       =  :ios, '10.0'
	spec.source         = { :git => 'https://github.com/ciathyza/autumn.git', :tag => spec.version.to_s }
	spec.source_files   = 'AutumnFramework/AutumnFramework/Source/**/*.{swift,h,m}'
	spec.requires_arc   = true
	spec.framework      = "XCTest"
	spec.dependency     'Alamofire', '~> 4.5'
	spec.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"' }
end
