//
//  ScottActivityViewModel.h
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottActivityViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *activityDataArray;

- (void)loadDataIsPull:(BOOL)mark andComplete:(void(^)(BOOL isSuccessed))complete;

@end
