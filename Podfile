platform :ios, '9.0'

use_frameworks!
target 'myRxSwiftDemo' do

pod 'RxSwift'
pod 'RxCocoa'
pod 'NSObject+Rx'
pod 'Moya/RxSwift'
pod 'ObjectMapper'
pod 'RxDataSources'
pod 'Then'
pod 'Kingfisher',
 :git => 'https://github.com/onevcat/Kingfisher.git',
 :branch => 'swift4'

pod 'SnapKit','~> 3.0.0'

pod 'Reusable'
pod 'MJRefresh'
pod 'SVProgressHUD'

end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
