Pod::Spec.new do |s|
    s.name         = 'pull-to-refresh'
    s.version      = '1.0.0'
    s.summary      = 'An easy way to use pull-to-refresh and loading-more.'
    s.homepage     = 'https://github.com/eggswift/pull-to-refresh'
    s.license      = 'MIT'
    s.authors      = {'lihao' => 'lihao_ios@hotmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/eggswift/pull-to-refresh.git', :tag => s.version}
    s.source_files = 'ESPullToRefresh/**/*.{h,m}'
    s.resource     = ''
    s.requires_arc = true
end
