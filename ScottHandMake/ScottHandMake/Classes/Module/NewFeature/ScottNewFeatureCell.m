//
//  ScottNewFeatureCell.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottNewFeatureCell.h"

@interface ScottNewFeatureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ScottNewFeatureCell


- (void)setImageName:(NSString *)imageName {
    NSAssert(imageName, @"图片名字不能为空");
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
