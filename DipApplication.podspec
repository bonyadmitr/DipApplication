Pod::Spec.new do |s|
    s.name                  = 'DipApplication'
    s.version               = '1.0.0'
    s.summary               = 'DI for Apllication in Swift'
    s.homepage              = 'https://github.com/bonyadmitr/DipApplication'
    s.author                = { 'Bondar Yaroslav' => 'bonyadmitr@gmail.com' }
    s.license               = { :type => "MIT", :file => "LICENSE.md" }
    s.ios.deployment_target = '8.0'
    s.source                = {:git => '#{s.homepage}.git', :tag => "#{s.version}" }
    s.source_files          = 'DipApplication/*.swift'
end