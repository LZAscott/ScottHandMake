//
//  ScottTurotialVideoViewModel.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialVideoViewModel.h"
#import "ScottNetworkManager.h"
#import "ScottURLConst.h"
#import "ScottTurotialVideoModel.h"
#import <YYModel.h>
#import <SVProgressHUD.h>

@interface ScottTurotialVideoViewModel ()

/// title数组
@property (nonatomic, strong, readwrite) NSArray *allThing_tArray;
@property (nonatomic, strong, readwrite) NSArray *twoSize_tArray;
@property (nonatomic, strong, readwrite) NSArray *threeSize_tArray;
@property (nonatomic, strong, readwrite) NSArray *fourSize_tArray;
@property (nonatomic, strong, readwrite) NSArray *time_tArray;
@property (nonatomic, strong, readwrite) NSArray *hots_tArray;


@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;

@end

@implementation ScottTurotialVideoViewModel

- (void)loadDataIsPull:(BOOL)mark andCate:(NSString *)gacate andPage:(NSString *)page andSort:(NSString *)sort andPrice:(NSString *)price andComplete:(void(^)(BOOL isSuccessed))complete {
    
    [SVProgressHUD show];
    
    if (mark) { // 刷新
        page = @"1";
        [self.dataArray removeAllObjects];
    }

    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Handclass";
    params[@"a"] = @"videoList";
    params[@"cate"] = gacate;
    params[@"page"] = page;
    params[@"vid"] = @"18";
    params[@"sort"] = sort;
    params[@"price"] = price;
    
    [[ScottNetworkManager shareInstance] requestWithMethod:HTTPRequestMethodGet andURLString:ScottChooseURL andParam:params success:^(id response) {
        [SVProgressHUD dismiss];
        
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[ScottTurotialVideoModel class] json:response[@"data"]];

        [self.dataArray addObjectsFromArray:tempArr];
        
        !complete ? : complete(YES);
    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        !complete ? : complete(NO);
    }];
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    return _dataArray ? : (_dataArray = @[].mutableCopy);
}

- (NSArray *)allThing_tArray {
    if (!_allThing_tArray) {
        _allThing_tArray = @[@"全部分类",@"两个字",@"三个字",@"四个字"];
    }
    return _allThing_tArray;
}

- (NSArray *)twoSize_tArray {
    if (!_twoSize_tArray) {
        _twoSize_tArray = @[@"布艺",@"皮艺",@"纸艺",@"编织",@"饰品",@"木艺",@"刺绣",@"模型"];
    }
    return _twoSize_tArray;
}

- (NSArray *)threeSize_tArray {
    if (!_threeSize_tArray) {
        _threeSize_tArray = @[@"羊毛毡",@"橡皮章"];
    }
    return _threeSize_tArray;
}

- (NSArray *)fourSize_tArray {
    if (!_fourSize_tArray) {
        _fourSize_tArray = @[@"黏土陶艺",@"园艺多肉",@"手绘印刷",@"手工护肤",@"美食烘焙",@"旧物改造",@"滴胶热缩",@"电子科技",@"雕塑雕刻",@"金属工艺"];
    }
    return _fourSize_tArray;
}

- (NSArray *)time_tArray {
    if (!_time_tArray) {
        _time_tArray = @[@"全部视频",@"免费",@"付费"];
    }
    return _time_tArray;
}

- (NSArray *)hots_tArray {
    if (!_hots_tArray){
        _hots_tArray = @[@"最新更新",@"人气",@"收藏最多",@"材料包有售"];
    }
    return _hots_tArray;
}


@end
