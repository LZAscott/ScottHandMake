//
//  ScottTurotialPicController.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialPicController.h"
#import <DOPDropDownMenu.h>
#import "ScottNotificationNameConst.h"
#import "ScottTurotialPicViewModel.h"
#import "UIView+ScottExtension.h"
#import "Macros.h"
#import "ScottTurotialPicCell.h"
#import <SVProgressHUD.h>
#import "ScottTurotialPicModel.h"
#import "ScottRefreshHeader.h"
#import "ScottRefreshFooter.h"

@interface ScottTurotialPicController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DOPDropDownMenu *dropMenu;
@property (nonatomic, strong) ScottTurotialPicViewModel *picViewModel;

/// 分类
@property (nonatomic, copy) NSString *gacate;
/// 最热教程
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, copy) NSString *pubTime;

@end

@implementation ScottTurotialPicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCell];
    [self setupRefresh];
    
    
}

- (void)registerCell {
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [self.dropMenu selectDefalutIndexPath];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottTurotialPicCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottTurotialPicCell class])];
    
    self.order = @"hot";
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
    [self.picViewModel loadDataIsPull:YES andGacate:self.gacate andOrder:self.order andCateID:self.cateId andPubTime:self.pubTime andComplete:^(BOOL isSuccessed) {
        [self.collectionView.mj_header endRefreshing];
        
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        [self.collectionView reloadData];
    }];
}

- (void)loadMoreData {
    [self.picViewModel loadDataIsPull:NO andGacate:self.gacate andOrder:self.order andCateID:self.cateId andPubTime:self.pubTime andComplete:^(BOOL isSuccessed) {
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
    return self.picViewModel.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScottTurotialPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottTurotialPicCell class])forIndexPath:indexPath];
    ScottTurotialPicModel *model = self.picViewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - DOPDropDownMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    if (column == 0) {
        return self.picViewModel.allThing_tArray.count;
    }else if (column == 1){
        return self.picViewModel.time_tArray.count;
    }else {
        return self.picViewModel.hots_tArray.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        return self.picViewModel.allThing_tArray[indexPath.row];
    }else if (indexPath.column == 1){
        return self.picViewModel.time_tArray[indexPath.row];
    }else {
        return self.picViewModel.hots_tArray[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    if (column == 0) {
        if (row == 1) {
            return self.picViewModel.twoSize_tArray.count;
        }else if (row == 2){
            return self.picViewModel.threeSize_tArray.count;
        }else if (row == 3){
            return self.picViewModel.fourSize_tArray.count;
        }
    }
    return 0;

}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        if (indexPath.row == 1) {
            return self.picViewModel.twoSize_tArray[indexPath.item];
        }else if (indexPath.row == 2){
            return self.picViewModel.threeSize_tArray[indexPath.item];
        }else if (indexPath.row == 3){
            return self.picViewModel.fourSize_tArray[indexPath.item];
        }
    }
    return nil;
}

#pragma mark - DOPDropDownMenuDelegate
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    if (indexPath.column == 0) {
        self.gacate = @"cate";
        if (indexPath.row == 1 && indexPath.item >= 0) {
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 1];
            [self loadData];
        }else if (indexPath.row == 2 && indexPath.item >= 0){
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 1 + self.picViewModel.twoSize_tArray.count];
            [self loadData];
        }else if (indexPath.row == 3 && indexPath.item >= 0){
            self.cateId =  [NSString stringWithFormat:@"%ld",indexPath.item + 3 + self.picViewModel.twoSize_tArray.count];
            [self loadData];}
    }else if(indexPath.column == 1){
        if (indexPath.row == 1) {
            self.pubTime = @"month";
            [self loadNewData];
        }else if (indexPath.row == 2){
            self.pubTime = @"all";
            [self loadData];}
    }else{
        if (indexPath.row >= 0) {
            NSArray *orederS = @[@"hot",@"new",@"comment",@"collect",@"material",@"goods"];
            self.order = orederS[indexPath.row];
            [self loadData];
        }
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat W = (kScreenWidth - 30) / 2.0;
        layout.itemSize = CGSizeMake(W, W * 1.5);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
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

- (ScottTurotialPicViewModel *)picViewModel {
    return _picViewModel ? : (_picViewModel = [[ScottTurotialPicViewModel alloc] init]);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
