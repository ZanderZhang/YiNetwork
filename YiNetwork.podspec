Pod::Spec.new do |s|
  s.name         = "YiNetwork"
  s.version      = "0.9"
  s.summary      = "YiNetwork is a high level request util based on AFNetworking."
  s.homepage     = "https://github.com/coderyi/YiNetwork"
  s.license      = "MIT"
  s.authors      = { "coderyi" => "coderyi@163.com" }
  s.source       = { :git => "https://github.com/coderyi/YiNetwork.git", :tag => "0.9" }
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '7.0'
  s.source_files = 'YiNetwork/**/**/*.{h,m,png}'
  s.requires_arc = true
end