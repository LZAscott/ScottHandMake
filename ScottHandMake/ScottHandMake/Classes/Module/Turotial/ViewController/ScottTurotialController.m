//
//  ScottTurotialController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialController.h"
#import <HMSegmentedControl.h>
#import "Macros.h"
#import "ScottTurotialPicController.h"
#import "ScottTurotialVideoController.h"
#import "ScottTurotialSubjectController.h"
#import "UIView+ScottExtension.h"

@interface ScottTurotialController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl *segmentCtrl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat picOffY;
@property (nonatomic, assign) CGFloat videoOffY;
@property (nonatomic, assign) CGFloat subOffY;

@end

@implementation ScottTurotialController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentCtrl;
    
    [self setAddAllChildController];
    [self.view addSubview:self.scrollView];
    
    if (self.isFromeChooseVC) {
        self.segmentCtrl.selectedSegmentIndex = 2;
        [self segmentedControlChangedValue:self.segmentCtrl];
    }
}

- (void)setFromChooseVC:(BOOL)fromChooseVC {
    _fromChooseVC = fromChooseVC;
}

- (void)setAddAllChildController {
    [self addChildViewController:[ScottTurotialPicController new]];
    [self addChildViewController:[ScottTurotialVideoController new]];
    [self addChildViewController:[ScottTurotialSubjectController new]];
}

#pragma mark - segmentController event
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentCtrl {
    //控制器view的滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = segmentCtrl.selectedSegmentIndex * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

//结束滚动时动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //计算当前控制器View索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //取出子控制器
    UIViewController *viewVc = self.childViewControllers[index];
    viewVc.view.x = scrollView.contentOffset.x;
    
    [scrollView addSubview:viewVc.view];
}

// 滚动减速时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];

    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    self.segmentCtrl.selectedSegmentIndex = index;
}

- (HMSegmentedControl *)segmentCtrl {
    if (!_segmentCtrl) {
        _segmentCtrl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"图文", @"视频", @"专题"]];
        _segmentCtrl.frame = CGRectMake(10, 20, 200, 44);
        _segmentCtrl.shouldAnimateUserSelection = YES;
        _segmentCtrl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        _segmentCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        _segmentCtrl.verticalDividerEnabled = YES;
        _segmentCtrl.verticalDividerColor = [UIColor lightGrayColor];
        _segmentCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentCtrl.backgroundColor = [UIColor clearColor];
        [_segmentCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtrl;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;//分页
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * self.childViewControllers.count , 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        // 添加第一个控制器的view
        [self scrollViewDidEndScrollingAnimation:_scrollView];
        
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
