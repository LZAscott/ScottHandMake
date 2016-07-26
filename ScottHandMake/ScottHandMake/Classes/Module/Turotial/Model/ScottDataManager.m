//
//  ScottDataManager.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/25.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottDataManager.h"

@interface ScottDataManager ()

@property (nonatomic, strong) NSMutableDictionary *dataInfo;

@end

@implementation ScottDataManager

+ (instancetype)sharedInstance
{
    static ScottDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.dataInfo = [[NSMutableDictionary alloc] init];
    });
    return sharedManager;
}

- (void)savePageInfo:(NSArray *)infoList menuId:(NSString *)menuId
{
    if (menuId) {
        [_dataInfo setObject:[NSArray arrayWithArray:infoList] forKey:menuId];
    }
}

- (NSArray *)pageInfoWithMenuId:(NSString *)menuId
{
    return [_dataInfo objectForKey:menuId];
}


@end
