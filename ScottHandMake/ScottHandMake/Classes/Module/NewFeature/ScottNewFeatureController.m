//
//  ScottNewFeatureController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottNewFeatureController.h"
#import "ScottNewFeatureCell.h"
#import "ScottNotificationNameConst.h"

@interface ScottNewFeatureController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ScottNewFeatureController

static NSString * const ScottNewFeatureReuseIdentifier = @"ScottNewFeatureReuseIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottNewFeatureCell class]) bundle:nil] forCellWithReuseIdentifier:ScottNewFeatureReuseIdentifier];
}


#pragma mark - 懒加载
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 设置cell的尺寸
        _flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
        
        // 设置每一行的间距
        _flowLayout.minimumLineSpacing = 0;
        
        // 设置每个cell的间距
        _flowLayout.minimumInteritemSpacing = 0;
        
        // 设置滚动方向
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
        // 取消弹簧效果
        _collectionView.bounces = NO;
        
        // 取消显示指示器
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        // 开启分页模式
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        NSMutableArray *mArr = [[NSMutableArray alloc] init];
        for (NSInteger i=1; i<6; i++) {
            NSString *imgName = [NSString stringWithFormat:@"newfeature_%02ld_736",i];
            [mArr addObject:imgName];
        }
        
        _dataArr = mArr.copy;
    }
    
    return _dataArr;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScottNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ScottNewFeatureReuseIdentifier forIndexPath:indexPath];
    cell.imageName = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArr.count-1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ScottSwitchRootViewControllerName object:self];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
