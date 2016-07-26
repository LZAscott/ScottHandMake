//
//  ScottDaRenViewModel.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottDaRenViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *dareDataArr;


- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete;

@end
