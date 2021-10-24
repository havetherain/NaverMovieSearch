# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'NaverMovieSearch' do
    use_frameworks!

    inhibit_all_warnings!

    # Network
    pod 'Moya/RxSwift', '~> 15.0'

    # UI
    pod 'Kingfisher'
    pod 'SnapKit'
    pod 'Then'

    # React
    pod 'RxCocoa'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
    end
end
