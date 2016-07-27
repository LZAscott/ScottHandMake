//
//  ScottAdvanceCell.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottAdvanceCell.h"
#import "ScottNavigationModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ScottAdvanceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ScottAdvanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ScottNavigationModel *)model {
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"1"]];
}

@end
