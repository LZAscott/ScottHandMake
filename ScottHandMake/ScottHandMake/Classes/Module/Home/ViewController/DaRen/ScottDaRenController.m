//
//  ScottDaRenController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottDaRenController.h"
#import "Macros.h"
#import "ScottDaRenViewModel.h"
#import "ScottDaRenCell.h"
#import <SVProgressHUD.h>
#import "ScottDaRenModel.h"
#import "ScottRefreshHeader.h"
#import "ScottRefreshFooter.h"

@interface ScottDaRenController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ScottDaRenViewModel *darenViewModel;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ScottDaRenController

- (ScottDaRenViewModel *)darenViewModel {
    return _darenViewModel ? : (_darenViewModel = [[ScottDaRenViewModel alloc] init]);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
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
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottDaRenCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottDaRenCell class])];
    
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
    [self.darenViewModel loadDataIsPull:YES andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_header endRefreshing];
        
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"加载数据失败！！"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

- (void)loadMoreData {
    [self.darenViewModel loadDataIsPull:NO andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_footer endRefreshing];
        
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"加载数据失败！！"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.darenViewModel.dareDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    ScottDaRenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottDaRenCell class]) forIndexPath:indexPath];
    ScottDaRenModel *model = self.darenViewModel.dareDataArr[indexPath.row];
    cell.model = model;
    
    cell.btnClickBlock = ^(UIButton *btn){
    
    };
    
    cell.darenImageClickBlock = ^(NSInteger tag){
    
    };

    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 200);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
