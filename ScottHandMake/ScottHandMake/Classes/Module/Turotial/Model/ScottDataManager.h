//
//  ScottDataManager.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/25.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottDataManager : NSObject


/// 数据管理对象单例
+ (instancetype)sharedInstance;


/// 保存页面数据
///
/// @param infoList 页面数据
/// @param menuId   菜单id
- (void)savePageInfo:(NSArray *)infoList menuId:(NSString *)menuId;

/// 根据menuId获取相应页面的数据
///
/// @param menuId 菜单id
///
/// @return 页面数据，可为nil
- (NSArray *)pageInfoWithMenuId:(NSString *)menuId;

@end
