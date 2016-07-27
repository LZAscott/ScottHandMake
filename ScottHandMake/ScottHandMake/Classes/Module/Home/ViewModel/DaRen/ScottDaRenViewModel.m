//
//  ScottDaRenViewModel.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottDaRenViewModel.h"
#import "ScottNetworkManager.h"
#import <YYModel.h>
#import "ScottDaRenModel.h"
#import "ScottURLConst.h"
#import <SVProgressHUD.h>

@interface ScottDaRenViewModel ()

@property (nonatomic, strong, readwrite) NSMutableArray *dareDataArr;
@property (nonatomic, copy) NSString *lastTime;

@end

@implementation ScottDaRenViewModel


- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete {
    NSAssert(complete, @"完成回调不能为空");
    [SVProgressHUD show];
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"vid"] = @"18";
    if (mark) { // 刷新
        params[@"act"] = @"up";
        [self.dareDataArr removeAllObjects];
    }else {
        params[@"act"] = @"down";
        params[@"last_id"] = self.lastTime;
    }
    
    [[ScottNetworkManager shareInstance] requestWithMethod:HTTPRequestMethodPost andURLString:ScottDarenURL andParam:params success:^(id response) {
        [SVProgressHUD dismiss];
        
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[ScottDaRenModel class] json:response[@"data"]];
        ScottDaRenModel *model = tempArr.lastObject;
        self.lastTime = model.course_time;
        [self.dareDataArr addObjectsFromArray:tempArr];
        
        !complete ? : complete(YES);
    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        !complete ? : complete(NO);
    }];
}

- (NSMutableArray *)dareDataArr {
    return _dareDataArr ? : (_dareDataArr = @[].mutableCopy);
}

@end
