Pod::Spec.new do |s|
  s.name             = 'ECKit'
  s.version          = '0.1.0'
  s.summary          = 'Collection of common iOS code that I use'
  s.description      = 'Collection of common iOS code that I use'
  s.homepage         = 'https://github.com/EvanCooper9/ECKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EvanCooper9' => 'evan.cooper@rogers.com' }
  s.source           = { :git => 'https://github.com/EvanCooper9/ECKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  
  s.subspec 'Core' do |ss|
    ss.source_files = "ECKit/Core"
  end
  
  s.subspec 'Rx' do |ss|
    ss.source_files = "ECKit/Rx"
    ss.dependency 'RxDataSources'
  end
  
end
