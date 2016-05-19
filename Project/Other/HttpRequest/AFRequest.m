//
//  AFRequest.m
//  Project
//
//  Created by zhcpeng on 16/3/17.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "AFRequest.h"


static NSString * const AFAppDotNetAPIBaseURLString = @"http://www.xcar.com.cn";


@implementation AFRequest

+ (instancetype)sharedClient {
    static AFRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFRequest alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}




@end
