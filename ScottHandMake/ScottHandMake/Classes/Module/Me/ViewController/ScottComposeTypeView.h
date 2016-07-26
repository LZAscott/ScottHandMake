//
//  ScottComposeTypeView.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/25.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScottComposeType;

typedef void(^ScottComposeTypeBlock)(ScottComposeType *type);

@interface ScottComposeTypeView : UIView

/// 构造函数
///
/// @param composeBlock 完成的回调
- (instancetype)initWithSelectComposeType:(ScottComposeTypeBlock)composeBlock;

/// 显示
///
/// @param view 指定的view上显示
- (void)showInView:(UIView *)view;

@end
