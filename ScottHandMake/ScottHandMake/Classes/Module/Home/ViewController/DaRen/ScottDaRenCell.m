//
//  ScottDaRenCell.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottDaRenCell.h"
#import "ScottDaRenModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ScottDaRenCell ()


@property (weak, nonatomic) IBOutlet UIImageView *advanImv;
@property (weak, nonatomic) IBOutlet UIButton *foucsBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *firstImv;
@property (weak, nonatomic) IBOutlet UIImageView *secondImv;
@property (weak, nonatomic) IBOutlet UIImageView *threeImv;

@property (nonatomic, strong) NSArray *picArray;


@end

@implementation ScottDaRenCell

- (void)awakeFromNib {
    self.foucsBtn.layer.cornerRadius = 5;
    self.foucsBtn.layer.borderWidth = 1;
    
    self.advanImv.layer.cornerRadius = 25;
    self.advanImv.layer.masksToBounds = YES;
    
    self.picArray = @[self.firstImv,self.secondImv,self.threeImv];
}

- (IBAction)foucsBtnClick:(UIButton *)sender {
    !self.btnClickBlock ? : self.btnClickBlock(sender);
}

- (void)setModel:(ScottDaRenModel *)model {
    _model = model;

    NSURL *iconUrl = [NSURL URLWithString:_model.avatar];
    [self.advanImv sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"1"]];
    self.titleLabel.text = _model.nick_name;
    NSString *subStr = [NSString stringWithFormat:@"%@图文教程|%@视频教程|%@手工圈",_model.course_count,_model.video_count,_model.opus_count];
    self.subTitleLabel.text = subStr;
    
    NSInteger i = 0;
    for (NSDictionary *dict in _model.list) {
        NSString *handID =  dict[@"hand_id"];
        NSString *picUrl = dict[@"host_pic"];
        [self setupImgView:self.picArray[i] withPicUrl:picUrl andTag:[handID integerValue]];
        i ++;
    }
}

- (void)setupImgView:(UIImageView *)imgView withPicUrl:(NSString *)url andTag:(NSInteger)tag {
    
    NSAssert(url, @"图片url为空");
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"1"]];
    imgView.userInteractionEnabled = YES;
    imgView.tag = tag;
    
    UITapGestureRecognizer *tapGs = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
    [imgView addGestureRecognizer:tapGs];
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap {
    UIImageView *imgView = (UIImageView *)[tap view];
    !self.darenImageClickBlock ? : self.darenImageClickBlock(imgView.tag);
}

@end
