//
//  ScottTurotialSubjectPublicCell.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialSubjectPublicCell.h"
#import "ScottTurotialSubjectModel.h"
#import <UIImageView+WebCache.h>

@interface ScottTurotialSubjectPublicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImv;

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@end

@implementation ScottTurotialSubjectPublicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ScottTurotialSubjectModel *)model {
    _model = model;
    
    NSURL *bgImageUrl = [NSURL URLWithString:model.pic];
    [self.backgroundImv sd_setImageWithURL:bgImageUrl placeholderImage:[UIImage imageNamed:@"1"]];
    [self.titleBtn setTitle:model.subject forState:UIControlStateNormal];
}

@end
