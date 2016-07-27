//
//  ScottNavigationController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottNavigationController.h"
#import "UIBarButtonItem+ScottExtension.h"

@interface ScottNavigationController ()

@end

@implementation ScottNavigationController

- (UIViewController *)childViewControllerForStatusBarStyle {

    return self.topViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        // 判断子控制器的数量
        NSString *title = @"返回";
        
        if (self.childViewControllers.count == 1) {
            title = self.childViewControllers.firstObject.title;
        }
        
        // 隐藏底部的 TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
