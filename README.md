# JGCache

[![CI Status](http://img.shields.io/travis/李保君/JGCache.svg?style=flat)](https://travis-ci.org/李保君/JGCache)
[![Version](https://img.shields.io/cocoapods/v/JGCache.svg?style=flat)](http://cocoapods.org/pods/JGCache)
[![License](https://img.shields.io/cocoapods/l/JGCache.svg?style=flat)](http://cocoapods.org/pods/JGCache)
[![Platform](https://img.shields.io/cocoapods/p/JGCache.svg?style=flat)](http://cocoapods.org/pods/JGCache)

## Example

``` swift


class UserModel: Mappable {

    var id:String = ""
    var name:String = ""

    init() {}
        required init?(map: Map) {

    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

let userDefault = UserModel.init()
userDefault.id = "我是default的id"
userDefault.name = "我是default的name"
//写入缓存
if JGCacheManager.default.writeCacheModel(object: userDefault) {
    print("👉userDefault write Successful")
}
else {
    print("👉userDefault write failure")
}


//读取缓存
if let userDefault = JGCacheManager.default.getCacheModel(class: UserModel.self) {
    print("👉userDefault get id -> \(userDefault.id);name -> \(userDefault.name)")
}
else {
    print("👉userDefault get nil")
}

//移除缓存
if JGCacheManager.default.removeCacheModel(class: UserModel.self) {
    print("👉userDefault remove Successful")
}
else {
    print("👉userDefault remove failure")
}
```

## Requirements

The Basics -> ObjectMapper

## Installation

JGCache is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JGCache'
```

## Author

李保君, lbj147123@163.com

## License

JGCache is available under the MIT license. See the LICENSE file for more info.
