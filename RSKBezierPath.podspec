Pod::Spec.new do |s|
  s.name          = 'RSKBezierPath'
  s.version       = '1.0.0'
  s.summary       = 'The type of object that represents a Bézier path.'
  s.description   = <<-DESC
                   The type of object that represents a Bézier path. RSKBezierPath provides the initializer to create a Bézier path with a rectangular path rounded at the specified corners and with the specified corner radii.
                   DESC
  s.homepage      = 'https://github.com/rsk-lab/RSKBezierPath'
  s.license       = { :type => 'RPL-1.5 / R.SK Lab Professional', :file => 'COPYRIGHT.md' }
  s.authors       = { 'Ruslan Skorb' => 'ruslan@rsk-lab.com' }
  s.source        = { :git => 'https://github.com/rsk-lab/RSKBezierPath.git', :tag => s.version.to_s }
  s.platform      = :ios, '10.0'
  s.swift_version = '5.3'
  s.source_files  = 'RSKBezierPath/*.{h,swift}'
  s.requires_arc  = true
end
