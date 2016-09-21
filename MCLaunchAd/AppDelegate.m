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
    [view setTimer:10];
    [view startTimer];
    view.clickBlock = ^(MCQuitLaunchAdStyle tag){
        switch (tag) {
            case MCQuitLaunchAdStyleTimeOut:{
                NSLog(@"%@",NSLocalizedString(@"时间耗尽", nil));
                ViewController* vc = [[ViewController alloc] initWithLaunchStyle:MCQuitLaunchAdStyleTimeOut];
                vc.view.backgroundColor = [UIColor whiteColor];
                self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            }
                break;
            case MCQuitLaunchAdStyleSkip:{
                NSLog(@"%@",NSLocalizedString(@"跳过广告", nil));
                ViewController* vc = [[ViewController alloc] initWithLaunchStyle:MCQuitLaunchAdStyleSkip];
                vc.view.backgroundColor = [UIColor whiteColor];
                self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            }
                break;
            case MCQuitLaunchAdStyleJumpToURL:{
                NSLog(@"%@",NSLocalizedString(@"进入广告", nil));
                ViewController* vc = [[ViewController alloc] initWithLaunchStyle:MCQuitLaunchAdStyleJumpToURL];
                vc.view.backgroundColor = [UIColor whiteColor];
                self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            }
                break;
            default:{
                NSLog(@"%@",NSLocalizedString(@"未知原因", nil));
                ViewController* vc = [[ViewController alloc] initWithLaunchStyle:MCQuitLaunchAdStyleDefault];
                vc.view.backgroundColor = [UIColor whiteColor];
                self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            }
                break;
        }
    };
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
