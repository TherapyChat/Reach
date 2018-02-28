Pod::Spec.new do |spec|
  spec.name     = 'Reach'
  spec.version  = '1.2.0'
  spec.summary  = 'Reachability network library.'
  spec.homepage = 'https://github.com/therapychat/Reach'
  spec.license  = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
  spec.authors  = { 'Sergio Fernandez' => 'fdzsergio@gmail.com' }
  spec.social_media_url = 'https://twitter.com/fdzsergio'

  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'
  spec.watchos.deployment_target = '2.0'

  spec.swift_version  = '4.0'
  spec.source_files   = 'Source/*.swift'
  spec.source         = { :git => "https://github.com/therapychat/Reach.git", :tag => spec.version.to_s }
  
  spec.ios.framework  = 'SystemConfiguration'
  spec.osx.framework  = 'SystemConfiguration'
  spec.tvos.framework = 'SystemConfiguration'

end
