//
//  UIBarButtonItem+ScottExtension.h
//  ScottHandMake
//
//  Created by Scott on 16/7/26.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ScottExtension)

+ (instancetype)scott_barButtonItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImgName target:(id)target action:(SEL)action;

@end
