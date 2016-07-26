//
//  ScottTurotialVideoViewModel.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottTurotialVideoViewModel : NSObject

/// title数组
@property (nonatomic, strong, readonly) NSArray *allThing_tArray;
@property (nonatomic, strong, readonly) NSArray *twoSize_tArray;
@property (nonatomic, strong, readonly) NSArray *threeSize_tArray;
@property (nonatomic, strong, readonly) NSArray *fourSize_tArray;
@property (nonatomic, strong, readonly) NSArray *time_tArray;
@property (nonatomic, strong, readonly) NSArray *hots_tArray;


@property (nonatomic, strong, readonly) NSMutableArray *dataArray;


- (void)loadDataIsPull:(BOOL)mark andCate:(NSString *)cate andPage:(NSString *)page andSort:(NSString *)sort andPrice:(NSString *)price andComplete:(void(^)(BOOL isSuccessed))complete;

@end
