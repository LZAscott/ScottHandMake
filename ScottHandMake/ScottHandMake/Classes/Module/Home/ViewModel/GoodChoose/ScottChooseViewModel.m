//
//  ScottChooseViewModel.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottChooseViewModel.h"
#import "ScottNetworkManager.h"
#import "ScottChooseModel.h"
#import "ScottNavigationModel.h"
#import "Macros.h"
#import <YYModel.h>
#import "ScottURLConst.h"
#import <SVProgressHUD.h>

@implementation ScottChooseViewModel

- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete {
    
    NSAssert(complete, @"完成回调不能为空");
    [SVProgressHUD show];
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"index";
    params[@"a"] = @"indexNewest";
    params[@"vid"] = @"18";
    
    [[ScottNetworkManager shareInstance] requestWithMethod:HTTPRequestMethodGet andURLString:ScottChooseURL andParam:params success:^(id response) {
        [SVProgressHUD dismiss];
        self.chooseModel = [ScottChooseModel yy_modelWithDictionary:response[@"data"]];
        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.chooseModel.navigation];
        [tempArr addObject:[self addNavigationModel]];
        
        self.chooseModel.navigation = tempArr.copy;
        
        !complete ? : complete(YES);

    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        ScottLog(@"%@",error);
        !complete ? : complete(NO);
    }];
}

/// 添加签到模型
- (ScottNavigationModel *)addNavigationModel {
    ScottNavigationModel *navigationModel = [[ScottNavigationModel alloc]init];
    navigationModel.pic = @"http://image.shougongke.com/app/index/navigation/appIndexNav12.png";
    navigationModel.name = @"签到";
    return navigationModel;
}

@end
