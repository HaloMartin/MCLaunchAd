//
//  MCLaunchAdView.m
//  MCLaunchAd
//
//  Created by 朱进林 on 9/16/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import "MCLaunchAdView.h"
#import "MCCountingButton.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define TIMER_INTERVAL 0.04 //25帧每秒
#define SKIPBUTTONSIZE 30

#pragma mark - MCLaunchAdView
@interface MCLaunchAdView()
{
    MCCountingButton* _countingBtn;//跳过广告按钮
}
@property (nonatomic) MCAdViewType adViewtype;
@property (nonatomic, strong) UIImageView* adView;/*广告界面*/
@property (nonatomic) NSInteger adTime;//广告时长，默认6秒
@property (nonatomic) CGFloat adTimeLeft;/*剩余时间，用于计算时间是否耗尽*/
@property (nonatomic, strong) NSTimer* countTimer;/*计时器*/
@end

@implementation MCLaunchAdView

/*初始化*/
-(instancetype)initWithWindow:(UIWindow*)window with:(MCAdViewType)type
{
    self = [super init];
    if (self) {
        //
        self.window = window;
        [window makeKeyAndVisible];
        self.adViewtype = type;
        self.adTime = 6;//默认6秒，上层可设置
        self.adTimeLeft = self.adTime;
        [self initailView];
        [self.window addSubview:self];
    }
    return self;
}

-(void)initailView
{
    //广告界面
    {
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"adImage_lion.png"];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:imgView];
        self.adView = imgView;
        //添加点击广告监听
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToURL:)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tap];
    }
    //跳过按钮
    {
        MCCountingButton* countingBtn = [[MCCountingButton alloc] initWithFrame:CGRectMake(0, 0, SKIPBUTTONSIZE, SKIPBUTTONSIZE)];
        [countingBtn addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.adView addSubview:countingBtn];
        _countingBtn = countingBtn;
    }
}

-(void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    //根据不同的广告占屏比设置不同的布局
    if (self.adViewtype == MCAdViewTypeFullScreen) {
        self.adView.bounds = CGRectMake(0, 0, screenWidth, screenHeight);
    }else if (self.adViewtype == MCAdViewTypeHalfScreen) {
        self.adView.bounds = CGRectMake(0, 0, screenWidth, 2*screenHeight/3);
    }else if (self.adViewtype == MCAdViewTypeThreeQuarters) {
        self.adView.bounds = CGRectMake(0, 0, screenWidth, 3*screenHeight/4);
    }else if (self.adViewtype == MCAdViewTypeFiveSixths) {
        self.adView.bounds = CGRectMake(0, 0, screenWidth, 5*screenHeight/6);
    }else {
        self.adView.bounds = CGRectMake(0, 0, screenWidth, screenHeight);
    }
    self.adView.center = CGPointMake(screenWidth/2, self.adView.bounds.size.height/2);
    //跳过按钮的布局
    _countingBtn.center = CGPointMake(screenWidth-SKIPBUTTONSIZE/2-5, SKIPBUTTONSIZE/2+20);
    _countingBtn.tickTockInterval = TIMER_INTERVAL*1000;//设置计时间隔
    _countingBtn.totalTime = self.adTime;//设置总时长
}
/*设置计时器时长*/
-(void)setTimer:(NSInteger)time
{
    self.adTime = time;
    self.adTimeLeft = time;
}
/*启动计时器*/
-(void)startTimer
{
    //添加计时器
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(TickTock) userInfo:nil repeats:YES];
}
/*关闭计时器*/
-(void)closeTimer
{
    //关闭
    [self.countTimer invalidate];
    self.countTimer = nil;
}

#pragma mark - Action
/*过了一个计时单位TIMER_INTERVAL，检查剩余时间*/
-(void)TickTock
{
    if (self.adTimeLeft > 0) {
        //默认6秒，时间未耗尽，继续展示
        self.adTimeLeft = self.adTimeLeft - TIMER_INTERVAL;
        [_countingBtn counting];
    }else {
        //默认6秒，时间耗尽
        [self closeTimer];
        if (self.clickBlock) {
            self.clickBlock(MCQuitLaunchAdStyleTimeOut);
        }
    }
}
/*响应点击跳过按钮事件*/
-(void)skipButtonClicked:(UIButton*)btn
{
    [self closeTimer];
    if (self.clickBlock) {
        self.clickBlock(MCQuitLaunchAdStyleSkip);
    }
}
/*响应点击广告事件*/
-(void)jumpToURL:(UITapGestureRecognizer*)recognizer
{
    [self closeTimer];
    if (self.clickBlock) {
        self.clickBlock(MCQuitLaunchAdStyleJumpToURL);
    }
}
@end
