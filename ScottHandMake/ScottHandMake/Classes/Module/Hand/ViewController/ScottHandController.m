//
//  ScottHandController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottHandController.h"
#import <VTMagicController.h>
#import "ScottHandPublicController.h"
#import "ScottHandMenuModel.h"

@interface ScottHandController ()<VTMagicViewDataSource,VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSArray *menuArray;

@end

@implementation ScottHandController

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor redColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDefault;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    
    [self.magicController.magicView setHeaderHidden:NO duration:0.0];
    [self integrateComponents];
    
    [self.magicController.magicView reloadData];
}

- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBACOLOR(169, 37, 37, 0.6) forState:UIControlStateSelected];
    [rightButton setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateNormal];
    [rightButton setTitle:@"+" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    rightButton.center = self.view.center;
    self.magicController.magicView.rightNavigatoinItem = rightButton;
}

- (void)subscribeAction {
    
}

- (NSArray *)menuArray {
    if (!_menuArray) {
        NSArray *tempArr = @[@"综合圈",@"布艺",@"皮艺",@"木艺",@"编织",@"饰品",@"文艺",@"刺绣",@"模型",@"羊毛毡",@"橡皮章",@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺",@"文玩设计",@"玉石琥珀",@"游泳池",@"沙龙活动",@"古风首饰",@"服装裁剪",@"以物易物",@"亲子手工",@"护肤美妆",@"人形娃娃",@"拼布",@"滴胶热缩圈",@"首饰",@"串珠",@"手帐",@"金工",@"绕线"];
        
        NSMutableArray *mMenuArray = @[].mutableCopy;
        
        for (NSInteger i=0; i<tempArr.count; i++) {
            NSString *title = tempArr[i];
            ScottHandMenuModel *model = [ScottHandMenuModel menuInfoWithTitl:title];
            [mMenuArray addObject:model];
        }
        
        _menuArray = mMenuArray.copy;
    }
    return _menuArray;
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
    static NSString *reusableIden = @"handPublic.identifier";
    ScottHandPublicController *handPublicVC = [magicView dequeueReusablePageWithIdentifier:reusableIden];
    if (!handPublicVC) {
        handPublicVC = [[ScottHandPublicController alloc] init];
    }
    
    return handPublicVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
