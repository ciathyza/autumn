Pod::Spec.new do |spec|
	spec.name                = 'Autumn'
	spec.version             = '1.0.11'
	spec.license             = { :type => "Proprietary", :file => "LICENSE" }
	spec.homepage            = 'https://git.rakuten-it.com/users/ts-balkau.sascha/repos/autumn'
	spec.authors             = { "Sascha Balkau" => "ts-balkau.sascha@rakuten.com" }
	spec.summary             = 'A Swift UI test framework built around XCTest.'
	spec.platform            = :ios, '10.0'
	spec.source              = { :git => 'https://git.rakuten-it.com/scm/~ts-balkau.sascha/autumn.git', :tag => spec.version.to_s }
	spec.source_files        = 'AutumnFramework/AutumnFramework/source/**/*.{swift,h,m}'
	spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
	spec.requires_arc        = true
	spec.framework           = "XCTest"
	spec.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"', }
	spec.dependency          'Alamofire', '~> 4.5'
end
