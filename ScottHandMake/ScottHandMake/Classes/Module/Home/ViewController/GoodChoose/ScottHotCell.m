//
//  ScottHotCell.m
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottHotCell.h"
#import "ScottHotTopicModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ScottHotCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ScottHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(ScottHotTopicModel *)model {
    _model = model;
    
    self.titleLabel.text = _model.subject;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"1"]];
}

@end
