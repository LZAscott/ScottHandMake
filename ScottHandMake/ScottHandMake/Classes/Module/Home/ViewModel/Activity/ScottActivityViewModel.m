//
//  ScottActivityViewModel.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottActivityViewModel.h"
#import "ScottNetworkManager.h"
#import <YYModel/YYModel.h>
#import "ScottActivityModel.h"
#import "ScottURLConst.h"
#import <SVProgressHUD.h>

@interface ScottActivityViewModel ()

@property (nonatomic, strong, readwrite) NSMutableArray *activityDataArray;
@property (nonatomic, copy) NSString *lastID;

@end

@implementation ScottActivityViewModel

- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete {
    NSAssert(complete, @"完成回调不能为空");
    [SVProgressHUD show];
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Course";
    params[@"a"] = @"activityList";
    params[@"vid"] = @"18";
    if (mark) { // 刷新
        [self.activityDataArray removeAllObjects];
    }else{
        params[@"id"] = self.lastID;
    }
    
    [[ScottNetworkManager shareInstance] requestWithMethod:HTTPRequestMethodGet andURLString:ScottChooseURL andParam:params success:^(id response) {
        [SVProgressHUD dismiss];
        
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[ScottActivityModel class] json:response[@"data"]];
        ScottActivityModel *lastModel = tempArr.lastObject;
        self.lastID = lastModel.id;
        [self.activityDataArray addObjectsFromArray:tempArr];
        !complete ? : complete(YES);
    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        !complete ? : complete(NO);
    }];
}

- (NSMutableArray *)activityDataArray {
    return _activityDataArray ? : (_activityDataArray = @[].mutableCopy);
}

@end
