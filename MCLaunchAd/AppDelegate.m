//
//  AppDelegate.m
//  MCLaunchAd
//
//  Created by 朱进林 on 9/16/16.
//  Copyright © 2016 Martin Choo. All rights reserved.
//

#import "AppDelegate.h"
#import "MCLaunchAdView.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     简书主页：http://www.jianshu.com/users/1bacae3170dd/latest_articles
     */
    /*添加广告
     1.初始化，选择屏占比
     2.设置广告总时长，可跳过，默认是6秒
     3.启动计时器
     */
//    MCLaunchAdView* view = [[MCLaunchAdView alloc] initWithWindow:self.window with:MCAdViewTypeFullScreen];
//    MCLaunchAdView* view = [[MCLaunchAdView alloc] initWithWindow:self.window with:MCAdViewTypeHalfScreen];
//    MCLaunchAdView* view = [[MCLaunchAdView alloc] initWithWindow:self.window with:MCAdViewTypeThreeQuarters];
    MCLaunchAdView* view = [[MCLaunchAdView alloc] initWithWindow:self.window with:MCAdViewTypeFiveSixths];
    //显示本地图片
//    view.localImageName = @"adImage_lion.png";
    //显示网络图片
    view.imageURL = @"http://imgsrc.baidu.com/forum/pic/item/65c1a9cc7b899e51371108904aa7d933c9950d56.jpg";
//    http://imgsrc.baidu.com/forum/pic/item/65c1a9cc7b899e51371108904aa7d933c9950d56.jpg
    [view setTimer:6];
    [view startTimer];
    view.clickBlock = ^(MCQuitLaunchAdStyle style){
//        //如果需要根据不同的style进入不同的viewController中时，可以在这里添加
//        switch (style) {
//            case MCQuitLaunchAdStyleTimeOut:{
//                NSLog(@"%@",NSLocalizedString(@"时间耗尽", nil));
//                style = MCQuitLaunchAdStyleTimeOut;
//            }
//                break;
//            case MCQuitLaunchAdStyleSkip:{
//                NSLog(@"%@",NSLocalizedString(@"跳过广告", nil));
//                style = MCQuitLaunchAdStyleSkip;
//            }
//                break;
//            case MCQuitLaunchAdStyleJumpToURL:{
//                NSLog(@"%@",NSLocalizedString(@"进入广告", nil));
//                style = MCQuitLaunchAdStyleJumpToURL;
//            }
//                break;
//            default:{
//                NSLog(@"%@",NSLocalizedString(@"未知原因", nil));
//                style = MCQuitLaunchAdStyleDefault;
//            }
//                break;
//        }
        ViewController* vc = [[ViewController alloc] initWithLaunchStyle:style];
        vc.view.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    };
    //打印mainbundle
    NSDictionary* dict = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@",dict);
    //
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
