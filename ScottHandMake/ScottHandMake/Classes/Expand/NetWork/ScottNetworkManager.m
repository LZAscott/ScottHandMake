//
//  ScottNetworkManager.m
//  ScottHandMake
//
//  Created by Scott on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "ScottNetworkManager.h"
#import "Macros.h"

@protocol ScottNetWorkManagerProxy <NSObject>

@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface ScottNetworkManager ()<ScottNetWorkManagerProxy>

@end

@implementation ScottNetworkManager

+ (instancetype)shareInstance {
    static ScottNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ScottNetworkManager alloc] initWithBaseURL:nil];
    });
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL {
    if (self = [super initWithBaseURL:baseURL]) {
        [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            ScottLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        }];
        
        [self.reachabilityManager startMonitoring];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
        [(AFJSONResponseSerializer *)self.responseSerializer setRemovesKeysWithNullValues:YES];
    }
    return self;
}

- (NSURLSessionTask *)requestWithMethod:(HTTPRequestMethod)method andURLString:(NSString *)url andParam:(id)param success:(ScottNetworkSeccuessBlock)successBlock fail:(ScottNetworkFailBlcok)failBlock {
    
    NSAssert(successBlock, @"成功回调不能为空");
    NSAssert(failBlock, @"失败回调不能为空");
    
    NSString *methodName = (method == HTTPRequestMethodGet) ? @"GET" : @"POST";
    
    NSURLSessionTask *task = [self dataTaskWithHTTPMethod:methodName URLString:url parameters:param uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id response) {
        if (successBlock) {
            successBlock(response);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
    }];
    
    [task resume];
    return task;
}

@end
