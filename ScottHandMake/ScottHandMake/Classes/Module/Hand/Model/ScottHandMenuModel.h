//
//  ScottHandMenuModel.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottHandMenuModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *infoID;
@property (nonatomic, assign) NSTimeInterval lastTime;

+ (instancetype)menuInfoWithTitl:(NSString *)title;

+ (instancetype)menuInfoWithTitl:(NSString *)title andID:(NSString *)ID;

@end
