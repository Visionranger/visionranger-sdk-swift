Pod::Spec.new do |s|
    s.name                          = 'Visionranger'
    s.version                       = '0.5.4'

    s.summary                       = 'Manage your product portfolio and gain operational insights.'
    s.license                       = { :type => 'Apache Public 2.0', :file => 'LICENSE' }
    s.homepage                      = 'https://www.visionranger.com'
    s.authors                       = { 'Visionranger' => 'development@visionranger.com' }
    s.source                        = { :git => 'https://github.com/visionranger/visionranger-sdk-swift.git', :tag => "#{s.version}" }
    s.framework                     = 'Foundation', 'UIKit'
    s.requires_arc                  = true
    s.platform                      = :ios
    s.ios.deployment_target         = '12.0'
    s.swift_version                 = '5.3'
    s.weak_framework                = 'SwiftUI'
    s.source_files                  = 'Visionranger/*.swift'
    s.ios.resource_bundle           = { 'Visionranger' => 'Visionranger/Resources/**/*.{lproj, json, png, xcassets}' }
end
