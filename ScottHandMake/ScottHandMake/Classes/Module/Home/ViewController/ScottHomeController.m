//
//  ScottHomeController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottHomeController.h"
#import <VTMagic.h>
#import "ScottChooseController.h"
#import "ScottFollowController.h"
#import "ScottDaRenController.h"
#import "ScottActivityController.h"

@interface ScottHomeController ()<VTMagicViewDataSource,VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ScottHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    
    [self.magicController.magicView setHeaderHidden:NO duration:0.0];
    [self.magicController.magicView reloadDataToPage:0];
}

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor redColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"精选",@"关注",@"达人",@"活动"];
    }
    return _titleArr;
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return self.titleArr;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.f];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    if (0 == pageIndex) {
        static NSString *recomId = @"choose.identifier";
        ScottChooseController *chooseVC = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!chooseVC) {
            chooseVC = [[ScottChooseController alloc] init];
        }
        return chooseVC;
    }else if (1 == pageIndex){
        static NSString *recomId = @"follow.identifier";
        ScottFollowController *followVC = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!followVC) {
            followVC = [[ScottFollowController alloc] init];
        }
        return followVC;
    }else if (2 == pageIndex){
        static NSString *recomId = @"daren.identifier";
        ScottDaRenController *darenVC = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!darenVC) {
            darenVC = [[ScottDaRenController alloc] init];
        }
        return darenVC;
    }
    
    static NSString *gridId = @"activity.identifier";
    ScottActivityController *activityVC = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!activityVC) {
        activityVC = [[ScottActivityController alloc] init];
    }
    return activityVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
