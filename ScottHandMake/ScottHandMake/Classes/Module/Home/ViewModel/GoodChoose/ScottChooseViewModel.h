//
//  ScottChooseViewModel.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScottChooseModel;
@interface ScottChooseViewModel : NSObject

@property (nonatomic, strong) ScottChooseModel *chooseModel;

- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete;

@end
