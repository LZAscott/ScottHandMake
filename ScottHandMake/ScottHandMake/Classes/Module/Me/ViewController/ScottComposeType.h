//
//  ScottComposeType.h
//  ScottHandMake
//
//  Created by Scott on 16/7/25.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottComposeType : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;
/// 图片名
@property (nonatomic, copy) NSString *icon;
/// 点击事件
@property (nonatomic, copy) NSString *actionName;
/// 跳转的控制器名
@property (nonatomic, copy) NSString *controllerName;


+ (NSArray *)composeTypeList;

@end
