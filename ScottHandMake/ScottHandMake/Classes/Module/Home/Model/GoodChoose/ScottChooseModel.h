//
//  ScottChooseModel.h
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottChooseModel : NSObject

/// 推荐
@property (nonatomic, strong) NSArray *advance;
/// 热帖
@property (nonatomic, strong) NSArray *hotTopic;
/// 直播
@property (nonatomic, strong) NSArray *navigation;
/// 轮播图
@property (nonatomic, strong) NSArray *slide;


@end
