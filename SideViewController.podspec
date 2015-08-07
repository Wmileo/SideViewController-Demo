Pod::Spec.new do |s|
  s.name         = "SideViewController"
  s.version      = "0.0.3"
  s.summary      = "SideViewController"

  s.description  = <<-DESC
                   SideViewController

                   DESC

  s.homepage     = "https://github.com/Wmileo/SideViewController-Demo"
  s.license      = "MIT"
  s.author             = { "ileo" => "work.mileo@gmail.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/Wmileo/SideViewController-Demo.git", :tag => "0.0.3" }
  s.source_files  = "SideViewController-Demo/SideViewController-Demo/SideViewController.{h,m}"
 # s.framework  = "UIKit"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
end
