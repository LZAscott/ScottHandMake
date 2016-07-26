//
//  ScottChooseController.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottChooseController.h"
#import "Macros.h"
#import "ScottChooseViewModel.h"
#import "ScottNaviCell.h"
#import "ScottAdvanceCell.h"
#import "ScottHotCell.h"
#import "ScottRefreshHeader.h"
#import "ScottRefreshFooter.h"
#import <SVProgressHUD.h>
#import "ScottChooseModel.h"
#import "ScottChooseModel.h"
#import "ScottAdvanceModel.h"
#import "ScottHotTopicModel.h"
#import "ScottNavigationModel.h"
#import "ScottSlideModel.h"
#import "ScottSlideReusableView.h"
#import "ScottHotTopicReusableView.h"
#import "ScottBaseWebController.h"
#import "ScottTurotialSubjectController.h"
#import "ScottNotificationNameConst.h"
#import "ScottBaseWebController.h"

@interface ScottChooseController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ScottChooseViewModel *chooseViewModel;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ScottChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCell];
    [self requestData];
}

- (void)requestData {
    [self.chooseViewModel loadDataIsPull:YES andComplete:^(BOOL isSuccessed) {
        if (!isSuccessed) {
            [SVProgressHUD showInfoWithStatus:@"数据请求失败"];
            return ;
        }
        
        [self.collectionView reloadData];
    }];
}

- (void)registerCell {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottNaviCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottNaviCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottAdvanceCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottAdvanceCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottHotCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ScottHotCell class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottSlideReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ScottSlideReusableView class])];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScottHotTopicReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ScottHotTopicReusableView class])];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.chooseViewModel.chooseModel.navigation.count;
    }else if (section == 1){
        return self.chooseViewModel.chooseModel.advance.count;
    }
    return self.chooseViewModel.chooseModel.hotTopic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScottNaviCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottNaviCell class]) forIndexPath:indexPath];
        ScottNavigationModel *model = self.chooseViewModel.chooseModel.navigation[indexPath.row];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 1) {
        ScottAdvanceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottAdvanceCell class]) forIndexPath:indexPath];
        ScottNavigationModel *model = self.chooseViewModel.chooseModel.advance[indexPath.row];
        cell.model = model;
        return cell;
    }
    
    ScottHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ScottHotCell class]) forIndexPath:indexPath];
    ScottHotTopicModel *model = self.chooseViewModel.chooseModel.hotTopic[indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ScottSlideReusableView *slideView = (ScottSlideReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ScottSlideReusableView class]) forIndexPath:indexPath];
        slideView.bannarArray = self.chooseViewModel.chooseModel.slide;
        
        slideView.bannerClickBlock = ^(ScottSlideModel *model){

            if ([model.itemtype isEqualToString: @"class_special"] || [model.itemtype isEqualToString:@"topic_detail_h5"] || [model.itemtype isEqualToString: @"event"]) {
                ScottBaseWebController *webVC = [[ScottBaseWebController alloc] init];
                webVC.slideModel = model;
                [self.navigationController pushViewController:webVC animated:YES];
            }
        };
        
        return slideView;
    }else if(indexPath.section == 2){
        ScottHotTopicReusableView *topicView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ScottHotTopicReusableView class]) forIndexPath:indexPath];
        
        return topicView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {       // 看视频、玩直播、秒杀、签到
        
    }else if (indexPath.section == 1) {  // 新手入门、每日热门课程
        if (indexPath.row == 0) {
            ScottTurotialSubjectController *vc = [[ScottTurotialSubjectController alloc] init];
            vc.fromChooseVC = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){  // 热门专题
            [[NSNotificationCenter defaultCenter] postNotificationName:ScottClickHotSubjectNotification object:nil];
        }
    }else if (indexPath.section == 2){
        ScottBaseWebController *webViewController = [[ScottBaseWebController alloc] init];
        ScottHotTopicModel *model = self.chooseViewModel.chooseModel.hotTopic[indexPath.row];
        webViewController.hotTopicModel = model;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat W = kScreenWidth / (self.chooseViewModel.chooseModel.navigation.count + 0.8);
        return CGSizeMake(W, W);
    }else if(indexPath.section == 1) {
        return CGSizeMake(kScreenWidth * 0.48,kScreenWidth * 0.4);
    }else{
        return CGSizeMake(kScreenWidth, kScreenWidth * 0.5);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeZero;
    
    if (section == 0) {
        size = CGSizeMake(kScreenWidth, kScreenHeight * 0.25);
    }else if (section == 2){
        size = CGSizeMake(kScreenWidth, 40);
    }
    
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return CGSizeMake(kScreenWidth, 40);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 先旋转45度
    CATransform3D rotation = CATransform3DMakeRotation(M_PI_4, 0.0, 0.7, 0.4);
    // 缩小
    rotation = CATransform3DScale(rotation,0.8, 0.8, 1.0);
    
    rotation.m34 = 1.0/100.0;
    
    cell.layer.shadowColor = [UIColor redColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);

    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:nil];
    
    [UIView setAnimationDuration:0.5f];
    
    cell.layer.transform = CATransform3DIdentity;
    cell.layer.shadowOffset = CGSizeZero;
    
    [UIView commitAnimations];
}

#pragma mark - 懒加载
- (ScottChooseViewModel *)chooseViewModel {
    return _chooseViewModel ? : (_chooseViewModel = [[ScottChooseViewModel alloc] init]);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGRect originRect = self.view.bounds;
        originRect.size.height -= (kStatusBarHeight+kNavigationBarHeight+kTabbarHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:originRect collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
