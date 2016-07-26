//
//  ScottChooseModel.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottChooseModel.h"
#import <YYModel.h>
#import "ScottAdvanceModel.h"
#import "ScottHotTopicModel.h"
#import "ScottNavigationModel.h"
#import "ScottSlideModel.h"

@implementation ScottChooseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"advance" : [ScottAdvanceModel class],
             @"hotTopic" : [ScottHotTopicModel class],
             @"navigation" : [ScottNavigationModel class],
             @"slide" : [ScottSlideModel class]
             };
}

@end
