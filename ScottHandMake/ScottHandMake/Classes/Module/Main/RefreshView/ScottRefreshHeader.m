//
//  ScottRefreshHeader.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottRefreshHeader.h"

@implementation ScottRefreshHeader

- (void)prepare {
    [super prepare];
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i=1; i<=10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"loading_%ld",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [mArr addObject:image];
    }
    
    [self setImages:mArr forState:MJRefreshStateIdle];
    [self setImages:mArr forState:MJRefreshStatePulling];
    [self setImages:mArr forState:MJRefreshStateRefreshing];
    
    self.automaticallyChangeAlpha = YES;
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    self.stateLabel.textColor = [UIColor  darkGrayColor];
}

@end
