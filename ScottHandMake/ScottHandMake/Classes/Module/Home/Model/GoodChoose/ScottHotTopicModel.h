//
//  ScottHotTopicModel.h
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottHotTopicModel : NSObject

@property (nonatomic,copy) NSString *subject; // 标题
@property (nonatomic,copy) NSString *pic; // 背景图片
@property (nonatomic,copy) NSString *topic_id; // 标示符
@property (nonatomic,copy) NSString *topic_type; // 类型
@property (nonatomic,copy) NSString *mob_h5_url; // 链接

@end
