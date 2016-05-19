//
//  HJKHttpServer.h
//  HuiMaiHealth
//
//  Created by yanglijun on 14-9-17.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import "AFHTTPClient.h"
#import "JSONKit.h"

@interface HMHttpServer : AFHTTPClient

+ (HMHttpServer *)sharedClient;
+ (NSString *)getOauthSignature:(NSString *)urlString;
+ (NSString *)UrlEncoding:(NSString *)urlStr;
#pragma mark 返回适应接口的参数字典
+ (NSDictionary *)getDictionary:(NSDictionary *)dict;
@end
