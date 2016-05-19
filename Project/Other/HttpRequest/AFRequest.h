//
//  AFRequest.h
//  Project
//
//  Created by zhcpeng on 16/3/17.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface AFRequest : AFHTTPSessionManager

+ (instancetype)sharedClient;

+ (NSURLSessionDataTask *)postWithURL:(NSString *)url parameters:(NSDictionary *)parameters Block:(void (^)(NSDictionary *response, NSError *error))block;

@end
