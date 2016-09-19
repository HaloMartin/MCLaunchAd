//
//  MCLaunchAdView.h
//  MCLaunchAd
//
//  Created by 朱进林 on 9/16/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MCAdViewType) {
    MCAdViewTypeFullScreen = 0,//全屏
    MCAdViewTypeHalfScreen,//半屏
    MCAdViewTypeThreeQuarters,//四分之三屏
    MCAdViewTypeFiveSixths,//六分之五屏
};
typedef NS_ENUM(NSUInteger, MCQuitLaunchAdStyle) {
    MCQuitLaunchAdStyleDefault = 0,
    MCQuitLaunchAdStyleTimeOut,//时间耗尽
    MCQuitLaunchAdStyleSkip,//跳过广告
    MCQuitLaunchAdStyleJumpToURL,//进入广告
};
typedef void (^MCClick) (NSInteger tag);
@interface MCLaunchAdView : UIView

@property (nonatomic, strong) UIImageView* adImageView;
@property (nonatomic, strong) UIWindow* window;
@property (nonatomic) NSInteger adTime;//广告时长，默认6秒
@property (nonatomic, strong) UIButton* skipButton;//跳过广告页面
@property (nonatomic, strong) NSString* localAdImage;//本地图片名
@property (nonatomic, strong) NSString* urlAdImage;//网络图片名
@property (nonatomic, copy) MCClick clickBlock;//块回调，处理不同的操作

//-(instancetype)initWithFrame:(CGRect)frame with:(MCAdViewType)type;
-(instancetype)initWithWindow:(UIWindow*)window with:(MCAdViewType)type;
@end
