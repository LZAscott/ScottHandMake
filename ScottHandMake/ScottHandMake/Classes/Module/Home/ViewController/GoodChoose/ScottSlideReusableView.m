//
//  ScottSlideReusableView.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottSlideReusableView.h"
#import "ScottPageView.h"
#import "ScottSlideModel.h"

@interface ScottSlideReusableView ()

@property (nonatomic, strong) ScottPageView *pageView;

@end

@implementation ScottSlideReusableView

- (ScottPageView *)pageView {
    if (!_pageView) {
        _pageView = [[ScottPageView alloc] init];
        _pageView.time = 2.0;
    }
    return _pageView;
}

- (void)awakeFromNib {
    
    [self addSubview:self.pageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.pageView.frame = self.frame;
}


- (void)setBannarArray:(NSArray *)bannarArray {
    if (!bannarArray) return;
    _bannarArray = bannarArray;
    
    NSMutableArray *tempArr = @[].mutableCopy;
    
    for (ScottSlideModel *model in bannarArray) {
        [tempArr addObject:model.host_pic];
    }
    
    self.pageView.imageArr = tempArr;
    
    __weak typeof(self) weakSelf = self;
    self.pageView.imageClickBlock = ^(NSInteger index){
        __strong typeof(weakSelf)self = weakSelf;
        ScottSlideModel *model = self.bannarArray[index];
        !self.bannerClickBlock ? : self.bannerClickBlock(model);
    };
}


@end
