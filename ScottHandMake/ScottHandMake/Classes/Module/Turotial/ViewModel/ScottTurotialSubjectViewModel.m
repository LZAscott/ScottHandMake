//
//  ScottTurotailSubjectViewModel.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialSubjectViewModel.h"
#import "ScottURLConst.h"
#import <YYModel.h>
#import "ScottNetworkManager.h"
#import "ScottTurotialSubjectModel.h"
#import <SVProgressHUD.h>

@interface ScottTurotialSubjectViewModel ()

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;
@property (nonatomic, copy) NSString *lastID;
@property (nonatomic, strong) NSURLSessionTask *task;


@end

@implementation ScottTurotialSubjectViewModel

- (void)loadDataIsPull:(BOOL)mark andInfoID:(NSString *)infoID andComplete:(void(^)(BOOL isSuccessed))complete {
    
    [SVProgressHUD show];
    
    // 1.添加参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"c"] = @"Shiji";
    params[@"a"] = @"topicListS";
    params[@"vid"] = @"18";
    params[@"page"] = @"material";
    params[@"tag_id"] = infoID;
    
    if (mark) {
        [self.dataArray removeAllObjects];
    }else{
        params[@"last_id"] = self.lastID;
    }

    _task = [[ScottNetworkManager shareInstance] requestWithMethod:HTTPRequestMethodGet andURLString:ScottChooseURL andParam:params success:^(id response) {
        [SVProgressHUD dismiss];
        
        NSArray *tempArr = [NSArray yy_modelArrayWithClass:[ScottTurotialSubjectModel class] json:response[@"data"]];
        ScottTurotialSubjectModel *model = tempArr.lastObject;
        self.lastID = model.last_id;
        [self.dataArray addObjectsFromArray:tempArr];
        
        !complete ? : complete(YES);
    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        !complete ? : complete(NO);
    }];
}

- (void)cancelRequest {
    [self.task cancel];
}

- (NSMutableArray *)dataArray {
    return _dataArray ? : (_dataArray = @[].mutableCopy);
}

@end
