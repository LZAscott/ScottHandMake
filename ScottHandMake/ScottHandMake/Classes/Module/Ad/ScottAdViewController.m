//
//  ScottAdViewController.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottAdViewController.h"
#import "ScottNotificationNameConst.h"
#import "Macros.h"

@interface ScottAdViewController ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation ScottAdViewController

- (void)dealloc {
    ScottLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(doNext) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)doNext {
    [UIView animateWithDuration:0.3f animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        self.imageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ScottSwitchRootViewControllerName object:self];
    }];
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.frame = [UIScreen mainScreen].bounds;
        _imageView.image = [UIImage imageNamed:@"ad"];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
