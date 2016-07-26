//
//  ScottTurotialPicCell.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/24.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottTurotialPicCell.h"
#import "ScottTurotialPicModel.h"
#import <UIImageView+WebCache.h>
#import "UIColor+ScottExtension.h"

@interface ScottTurotialPicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImv;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ScottTurotialPicCell

- (void)awakeFromNib {
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
}

- (void)setModel:(ScottTurotialPicModel *)model {
    _model = model;
    
    NSURL *bgUrl = [NSURL URLWithString:model.host_pic];
    [self.backgroundImv sd_setImageWithURL:bgUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.titleLabel.text = model.subject;
    self.nameLabel.text = [NSString stringWithFormat:@"by %@",model.user_name];
    self.bgView.backgroundColor = [UIColor scott_colorWithHexString:model.host_pic_color];
    self.countLabel.text = [NSString stringWithFormat:@"%@人气/%@收藏",model.view,model.collect];
}

@end
