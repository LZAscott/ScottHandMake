//
//  ScottNaviCell.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottNaviCell.h"
#import "ScottNavigationModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ScottNaviCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ScottNaviCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ScottNavigationModel *)model {
    _model = model;
    
    self.titleLabel.text = _model.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"1"]];
}

@end
