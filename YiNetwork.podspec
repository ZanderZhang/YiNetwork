
Pod::Spec.new do |s|

  s.name         = "YiNetwork"
  s.version      = "0.9.2"
  s.summary      = "YiNetwork is a high level request util based on AFNetworking."


  s.homepage     = "https://github.com/coderyi/YiNetwork"

  s.license      = "MIT"

  s.author             = { "coderyi" => "coderyi@163.com" }

  s.source       = { :git => "https://github.com/coderyi/YiNetwork.git", :commit => "2cc7fd08a7589fd2c7b43311e44284e0c1895912" }

  s.platform     = :ios, '7.0'
  s.source_files  = 'YiNetwork/**/**/*.{h,m,png}'
  s.requires_arc  = true
  s.dependency "AFNetworking", "~> 2.6.1"
  s.dependency "JSONModel", "~> 1.1.2"


end
