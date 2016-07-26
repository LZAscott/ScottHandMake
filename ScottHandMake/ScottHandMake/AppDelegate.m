//
//  AppDelegate.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "AppDelegate.h"
#import "ScottTabBarController.h"
#import "Macros.h"
#import "ScottNewFeatureController.h"
#import "ScottAdViewController.h"
#import "ScottNotificationNameConst.h"
#import "ScottAppDelegateHelp.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [self defaultViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchRootViewController:) name:ScottSwitchRootViewControllerName object:nil];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ScottSwitchRootViewControllerName object:nil];
}

- (UIViewController *)defaultViewController {
    // 获取当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 获取沙盒版本
    NSString *sandBoxVersionKey = @"sandBoxVersionKey";
    NSString *sandBoxVersion = [[NSUserDefaults standardUserDefaults] valueForKey:sandBoxVersionKey];
    
    // 将当前版本保存至沙盒
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:sandBoxVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (sandBoxVersion == nil || [currentVersion compare:sandBoxVersion] == NSOrderedDescending) {   // 新版本
        return [ScottNewFeatureController new];
    }else{
        return [ScottAdViewController new];
    }
}

- (void)switchRootViewController:(NSNotification *)noti {
    
    if (noti.object && [noti.object isKindOfClass:[ScottNewFeatureController class]]) {
        self.window.rootViewController = [ScottAdViewController new];
        CATransition *anim = [CATransition animation];
        anim.type = @"rippleEffect";
        anim.duration = 1;
        [self.window.layer addAnimation:anim forKey:nil];
        
        return;
    }
    
    self.window.rootViewController = [ScottTabBarController new];
}


- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
