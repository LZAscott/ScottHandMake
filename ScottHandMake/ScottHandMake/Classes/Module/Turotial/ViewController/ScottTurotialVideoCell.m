//
//  ScottTurotialVideoCell.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialVideoCell.h"
#import "ScottTurotialVideoModel.h"
#import <UIImageView+WebCache.h>

@interface ScottTurotialVideoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImv;

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;


@end

@implementation ScottTurotialVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ScottTurotialVideoModel *)model {
    _model = model;
    
    NSURL *bgImageUrl = [NSURL URLWithString:model.host_pic];
    [self.backgroundImv sd_setImageWithURL:bgImageUrl placeholderImage:[UIImage imageNamed:@"1"]];
    [self.titleBtn setTitle:model.subject forState:UIControlStateNormal];
}

@end
