//
//  ScottTurotailSubjectViewModel.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottTurotialSubjectViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *dataArray;

//- (void)cancelRequest;
- (void)loadDataIsPull:(BOOL)mark andInfoID:(NSString *)infoID andComplete:(void(^)(BOOL isSuccessed))complete;

@end
