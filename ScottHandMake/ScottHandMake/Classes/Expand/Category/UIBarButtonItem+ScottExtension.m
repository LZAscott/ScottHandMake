//
//  UIBarButtonItem+ScottExtension.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/26.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "UIBarButtonItem+ScottExtension.h"

@implementation UIBarButtonItem (ScottExtension)

+ (instancetype)scott_barButtonItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImgName target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName != nil) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImgName != nil) {
        [btn setImage:[UIImage imageNamed:selectImgName] forState:UIControlStateHighlighted];
    }
    
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [btn sizeToFit];
    
    // 监听方法
    if (action != nil) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }

    return [[self alloc] initWithCustomView:btn];
}

@end
