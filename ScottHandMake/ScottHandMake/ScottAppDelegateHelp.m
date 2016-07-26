//
//  ScottAppDelegateHelp.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottAppDelegateHelp.h"
#import "Macros.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <SVProgressHUD.h>

@implementation ScottAppDelegateHelp

+ (void)load {
    
    [self p_setupAppearance];
    
    [self p_setupAFNetworking];
    
    [self p_setupHUD];
}

/// 设置主题颜色
+ (void)p_setupAppearance {
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    appearance.barTintColor = ScottAppearanceBgColor;
    appearance.tintColor = [UIColor whiteColor];
}

+ (void)p_setupAFNetworking {
    // 启用状态栏指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 设置缓存
    [NSURLCache setSharedURLCache:[[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil]];
}

+ (void)p_setupHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
}

@end
