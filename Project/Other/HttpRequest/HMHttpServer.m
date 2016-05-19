//
//  HJKHttpServer.m
//  HuiMaiHealth
//
//  Created by yanglijun on 14-9-17.
//  Copyright (c) 2014年 Huimai. All rights reserved.
//

#import "HMHttpServer.h"
#import "AFJSONRequestOperation.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HMHttpServer
+ (HMHttpServer *)sharedClient{
    static HMHttpServer *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HMHttpServer alloc] initWithBaseURL:[NSURL URLWithString:kHttp_HuimaiHealth_Main_Url]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"content-type" value:@"application/json"];
//    [self setDefaultHeader:@"content-type" value:@"multipart/form-data"];
    
    self.defaultSSLPinningMode = AFSSLPinningModeNone;
    return self;
}

+ (NSString*)getOauthSignature:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@"?"];
    NSString* oauthString;
    if (range.location == NSNotFound) {
        oauthString = urlString;
    } else {
        oauthString = [urlString substringFromIndex:range.location+1];
    }
    NSArray* arrayParams = [oauthString componentsSeparatedByString:@"&"];
    NSMutableArray* orderedParams = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    for (NSString* param in arrayParams) {
        NSInteger indexEquality = [param rangeOfString:@"="].location;
        if ([[param substringToIndex:indexEquality] isEqualToString:@"oauth_nonce"]) {
            [orderedParams replaceObjectAtIndex:0 withObject:[param substringFromIndex:indexEquality+1]];
        } else if ([[param substringToIndex:indexEquality] isEqualToString:@"oauth_signature_method"]) {
            [orderedParams replaceObjectAtIndex:1 withObject:[param substringFromIndex:indexEquality+1]];
        } else if ([[param substringToIndex:indexEquality] isEqualToString:@"oauth_consumer_key"]) {
            [orderedParams replaceObjectAtIndex:2 withObject:[param substringFromIndex:indexEquality+1]];
        } else if ([[param substringToIndex:indexEquality] isEqualToString:@"oauth_version"]) {
            [orderedParams replaceObjectAtIndex:3 withObject:[param substringFromIndex:indexEquality+1]];
        } else if ([[param substringToIndex:indexEquality] isEqualToString:@"oauth_timestamp"]) {
            [orderedParams replaceObjectAtIndex:4 withObject:[param substringFromIndex:indexEquality+1]];
        }
    }
    oauthString = [[NSString alloc] initWithFormat:@"%@&%@&%@&%@&%@", [orderedParams objectAtIndex:0],[orderedParams objectAtIndex:1],[orderedParams objectAtIndex:2],[orderedParams objectAtIndex:3],[orderedParams objectAtIndex:4]];
    //    [orderedParams release];
    const char *src = [oauthString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (CC_LONG)strlen(src), result);
    //    [oauthString release];
    NSString * ret = [[NSString alloc] initWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]];[NSString defaultCStringEncoding];
    return ret;
}

+ (NSString *)UrlEncoding:(NSString *)urlStr
{
    return  [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark 返回32位MD5
+ (NSString *)getStringMD5:(NSString *)str {
   
    //    [orderedParams release];
    const char *src = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(src, (CC_LONG)strlen(src), result);
    //    [oauthString release];
    NSString * ret = [[NSString alloc] initWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]];
    [NSString defaultCStringEncoding];
    return ret;
}

#pragma mark 返回SignMD5
+ (NSString *)getStringSignMD5:(NSString *)str andRandom:(NSString *)strRandom andTimeIS:(NSString *)strTimeIS {
    NSString *strSign = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@%@%@",kHTTP_HM_API_KEY_VALUE, strRandom,kHTTP_HM_SIGN_METHOD_VALUE, strTimeIS,kHTTP_HM_SIGN_TYPE_VALUE,kHTTP_HM_VERSION_VALUE,[NSString stringWithFormat:@"%@",str],kHTTP_HM_PRIVATE_KEY_VALUE];
    NSString *strSingMD5 = [self getStringMD5:strSign];
    return strSingMD5;
}

#pragma mark 返回适应接口的参数字典
+ (NSDictionary *)getDictionary:(NSDictionary *)dict {
    NSString* strRandom = [NSString stringWithFormat:@"%d",arc4random()];
    NSString* strTimeIS = [NSString stringWithFormat:@"%lu",(unsigned long)[[NSDate date] timeIntervalSince1970]];
    
    NSMutableDictionary *mutDict;
    NSMutableString *str;
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    str = [NSMutableString stringWithString:@""];
    for (NSString *keyId in sortedArray)
    {
        if ([dict objectForKey:keyId]!=nil /*&&![[dict objectForKey:keyId] isEqualToString:@""]*/ )
        {
            str = [NSMutableString stringWithFormat:@"%@%@",str,[dict objectForKey:keyId]];
        }
//        NSLog(@"[dict objectForKey:keyId] === %@",[dict objectForKey:keyId]);
    }
    
    NSString *strSingMD5 = [self getStringSignMD5:str andRandom:strRandom andTimeIS:strTimeIS];
    // 业务数据
    mutDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    // 固定键值
    [mutDict setObject:kHTTP_HM_API_KEY_VALUE forKey:kHTTP_HM_API_KEY_ID];
    [mutDict setObject:strRandom forKey:kHTTP_HM_NONCE_ID];
    [mutDict setObject:kHTTP_HM_SIGN_METHOD_VALUE forKey:kHTTP_HM_SIGN_METHOD_ID];
    [mutDict setObject:strTimeIS forKey:kHTTP_HM_TIMESTAMP_ID];
    [mutDict setObject:kHTTP_HM_SIGN_TYPE_VALUE forKey:kHTTP_HM_SIGN_TYPE_ID];
    [mutDict setObject:kHTTP_HM_VERSION_VALUE forKey:kHTTP_HM_VERSION_ID];
    [mutDict setObject:strSingMD5 forKey:kHTTP_HM_SIGN_ID];
    
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

@end
