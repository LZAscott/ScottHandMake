//
//  ScottMeController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottMeController.h"
#import "ScottComposeTypeView.h"
#import "ScottComposeType.h"
#import "UIView+ScottRuntime.h"
#import <objc/runtime.h>

@interface ScottMeController ()

@end

@implementation ScottMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.tabBarItem.badgeValue = @"new";
    UIView *resultView = [UIView scott_firstInView:self.tabBarController.tabBar clazzName:@"_UIBadgeBackground"];
    [resultView scott_ivarsList];
    [resultView setValue:[UIImage imageNamed:@"main_badge"] forKey:@"_image"];
}

- (void)btnClick {
    ScottComposeTypeView *composeTypeView = [[ScottComposeTypeView alloc] initWithSelectComposeType:^(ScottComposeType *type) {
        NSLog(@"%@--%@--%@",type.title, type.icon, type.actionName);
        if (type.controllerName != nil) {
            Class cls = NSClassFromString(type.controllerName);
            
            // 判断类名是否存在
            if (cls == nil) {
                return;
            }
            
            UIViewController *vc = [[cls alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }];
    
    
    [composeTypeView showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
