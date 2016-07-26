//
//  ScottTurotialPicModel.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottTurotialPicModel : NSObject

/// 背景颜色
@property (nonatomic, copy) NSString *bg_color;
/// 收藏
@property (nonatomic, copy) NSString *collect;

@property (nonatomic, copy) NSString *hand_id;

/// 背景图片
@property (nonatomic, copy) NSString *host_pic;
/// 背景图片颜色
@property (nonatomic, copy) NSString *host_pic_color;
/// 下一页标记
@property (nonatomic, copy) NSString *last_id;
/// 标题
@property (nonatomic, copy) NSString *subject;
/// 用户id
@property (nonatomic, copy) NSString *user_id;
/// 昵称
@property (nonatomic, copy) NSString *user_name;
/// 人气
@property (nonatomic, copy) NSString *view;


@end
