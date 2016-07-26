//
//  ScottDaRenCell.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScottImageClickBlock)(NSInteger tag);
typedef void(^ScottFoucsBtnClickBlock)(UIButton *btn);

@class ScottDaRenModel;
@interface ScottDaRenCell : UICollectionViewCell

@property (nonatomic, strong) ScottDaRenModel *model;

@property (nonatomic, copy) ScottImageClickBlock darenImageClickBlock;
@property (nonatomic, copy) ScottFoucsBtnClickBlock btnClickBlock;

@end
