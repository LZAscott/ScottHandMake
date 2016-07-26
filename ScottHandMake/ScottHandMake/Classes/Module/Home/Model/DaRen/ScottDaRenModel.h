//
//  ScottDaRenModel.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottDaRenModel : NSObject

@property (nonatomic,copy) NSString *nick_name;
@property (nonatomic,copy) NSString *course_count;
@property (nonatomic,copy) NSString *video_count;
@property (nonatomic,copy) NSString *opus_count;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic,copy) NSString *tb_url;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *course_time;

@end
