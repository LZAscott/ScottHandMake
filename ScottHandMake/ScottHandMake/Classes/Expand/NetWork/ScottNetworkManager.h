//
//  ScottNetworkManager.h
//  ScottHandMake
//
//  Created by bopeng on 16/7/22.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^ScottNetworkSeccuessBlock)(id response);
typedef void(^ScottNetworkFailBlcok) (NSError *error);

typedef NS_ENUM(NSInteger, HTTPRequestMethod) {
    HTTPRequestMethodGet,
    HTTPRequestMethodPost,
};

@interface ScottNetworkManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

- (NSURLSessionTask *)requestWithMethod:(HTTPRequestMethod)method andURLString:(NSString *)url andParam:(id)param success:(ScottNetworkSeccuessBlock)successBlock fail:(ScottNetworkFailBlcok)failBlock;

@end
