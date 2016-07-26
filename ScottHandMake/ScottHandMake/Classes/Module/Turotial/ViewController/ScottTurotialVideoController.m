//
//  ScottTurotialVideoController.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialVideoController.h"
#import <DOPDropDownMenu.h>
#import "ScottTurotialVideoViewModel.h"
#import "ScottTurotialVideoCell.h"
#import "ScottRefreshHeader.h"
#import "ScottRefreshFooter.h"
#import "ScottTurotialVideoModel.h"
#import <SVProgressHUD.h>
#import "UIView+ScottExtension.h"
#import "Macros.h"
#import "ScottNotificationNameConst.h"

@interface ScottTurotialVideoController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DOPDropDownMenu *dropMenu;
@property (nonatomic, strong) ScottTurotialVideoViewModel *videoViewModel;


@property (nonatomic,copy) NSString *cate;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic, copy) NSString *page;

@end

@implementation ScottTurotialVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self setupRefresh];
}

- (void)registerCell {
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [self.dropMenu selectDefalutIndexPath];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottTurotialVideoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottTurotialVideoCell class])];
    
    self.cate = @"0";
    self.price = @"0";
    self.sort = @"1";
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
    self.page = @"1";
    
    [self.videoViewModel loadDataIsPull:YES andCate:self.cate andPage:self.page andSort:self.sort andPrice:self.price andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_header endRefreshing];
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        [self.collectionView reloadData];
    }];
}

- (void)loadMoreData {
    self.page = [NSString stringWithFormat:@"%d",[self.page intValue] + 1];
    [self.videoViewModel loadDataIsPull:NO andCate:self.cate andPage:self.page andSort:self.sort andPrice:self.price andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_footer endRefreshing];
        
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

- (void)loadData {
    [self.collectionView.mj_header beginRefreshing];
    [self loadNewData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videoViewModel.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScottTurotialVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottTurotialVideoCell class])forIndexPath:indexPath];
    ScottTurotialVideoModel *model = self.videoViewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - DOPDropDownMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.videoViewModel.allThing_tArray.count;
    }else if (column == 1){
        return self.videoViewModel.time_tArray.count;
    }else {
        return self.videoViewModel.hots_tArray.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.videoViewModel.allThing_tArray[indexPath.row];
    }else if (indexPath.column == 1){
        return self.videoViewModel.time_tArray[indexPath.row];
    }else {
        return self.videoViewModel.hots_tArray[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    if (column == 0) {
        if (row == 1) {
            return self.videoViewModel.twoSize_tArray.count;
        }else if (row == 2){
            return self.videoViewModel.threeSize_tArray.count;
        }else if (row == 3){
            return self.videoViewModel.fourSize_tArray.count;
        }
    }
    return 0;
    
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.row == 1) {
            return self.videoViewModel.twoSize_tArray[indexPath.item];
        }else if (indexPath.row == 2){
            return self.videoViewModel.threeSize_tArray[indexPath.item];
        }else if (indexPath.row == 3){
            return self.videoViewModel.fourSize_tArray[indexPath.item];
        }
    }
    return nil;
}

#pragma mark - DOPDropDownMenuDelegate
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.row == 1 && indexPath.item >= 0) {
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 1];
            [self loadData];}
        else if (indexPath.row == 2 && indexPath.item >= 0){
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 1 + self.videoViewModel.twoSize_tArray.count];
            [self loadData];}
        else if (indexPath.row == 3 && indexPath.item >= 0){
            self.cate =  [NSString stringWithFormat:@"%ld",indexPath.item + 3 + self.videoViewModel.twoSize_tArray.count];
            [self loadData];}
    }else if(indexPath.column == 1){
        if (indexPath.row >= 0) {
            self.price = [NSString stringWithFormat:@"%ld",indexPath.row];
            [self loadData];}
    }else{
        if (indexPath.row >= 0) {
            NSArray *orederS = @[@"1",@"0",@"2",@"3"];
            self.sort = orederS[indexPath.row];
            [self loadData];}
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, kFitHeight(247));
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        CGRect rect = CGRectMake(0, self.dropMenu.bottom, kScreenWidth, kScreenHeight-(kNavigationBarHeight+kStatusBarHeight+self.dropMenu.height));
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabbarHeight, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (DOPDropDownMenu *)dropMenu {
    if (!_dropMenu) {
        _dropMenu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:ScottDropMenuHeight];
        _dropMenu.delegate = self;
        _dropMenu.dataSource = self;
        [self.view addSubview:_dropMenu];
    }
    return _dropMenu;
}

- (ScottTurotialVideoViewModel *)videoViewModel {
    return _videoViewModel ? : (_videoViewModel = [[ScottTurotialVideoViewModel alloc] init]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
