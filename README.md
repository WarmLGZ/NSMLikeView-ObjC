
NSMLikeView 视频直播的点赞动画视图。

## Features
- 简单易用而且效果很棒!
- 支持自定义的点赞图片。

## Requirements

- iOS 8.0 or later
- Xcode 7.3 or later

## Installation

### Podfile
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'NSMLikeView'
end
```

然后执行以下命令:

```bash
$ pod install
```

## Getting Started

```objective-c
NSArray *randomImages = @[@"NSMLiveLikeGreenFace", @"NSMLiveLikeGreenHeart", @"NSMLiveLikeGreenStar", @"NSMLiveLikeRedFace", @"NSMLiveLikeRedHeart", @"NSMLiveLikeRedStar", @"NSMLiveLikeYellowFace", @"NSMLiveLikeYellowHeart", @"NSMLiveLikeYellowStar"];

CGFloat heartSize = 32.0;
NSMLikeView *likeView = [NSMLikeView viewWithRandomImages:randomImages];
[likeView masterAnimateInView:CGRectMake(CGRectGetWidth(self.view.bounds) - heartSize / 2.0 - 100.0, CGRectGetHeight(self.view.bounds) / 3.0 - heartSize / 2.0, 100.0, CGRectGetHeight(self.view.bounds) / 1.5)];
[self.view addSubview:likeView];


## Author

liguozhi, liguozhi@xinpianchang.com

## License

NSMLikeView is available under the MIT license. See the LICENSE file for more info.
