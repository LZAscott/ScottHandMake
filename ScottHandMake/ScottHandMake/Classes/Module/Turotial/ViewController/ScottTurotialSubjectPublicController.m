//
//  ScottTurotialSubjectPublicController.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialSubjectPublicController.h"
#import <VTMagicController.h>
#import "ScottHandMenuModel.h"
#import "ScottTurotialSubjectPublicCell.h"
#import "ScottTurotialSubjectViewModel.h"
#import "Macros.h"
#import <SVProgressHUD.h>
#import "ScottTurotialSubjectModel.h"
#import "ScottDataManager.h"

@interface ScottTurotialSubjectPublicController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ScottTurotialSubjectViewModel *subjectViewModel;

@end

@implementation ScottTurotialSubjectPublicController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerCell];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self refreshPageIfNeeded];
    self.collectionView.scrollsToTop = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.collectionView.scrollsToTop = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[ScottDataManager sharedInstance] savePageInfo:self.subjectViewModel.dataArray menuId:self.menuModel.infoID];
}

#pragma mark - VTMagicReuseProtocol
- (void)vtm_prepareForReuse {
    [self.subjectViewModel.dataArray removeAllObjects];
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero];
}

- (void)registerCell {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottTurotialSubjectPublicCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottTurotialSubjectPublicCell class])];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subjectViewModel.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScottTurotialSubjectPublicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottTurotialSubjectPublicCell class])forIndexPath:indexPath];
    ScottTurotialSubjectModel *model = self.subjectViewModel.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)refreshPageIfNeeded {
    NSTimeInterval currentStamp = [[NSDate date] timeIntervalSince1970];
    
    if (currentStamp - self.menuModel.lastTime < 60 * 60) {
        return;
    }
    
    self.menuModel.lastTime = currentStamp;
    [self handleNetworkSuccess];
}

- (void)handleNetworkSuccess {
    [self.subjectViewModel loadDataIsPull:YES andInfoID:self.menuModel.infoID andComplete:^(BOOL isSuccessed) {
        if (!isSuccessed) {
            
            [SVProgressHUD showInfoWithStatus:@"网络请求失败"];
            return ;
        }
        [self.collectionView reloadData];
    }];
}

- (void)setMenuModel:(ScottHandMenuModel *)menuModel {
    _menuModel = menuModel;
    
    [self loadLocalData];
}

- (void)loadLocalData {
    NSArray *cacheList = [[ScottDataManager sharedInstance] pageInfoWithMenuId:self.menuModel.infoID];
    [self.subjectViewModel.dataArray addObjectsFromArray:cacheList];
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, kFitHeight(247));
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight-(kNavigationBarHeight+kStatusBarHeight+40));
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, kTabbarHeight, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (ScottTurotialSubjectViewModel *)subjectViewModel {
    return _subjectViewModel ? : (_subjectViewModel = [[ScottTurotialSubjectViewModel  alloc] init]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
