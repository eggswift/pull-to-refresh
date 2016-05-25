
Pod::Spec.new do |s|
    s.name              = "ESPullToRefresh"
    s.version           = "1.0.3"
    s.summary           = "An easy way to use pull-to-refresh and loading-more"
    s.description       = "An easiest way to give pull-to-refresh and loading-more to any UIScrollView. Using swift!"
    s.homepage          = "https://github.com/eggswift/pull-to-refresh"

    s.license           = { :type => "MIT", :file => "LICENSE" }
    s.authors           = { "lihao" => "lihao_ios@hotmail.com"}
    s.social_media_url  = "https://github.com/eggswift/"
    s.platform          = :ios, "8.0"
    s.source            = {:git => "https://github.com/eggswift/pull-to-refresh.git", :tag => "1.0.3"}
    s.source_files      = 'ESPullToRefresh/**/*.{swift}'
    s.requires_arc      = true
end
