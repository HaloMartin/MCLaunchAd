//
//  ViewController.m
//  MCLaunchAd
//
//  Created by 朱进林 on 9/16/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import "ViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic) MCQuitLaunchAdStyle style;
@end

@implementation ViewController

-(instancetype)initWithLaunchStyle:(MCQuitLaunchAdStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    label.center = CGPointMake(screenWidth/2, screenHeight/2);
    label.text = NSLocalizedString(@"Welcome", nil);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:35.0];
    [self.view addSubview:label];
    //
    UILabel* subLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    subLabel.center = CGPointMake(screenWidth/2, screenHeight/2+label.bounds.size.height/2+subLabel.bounds.size.height/2);
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.textColor = [UIColor grayColor];
    subLabel.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:subLabel];
    //
    NSString* str = nil;
    if (self.style == MCQuitLaunchAdStyleTimeOut) {
        str = NSLocalizedString(@"广告时间耗尽", nil);
    }else if (self.style == MCQuitLaunchAdStyleSkip) {
        str = NSLocalizedString(@"跳过广告", nil);
    }else if (self.style == MCQuitLaunchAdStyleJumpToURL) {
        str = NSLocalizedString(@"进入广告链接", nil);
    }
    subLabel.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
