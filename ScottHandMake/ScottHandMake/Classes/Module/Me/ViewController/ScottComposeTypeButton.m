//
//  ScottComposeTypeButton.m
//  ScottHandMake
//
//  Created by Scott on 16/7/25.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottComposeTypeButton.h"
#import "ScottComposeType.h"

@implementation ScottComposeTypeButton

- (void)setComposeType:(ScottComposeType *)composeType {
    _composeType = composeType;
    
    [self setTitle:composeType.title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:composeType.icon] forState:UIControlStateNormal];
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect imageRect = self.bounds;
    imageRect.size.height = imageRect.size.width;
    self.imageView.frame = imageRect;
    
    CGRect textRect = self.bounds;
    textRect.origin.y = textRect.size.width;
    textRect.size.height -= textRect.size.width;
    self.titleLabel.frame = textRect;
}

@end
