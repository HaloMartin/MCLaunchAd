//
//  MCCountingView.h
//  MCLaunchAd
//
//  Created by 朱进林 on 9/19/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCountingButton : UIButton
@property (nonatomic) NSInteger totalTime;//总时长，单位秒
@property (nonatomic) NSInteger tickTockInterval;//计数单位，表示两次计数间的时间间隔，单位毫秒

-(instancetype)initWithFrame:(CGRect)frame;
-(void)counting;
@end
