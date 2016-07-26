//
//  UIColor+ScottExtension.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ScottExtension)

/// 将16进制颜色值转换成RGB对应的颜色
+ (UIColor *)scott_colorWithHexString:(NSString *)hexString;

@end
