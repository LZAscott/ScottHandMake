//
//  ScottTurotialSubjectController.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialSubjectController.h"
#import "Macros.h"
#import <VTMagicController.h>
#import "ScottTurotialSubjectPublicController.h"
#import "ScottHandMenuModel.h"
#import "UIView+ScottRuntime.h"

@interface ScottTurotialSubjectController ()<VTMagicViewDataSource,VTMagicViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSArray *menuArray;


@end

@implementation ScottTurotialSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"市集专题";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    
    [self.magicController.magicView reloadData];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (ScottHandMenuModel *menu in self.menuArray) {
        [titleList addObject:menu.name];
    }
    return titleList;
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

#pragma mark - VTMagicViewDelegate
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    static NSString *reusableIden = @"subjectPublic.identifier";
    ScottTurotialSubjectPublicController *subjectPublicVC = [magicView dequeueReusablePageWithIdentifier:reusableIden];
    if (!subjectPublicVC) {
        subjectPublicVC = [[ScottTurotialSubjectPublicController alloc] init];
    }
    ScottHandMenuModel *model = self.menuArray[pageIndex];
    subjectPublicVC.menuModel = model;
    return subjectPublicVC;
}

#pragma mark - 懒加载
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor redColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.itemScale = 1.2;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        
        [_magicController.magicView setHeaderHidden:!self.isFromChooseVC duration:0];
    }
    return _magicController;
}

- (NSArray *)menuArray {
    if (!_menuArray) {
        NSArray *tempArr = @[@"好店排行榜",@"新手必买",@"折扣专区",@"手工客专享",@"木艺",@"皮艺",@"编织",@"绕线", @"手工护肤",@"厨艺多肉"];
        NSArray *infoID = @[@"64",@"61",@"51",@"12",@"15",@"10",@"19",@"29",@"24",@"23"];
        
        NSMutableArray *mMenuArray = @[].mutableCopy;
        
        for (NSInteger i=0; i<tempArr.count; i++) {
            NSString *title = tempArr[i];
            ScottHandMenuModel *model = [ScottHandMenuModel menuInfoWithTitl:title andID:infoID[i]];
            [mMenuArray addObject:model];
        }
        
        _menuArray = mMenuArray.copy;
    }
    return _menuArray;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
