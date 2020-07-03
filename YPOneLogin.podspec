Pod::Spec.new do |s|
  s.name         = 'YPOneLogin'    
  s.version      = '2.1.2'      
  s.summary      = 'quckly login'  
  s.homepage     = 'https://www.yunpian.com'      
  s.license      = { :type => 'MIT', :file => 'LICENSE' } 
  s.author       = { 'yuhao' => 'yuwowowo@126.com' }  
  s.ios.deployment_target = '8.0'                 
  s.source       = { :git => 'https://github.com/yunpian/yunpian-onelogin-demo-ios.git', :tag => 'v2.1.2' } 
  s.frameworks = 'CFNetwork', 'CoreTelephony', 'Foundation', 'SystemConfiguration', 'UIKit'
  s.libraries = 'c++.1', 'z.1.2.8' 
       
  s.vendored_frameworks = 'YPOneLogin/TYRZSDK.framework','YPOneLogin/YPOneLogin.framework'
  s.resources = 'YPOneLogin/OneLoginResource.bundle','README.md'
  
end
