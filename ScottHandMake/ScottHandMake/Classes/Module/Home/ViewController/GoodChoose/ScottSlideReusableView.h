//
//  ScottSlideReusableView.h
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScottSlideModel;
typedef void(^ScottBannerClickBlock)(ScottSlideModel *model);

@interface ScottSlideReusableView : UICollectionReusableView

@property (nonatomic, copy) ScottBannerClickBlock bannerClickBlock;

@property (nonatomic, strong) NSArray *bannarArray;


@end
