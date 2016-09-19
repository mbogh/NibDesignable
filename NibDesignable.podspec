Pod::Spec.new do |s|
  s.name = 'NibDesignable'
  s.version = '3.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Elegant way of enabling IBDesignable on your nib-based views'
  s.homepage = 'https://github.com/mbogh/NibDesignable'
  s.social_media_url = 'http://twitter.com/mbogh'
  s.authors = { 'Morten Bøgh' => 'morten@justabeech.com' }
  s.source = { :git => 'https://github.com/mbogh/NibDesignable.git', :tag => s.version.to_s }
  s.requires_arc = true

  s.ios.deployment_target = '8.0'

  s.source_files = 'NibDesignable.swift'
end
