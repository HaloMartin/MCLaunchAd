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

@interface MCLaunchAdView()
{
    MCCountingButton* _countingBtn;
}
@property (nonatomic) MCAdViewType adViewtype;
@property (nonatomic, strong) UIImageView* adView;
@property (nonatomic) CGFloat adTimeLeft;
@property (nonatomic, strong) NSTimer* countTimer;
@end

@implementation MCLaunchAdView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithWindow:(UIWindow*)window with:(MCAdViewType)type
{
    self = [super init];
    if (self) {
        //
        self.window = window;
        [window makeKeyAndVisible];
        self.adViewtype = type;
        self.adTime = 6;
        self.adTimeLeft = self.adTime;
        [self initailView];
        [self.window addSubview:self];
    }
    return self;
}

-(void)initailView
{
    //
    UIImageView* imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"adImage_lion.png"];
    imgView.contentMode = UIViewContentModeScaleToFill;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToURL:)];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:tap];
    [self addSubview:imgView];
    self.adView = imgView;
    //
    MCCountingButton* countingBtn = [[MCCountingButton alloc] initWithFrame:CGRectMake(0, 0, SKIPBUTTONSIZE, SKIPBUTTONSIZE)];
    [countingBtn addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.adView addSubview:countingBtn];
    _countingBtn = countingBtn;
}

-(void)layoutSubviews
{
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    //
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
    //
    _countingBtn.center = CGPointMake(screenWidth-SKIPBUTTONSIZE/2-5, SKIPBUTTONSIZE/2+20);
    _countingBtn.tickTockInterval = TIMER_INTERVAL*1000;
    _countingBtn.totalTime = self.adTime;
    //
    self.skipButton.bounds = CGRectMake(0, 0, SKIPBUTTONSIZE, SKIPBUTTONSIZE);
    self.skipButton.center = _countingBtn.center;
    self.skipButton.layer.cornerRadius = SKIPBUTTONSIZE/2.0;
    //
    [self startTimer];
}

-(void)startTimer
{
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(TickTock) userInfo:nil repeats:YES];
}

-(void)TickTock
{
    if (self.adTimeLeft > 0) {
        //时间未耗尽，继续展示
        self.adTimeLeft = self.adTimeLeft - TIMER_INTERVAL;
        [_countingBtn counting];
    }else {
        //时间耗尽
        [self closeTimer];
        if (self.clickBlock) {
            self.clickBlock(MCQuitLaunchAdStyleTimeOut);
        }
    }
}

-(void)closeTimer
{
    [self.countTimer invalidate];
    self.countTimer = nil;
}

#pragma mark - Action
-(void)skipButtonClicked:(UIButton*)btn
{
    [self closeTimer];
    if (self.clickBlock) {
        self.clickBlock(MCQuitLaunchAdStyleSkip);
    }
}
-(void)jumpToURL:(UITapGestureRecognizer*)recognizer
{
    [self closeTimer];
    if (self.clickBlock) {
        self.clickBlock(MCQuitLaunchAdStyleJumpToURL);
    }
}
@end
