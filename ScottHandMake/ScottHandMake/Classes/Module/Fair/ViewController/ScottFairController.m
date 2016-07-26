//
//  ScottFairController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottFairController.h"
#import "Macros.h"
#import <HMSegmentedControl.h>

@interface ScottFairController ()

@property (nonatomic, strong) HMSegmentedControl *segmentCtrl;


@end

@implementation ScottFairController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = self.segmentCtrl;
}

#pragma mark - 
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentCtrl {
    
}


- (HMSegmentedControl *)segmentCtrl {
    if (!_segmentCtrl) {
        _segmentCtrl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"材料", @"成品"]];
        _segmentCtrl.frame = CGRectMake(10, 20, 150, 44);
        _segmentCtrl.shouldAnimateUserSelection = YES;
        _segmentCtrl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        _segmentCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        _segmentCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentCtrl.backgroundColor = ScottSegmentColor;
        [_segmentCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        //        [self.view addSubview:_segmentCtrl];
    }
    return _segmentCtrl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
