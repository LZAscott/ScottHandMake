//
//  ScottActivityController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottActivityController.h"
#import "Macros.h"
#import "ScottActivityViewModel.h"
#import "ScottActivityCell.h"
#import <SVProgressHUD.h>
#import "ScottActivityModel.h"
#import "ScottRefreshHeader.h"
#import "ScottRefreshFooter.h"

@interface ScottActivityController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ScottActivityViewModel *activityViewModel;
@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation ScottActivityController

- (ScottActivityViewModel *)activityViewModel {
    return _activityViewModel ? : (_activityViewModel = [[ScottActivityViewModel alloc] init]);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        CGRect originRect = self.view.bounds;
        originRect.size.height -= (kStatusBarHeight+kNavigationBarHeight+kTabbarHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:originRect collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottActivityCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottActivityCell class])];
    
    [self setupRefresh];
    
    
}

- (void)setupRefresh {
    ScottRefreshHeader *refreshHeader = [ScottRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 添加下拉刷新
    self.collectionView.mj_header = refreshHeader;
    [self.collectionView.mj_header beginRefreshing];
    
    // 添加上拉加载
    self.collectionView.mj_footer = [ScottRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData {
    [self.activityViewModel loadDataIsPull:YES andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_header endRefreshing];
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

- (void)loadMoreData {
    [self.activityViewModel loadDataIsPull:NO andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_footer endRefreshing];
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.activityViewModel.activityDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScottActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottActivityCell class]) forIndexPath:indexPath];
    ScottActivityModel *model = self.activityViewModel.activityDataArray[indexPath.row];
    cell.model = model;
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, kFitHeight(200));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
