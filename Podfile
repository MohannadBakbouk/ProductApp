source 'https://github.com/CocoaPods/Specs.git' 
platform :ios, '13.0'

def appPods
   pod 'Alamofire'
   pod 'RxSwift'
   pod 'RxCocoa'
   pod 'Kingfisher'
   pod 'RealmSwift'
   pod 'EasyPeasy'
   pod 'RxDataSources'
end

target 'ProductApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ProductApp
   appPods
  target 'ProductAppTests' do
    inherit! :search_paths
    # Pods for testing
    appPods
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'ProductAppUITests' do
    # Pods for testing
  end

end
