
Pod::Spec.new do |s|

  s.name         = "YiNetwork"
  s.version      = "0.9.0"
  s.summary      = "YiNetwork is a high level request util based on AFNetworking."


  s.homepage     = "https://github.com/coderyi/YiNetwork"

  s.license      = "MIT"

  s.author             = { "coderyi" => "coderyi@163.com" }

  s.source       = { :git => "https://github.com/coderyi/YiNetwork.git", :commit => "df485f27599225bce7e55c9021ffb67cad3d7399" }

  s.platform     = :ios, '7.0'
  s.source_files  = 'YiNetwork/**/**/*.{h,m,png}'
  s.requires_arc  = true
  s.dependency "AFNetworking", "~> 2.6.1"
  s.dependency "JSONModel", "~> 1.1.2"


end
