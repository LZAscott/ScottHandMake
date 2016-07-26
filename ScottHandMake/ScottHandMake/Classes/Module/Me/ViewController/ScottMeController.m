//
//  ScottMeController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottMeController.h"
#import "ScottComposeTypeView.h"
#import "ScottComposeType.h"

@interface ScottMeController ()

@end

@implementation ScottMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
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
