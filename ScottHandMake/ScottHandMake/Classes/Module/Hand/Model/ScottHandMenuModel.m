//
//  ScottHandMenuModel.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottHandMenuModel.h"

@implementation ScottHandMenuModel

+ (instancetype)menuInfoWithTitl:(NSString *)title {
    return [self menuInfoWithTitl:title andID:@""];
}

+ (instancetype)menuInfoWithTitl:(NSString *)title andID:(NSString *)ID {
    ScottHandMenuModel *menu = [[ScottHandMenuModel alloc] init];
    menu.infoID = ID;
    menu.name = title;
    return menu;
}

@end
