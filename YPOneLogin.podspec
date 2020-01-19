Pod::Spec.new do |s|
  s.name         = "YPOneLogin"    
  s.version      = "2.0.0"      
  s.summary      = "一键登录，方便、安全、快速登录"  
  s.homepage     = "https://github.com/yunpian/yunpian-onelogin-demo-ios"      
  s.license      = { :type => "MIT", :file => "LICENSE" } 
  s.author       = { "yunpian" => "yuhao@yunpian.com" }  
  s.platform     = :ios, '8.0'                  
  s.source       = { :git => "https://github.com/yunpian/yunpian-onelogin-demo-ios.git", :tag => "v2.0.0" }         
  s.vendored_frameworks = 'YPOneLogin/TYRZSDK.framework','YPOneLogin/YPOneLogin.framework'
  s.resources = 'YPOneLogin/OneLoginResource.bundle','YPOneLogin/TYRZResource.boundle','README.md'
  s.requires_arc = true 
  s.frameworks = 'CFNetwork', 'CoreTelephony', 'Foundation', 'SystemConfiguration', 'UIKit'
  s.libraries = 'c++.1', 'z.1.2.8'
end
