//
//  HTTPManager.m
//  XCar6
//
//  Created by ZhangAimin on 14/9/10.
//  Copyright (c) 2014年 爱卡汽车. All rights reserved.
//

#import "XCarHTTPClient.h"
//#import "XCarCacheManager.h"
//#import <tingyunApp/NBSAppAgent.h>

@interface XCarHTTPClient ()
@property (nonatomic, assign) NSInteger requestCount;
@end

@implementation XCarHTTPClient

+(instancetype)shareClient{
    static XCarHTTPClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@"http://my.xcar.com.cn/app/6/"];
        _shareClient = [[XCarHTTPClient alloc]initWithBaseURL:baseUrl];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        _shareClient.responseSerializer = responseSerializer;
        _shareClient.requestSerializer.timeoutInterval = 25;
        [_shareClient.requestSerializer setHTTPShouldHandleCookies:NO];
        [_shareClient.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    });
    if ([UserDao sharedUser].isLogin){
        [_shareClient.requestSerializer setValue:[UserDao sharedUser].cookieId forHTTPHeaderField:@"Cookie"];
    }else{
        [_shareClient.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
    }
    return _shareClient;
}
//12298 # by whq at 20151113 begin
//
+(instancetype)shareClient:(NSString *)cookie{
    static XCarHTTPClient *_shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:@"http://my.xcar.com.cn/app/6/"];
        _shareClient = [[XCarHTTPClient alloc]initWithBaseURL:baseUrl];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        _shareClient.responseSerializer = responseSerializer;
        _shareClient.requestSerializer.timeoutInterval = 25;
        [_shareClient.requestSerializer setHTTPShouldHandleCookies:NO];
        [_shareClient.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    });
    
    [_shareClient.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    //  if ([UserDao sharedUser].isLogin){
    //    [_shareClient.requestSerializer setValue:[UserDao sharedUser].cookieId forHTTPHeaderField:@"Cookie"];
    //  }else{
    //    [_shareClient.requestSerializer setValue:@"" forHTTPHeaderField:@"Cookie"];
    //  }
    return _shareClient;
}
//12298 # by whq at 20151113 end

- (AFHTTPRequestOperation *)getPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))compliteBlock{
    
    //判断是否加载缓存
    if (loadCacheFlag) {
        
        NSString *cacheKey = [[XCarCacheManager shareManager]cacheKeyForURL:path parameter:parameters];
        id obj = [[XCarCacheManager shareManager] cacheforKey:cacheKey];
        if (obj) {
            compliteBlock(nil,obj,nil);
            return nil;
        }
    }
    
    //不加载缓存或缓存加载失败
    AFHTTPRequestOperation *requestOperation = [self GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【Get】\nRequest:%@\nParameters:%@\nHeaders:%@\nResponse:%@",operation.request.URL.absoluteString,parameters,operation.request.allHTTPHeaderFields,responseObject];
        NSLog(@"%@",httpString);
#endif
        [NBSAppAgent setCustomerData:[NSString stringWithFormat:@"%@=>%@",operation.request.URL.path,operation.request.URL.query] forKey:[@(self.requestCount)stringValue]];
        if (compliteBlock) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }
            compliteBlock(operation,responseObject,nil);
        }
        if (saveCacheFlag&&responseObject) {
            [[XCarCacheManager shareManager]saveCacheData:responseObject withUrl:path andParameters:parameters];
        }
        ///获取数据失败时调用
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【Get】\nRequest:%@\nParameters:%@\nHeaders:%@\nError:%@",operation.request.URL.absoluteString,parameters,operation.request.allHTTPHeaderFields,error];
        NSLog(@"%@",httpString);
#endif
        if (error.code == NSURLErrorCancelled) {
            return ;
        }
        if(saveCacheFlag){
            NSString *cacheKey = [[XCarCacheManager shareManager] cacheKeyForURL:path parameter:parameters];
            id responseObject = [[XCarCacheManager shareManager]cacheforKey:cacheKey];
            if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                NSError *err = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&err];
                if (err) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }else if(responseObject){
                compliteBlock(operation,responseObject,error);
            }else{
                compliteBlock(operation,nil,error);
            }
        }else{
            compliteBlock(operation,nil,error);
        }
    }];
    return requestOperation;
}

- (AFHTTPRequestOperation *)getPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  withUserId:(NSInteger)uid withCookie:(NSString *)cookie needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(AFHTTPRequestOperation *operation,id responseObject,NSInteger, NSError *error))compliteBlock{
    
    //判断是否加载缓存
    if (loadCacheFlag) {
        
        NSString *cacheKey = [[XCarCacheManager shareManager]cacheKeyForURL:path parameter:parameters];
        id obj = [[XCarCacheManager shareManager] cacheforKey:cacheKey];
        if (obj) {
            compliteBlock(nil,obj,uid,nil);
            return nil;
        }
    }
    
    //不加载缓存或缓存加载失败
    AFHTTPRequestOperation *requestOperation = [self GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【Get】\nRequest:%@\nParameters:%@\nHeaders:%@\nResponse:%@", operation.request.URL.absoluteString, parameters, operation.request.allHTTPHeaderFields, responseObject];
        NSLog(@"%@",httpString);
#endif
        [NBSAppAgent setCustomerData:[NSString stringWithFormat:@"%@=>%@",operation.request.URL.path,operation.request.URL.query] forKey:[@(self.requestCount)stringValue]];
        if (compliteBlock) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }
            compliteBlock(operation,responseObject,uid,nil);
        }
        if (saveCacheFlag&&responseObject) {
            [[XCarCacheManager shareManager]saveCacheData:responseObject withUrl:path andParameters:parameters];
        }
        ///获取数据失败时调用
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【Get】\nRequest:%@\nParameters:%@\nHeaders:%@\nError:%@",operation.request.URL.absoluteString,parameters,operation.request.allHTTPHeaderFields,error];
        NSLog(@"%@",httpString);
