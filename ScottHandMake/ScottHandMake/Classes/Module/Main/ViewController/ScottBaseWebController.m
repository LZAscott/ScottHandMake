//
//  ScottBaseWebController.m
//  ScottHandMake
//
//  Created by Scott_Mr on 16/7/23.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottBaseWebController.h"
#import "Macros.h"
#import "ScottSlideModel.h"
#import "ScottURLConst.h"
#import <SVProgressHUD.h>
#import "ScottHotTopicModel.h"
#import "ScottRefreshHeader.h"

@interface ScottBaseWebController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ScottRefreshHeader *refreshHeader;


@end

@implementation ScottBaseWebController


// TODO: 为什么用WKWebView就不行呢？

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refreshHeader = [ScottRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    self.webView.scrollView.mj_header = _refreshHeader;
}

- (void)reloadData {
    [self.webView reload];
}

- (void)setSlideModel:(ScottSlideModel *)slideModel {
    _slideModel = slideModel;
    
    if ([slideModel.itemtype isEqualToString: @"event"]) {
        [self loadRequestWithURL:[NSURL URLWithString:@"http:www.baidu.com"] andTitle:@"代替"];
    }else if ([slideModel.itemtype isEqualToString:@"class_special"]) {
        NSString *urlString = [NSString stringWithFormat: @"%@?m=HandClass&a=%@&spec_id=%@",ScottSpecialURL,slideModel.itemtype,slideModel.hand_id];
        [self loadRequestWithURL:[NSURL URLWithString:urlString] andTitle:@"课堂专题"];
    }else if ([slideModel.itemtype isEqualToString:@"topic_detail_h5"]){
        NSURL *url = [NSURL URLWithString:slideModel.hand_id];
        [self loadRequestWithURL:url andTitle:@"专题详情"];
    }else if ([slideModel.itemtype isEqualToString:@"event"]){
        NSString *urlString = [NSString stringWithFormat: @"%@?c=Competition&cid=%@",ScottChooseURL,slideModel.hand_id];
        [self loadRequestWithURL:[NSURL URLWithString:urlString] andTitle:@""];
    }
}

- (void)setHotTopicModel:(ScottHotTopicModel *)hotTopicModel {
    _hotTopicModel = hotTopicModel;
    
    if (hotTopicModel.mob_h5_url.length) {
        [self loadRequestWithURL:[NSURL URLWithString:hotTopicModel.mob_h5_url] andTitle:@"专题详情"];
    }
}

- (void)loadRequestWithURL:(NSURL *)url andTitle:(NSString *)title {

    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.navigationItem.title = title;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.refreshHeader beginRefreshing];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.refreshHeader endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self.refreshHeader endRefreshing];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
