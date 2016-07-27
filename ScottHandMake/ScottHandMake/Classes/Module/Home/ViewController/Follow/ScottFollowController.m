//
//  ScottFollowController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottFollowController.h"
#import "Macros.h"
#import "ScottFollowViewModel.h"
#import "ScottBoundsLayout.h"

@interface ScottFollowController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ScottFollowViewModel *followViewModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ScottBoundsLayout *boundsLayout;


@end


@implementation ScottFollowController

- (ScottBoundsLayout *)boundsLayout {
    if (!_boundsLayout) {
        _boundsLayout = [[ScottBoundsLayout alloc] init];
        CGFloat W = kScreenWidth - 20;
        CGFloat originY = kScreenHeight - (kStatusBarHeight+kNavigationBarHeight-40);
        CGFloat H = originY / 3.0;
        _boundsLayout.itemSize = CGSizeMake(W, H);
    }
    return _boundsLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGRect originRect = self.view.bounds;
        originRect.size.height -= (kStatusBarHeight+kNavigationBarHeight+kTabbarHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:originRect collectionViewLayout:self.boundsLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (ScottFollowViewModel *)followViewModel {
    return _followViewModel ? : (_followViewModel = [[ScottFollowViewModel alloc] init]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.backgroundColor = (indexPath.section % 2 == 0) ? [UIColor orangeColor] : [UIColor cyanColor];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return CGSizeMake(kScreenWidth, 40);
    }
    return CGSizeZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
