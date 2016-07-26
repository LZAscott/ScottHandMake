//
//  ScottTabBarController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTabBarController.h"
#import "ScottNavigationController.h"
#import "ScottHomeController.h"
#import "ScottTurotialController.h"
#import "ScottHandController.h"
#import "ScottFairController.h"
#import "ScottMeController.h"
#import "Macros.h"
#import "ScottNotificationNameConst.h"

@interface ScottTabBarController ()

@end

@implementation ScottTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.tabBar.tintColor = ScottAppearanceBgColor;
    
    [self addAllChildControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldClickTurotialVC) name:ScottClickHotSubjectNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ScottClickHotSubjectNotification object:nil];
}

- (void)addAllChildControllers {
    
    [self addOneChildController:[ScottHomeController new] andTitle:@"首页" andImageName:@"tabbar_home_n" andSelectImgName:@"tabbar_home_h"];
    
    [self addOneChildController:[ScottTurotialController new] andTitle:@"教程" andImageName:@"tabbar_tutoria_n" andSelectImgName:@"tabbar_tutoria_h"];
    
    [self addOneChildController:[ScottHandController new] andTitle:@"手工圈" andImageName:@"tabbar_hand_n" andSelectImgName:@"tabbar_hand_h"];
    
    [self addOneChildController:[ScottFairController new] andTitle:@"市集" andImageName:@"tabbar_fair_n" andSelectImgName:@"tabbar_fair_h"];
    
    [self addOneChildController:[ScottMeController new] andTitle:@"我的" andImageName:@"tabbar_me_n" andSelectImgName:@"tabbar_me_h"];
}

- (void)addOneChildController:(UIViewController *)vc andTitle:(NSString *)title andImageName:(NSString *)imgName andSelectImgName:(NSString *)selectImageName {

    vc.tabBarItem.image = [UIImage imageNamed:imgName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    vc.title = title;
    
    ScottNavigationController *nav = [[ScottNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}


- (void)shouldClickTurotialVC {
    for (UIViewController *controller in self.childViewControllers) {
        if ([controller isKindOfClass:[ScottNavigationController class]]) {
            ScottNavigationController *vc = (ScottNavigationController *)controller;
            if ([vc.topViewController isKindOfClass:[ScottTurotialController class]]) {
                ScottTurotialController *turoVC = (ScottTurotialController *)vc.topViewController;
                turoVC.fromChooseVC = YES;
            }
        }
    }
    self.selectedIndex = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