#endif
        if (error.code == NSURLErrorCancelled) {
            return ;
        }
        if(saveCacheFlag){
            NSString *cacheKey = [[XCarCacheManager shareManager] cacheKeyForURL:path parameter:parameters];
            id responseObject = [[XCarCacheManager shareManager]cacheforKey:cacheKey];
            if (responseObject && [responseObject isKindOfClass:[NSData class]]) {
                NSError *err = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&err];
                if (err) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }else if(responseObject){
                compliteBlock(operation,responseObject,uid,error);
            }else{
                compliteBlock(operation,nil,uid,error);
            }
        }else{
            compliteBlock(operation,nil,uid,error);
        }
    }];
    return requestOperation;
}


- (AFHTTPRequestOperation *)postPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))compliteBlock{
    
    //判断是否加载缓存
    if (loadCacheFlag) {
        NSString *cacheKey = [[XCarCacheManager shareManager]cacheKeyForURL:path parameter:parameters];
        id obj = [[XCarCacheManager shareManager] cacheforKey:cacheKey];
        if (obj) {
#if defined(DEBUG)||defined(_DEBUG)
            NSLog(@"\nRespones:%@\nParameters:%@",path,obj);
#endif
            compliteBlock(nil,obj,nil);
            return nil;
        }
    }
    //不加载缓存或缓存加载失败
    AFHTTPRequestOperation *requestOperation = [self POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【POST】\nRequest:%@\nParameters:%@\nHeaders:%@\nResponse:%@",operation.request.URL.absoluteString,parameters,operation.request.allHTTPHeaderFields,responseObject];
        NSLog(@"%@",httpString);
#endif
        [NBSAppAgent setCustomerData:[NSString stringWithFormat:@"%@=>P:%@",operation.request.URL.path,parameters] forKey:[@(self.requestCount)stringValue]];
        if (compliteBlock) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error = nil;
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }
            compliteBlock(operation,responseObject,nil);
        }
        if (saveCacheFlag&&responseObject) {
            [[XCarCacheManager shareManager]saveCacheData:responseObject withUrl:path andParameters:parameters];
        }
        ///获取数据失败时调用
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
#if defined(DEBUG)||defined(_DEBUG)
        NSString *httpString = [NSString stringWithFormat:@"\n【POST】\nRequest:%@\nParameters:%@\nHeaders:%@\nResponse:%@",operation.request.URL.absoluteString,parameters,operation.request.allHTTPHeaderFields,error];
        NSLog(@"%@",httpString);
#endif
        if (error.code == NSURLErrorCancelled) {
            return ;
        }
        if(saveCacheFlag){
            NSString *cacheKey = [[XCarCacheManager shareManager] cacheKeyForURL:path parameter:parameters];
            id cacheObject = [[XCarCacheManager shareManager]cacheforKey:cacheKey];
            if (cacheObject && [cacheObject isKindOfClass:[NSData class]]) {
                NSError *err = nil;
                cacheObject = [NSJSONSerialization JSONObjectWithData:cacheObject options:NSJSONReadingAllowFragments error:&err];
                if (err) {
                    [NSException exceptionWithName:path reason:@"数据格式错误" userInfo:nil];
                }
            }else if(cacheObject){
                compliteBlock(operation,cacheObject,error);
            }else{
                compliteBlock(operation,nil,error);
            }
        }else{
            //#1802 by ZAM at 20141211 begin
            //超时没有网络回调
            compliteBlock(operation,nil,error);
            //#1802 by ZAM at 20141211 begin
        }
    }];
    return requestOperation;
}


-(AFHTTPRequestOperation *)uploadPath:(NSString *)path parameters:(NSDictionary *)parameters imageData:(NSData *)imageData progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress completionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [urlRequest setURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@?uid=%@",path,parameters[@"uid"]]]];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"ipodfile.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:body];
    [urlRequest setHTTPShouldHandleCookies:YES];
    [urlRequest setValue:parameters[@"Cookie"] forHTTPHeaderField:@"Cookie"];
    [urlRequest setTimeoutInterval:25];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [requestOperation setUploadProgressBlock:progress];
    [requestOperation start];
    [requestOperation setCompletionBlockWithSuccess:success failure:failure];
    return requestOperation;
}

-(NSInteger)requestCount{
    _requestCount++;
    if (_requestCount == 3) {
        _requestCount = 0;
    }
    return _requestCount;
}

@end