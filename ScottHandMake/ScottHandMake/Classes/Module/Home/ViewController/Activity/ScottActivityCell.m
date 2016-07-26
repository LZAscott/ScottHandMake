//
//  ScottActivityCell.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottActivityCell.h"
#import "ScottActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ScottActivityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ScottActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ScottActivityModel *)model {
    _model = model;
    
    NSURL *contUrl = [NSURL URLWithString:_model.m_logo];
    
    [self.imgView sd_setImageWithURL:contUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.timeLabel.text = [NSString stringWithFormat:@"征集作品时间:%@",_model.c_time];
    self.activityNameLabel.text = _model.c_name;
    
    if ([_model.c_status isEqualToString:@"1"]) {
        self.statusLabel.text = @"进行中";
        self.statusLabel.textColor = [UIColor blackColor];
    }else{
        self.statusLabel.text = @"已结束";
        self.statusLabel.textColor = [UIColor lightGrayColor];
    }

}

@end
