
Pod::Spec.new do |s|
    s.name              = "pull-to-refresh"
    s.version           = "1.0.0"
    s.summary           = "An simple way to use pull-to-refresh and infinite scrolling functionalities with a UIScrollView category."
    s.description       = "An simple way to use pull-to-refresh and infinite scrolling functionalities with a UIScrollView category."
    s.homepage          = "https://github.com/eggswift/pull-to-refresh"

    s.license           = { :type => "MIT", :file => "LICENSE" }
    s.authors           = { "lihao" => "lihao_ios@hotmail.com"}
    s.social_media_url  = "https://github.com/eggswift/"
    s.platform          = :ios, "7.0"
    s.source            = {:git => "https://github.com/eggswift/pull-to-refresh.git", :tag => "1.0.0"}
    s.source_files      = 'ESPullToRefresh/**/*.{swift}'
    s.requires_arc      = true
end
