//
//  MCCountingView.h
//  MCLaunchAd
//
//  Created by 朱进林 on 9/19/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 带倒计时的跳过按钮
 *  初始化后需设置总时长和间隔时间
 */
@interface MCCountingButton : UIButton
@property (nonatomic) NSInteger totalTime;//总时长，单位秒
@property (nonatomic) NSInteger tickTockInterval;//计时间隔单位，表示两次计数间的时间间隔，单位毫秒

-(instancetype)initWithFrame:(CGRect)frame;
/**
 *  改变进度条末端位置，循环调用实现进度条刷新
 */
-(void)counting;
@end
