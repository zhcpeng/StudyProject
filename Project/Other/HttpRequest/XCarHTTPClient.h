//
//  HTTPClient.h
//  XCar6
//
//  Created by ZhangAimin on 14/9/10.
//  Copyright (c) 2014年 爱卡汽车. All rights reserved.
//

/**
 网络请求相关
 */

#include "AFNetworking.h"

#import "AFHTTPRequestOperationManager.h"

@interface XCarHTTPClient : AFHTTPRequestOperationManager

/**
 获取网络请求单例对象
 @return HTTPClient 对象
*/
+(instancetype)shareClient;

/**
 获取网络请求单例对象
 @return HTTPClient 对象
 cookie是在获取多账户信息时专用
 */
//12298 # by whq at 20151113  begin
+(instancetype)shareClient:(NSString *)cookie;
//12298 # by whq at 20151113 end

/**
 GET方式请求数据
 @param path          请求地址 如果地址为BaseUrl为http://www.xcar.com.cn  可以省略BaseUrl
 @param parameters    参数列表 字典
 @param loadCacheFlag 是否加载缓存
 @param saveCacheFlag 是否保存缓存 如果保存缓存 在数据请求失败时候会走缓存
 @param alertFlag     如果请求失败 是否提醒
 @param compliteBlock 请求完成回调方法 注意：如果数据从缓存返回，则CompliteBlock中operation为nil;
 @return 返回值AFHTTPRequestOperation 可以根据返回对象取消请求
 */

- (AFHTTPRequestOperation *)getPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(/**操作对象*/AFHTTPRequestOperation *operation,id responseObject, NSError *error))compliteBlock;
/**
 POST方式请求数据
 @param path          请求地址 如果地址为BaseUrl为http://www.xcar.com.cn  可以省略BaseUrl
 @param parameters    参数列表 字典
 @param loadCacheFlag 是否加载缓存
 @param saveCacheFlag 是否保存缓存 如果保存缓存 在数据请求失败时候会走缓存
 @param alertFlag     如果请求失败 是否提醒
 @param compliteBlock 请求完成回调方法 注意：如果数据从缓存返回，则CompliteBlock中operation为nil;
 @return 返回值AFHTTPRequestOperation 可以根据返回对象取消请求
 */
- (AFHTTPRequestOperation *)postPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(AFHTTPRequestOperation *operation,id responseObject, NSError *error))compliteBlock;

/**
 图片上传
 图片上传路径  kURL_UPLOAD_IFY_API定义了Path
 @param path       图片上传路径  kURL_UPLOAD_IFY_API定义了Path
 @param parameters 参数列表 （必须参数 uid:用户id  Cookie:用户Cookie值）
 @param imageData  图片数据
 @param progress   上传进度
 @param success    上传成功回调方法
 @param failure    上传失败回调方法
 @return 返回值AFHTTPRequestOperation 可以根据返回对象取消请求
 */
-(AFHTTPRequestOperation *)uploadPath:(NSString *)path parameters:(NSDictionary *)parameters imageData:(NSData *)imageData progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress completionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 GET方式请求数据
 @param path          请求地址 如果地址为BaseUrl为http://www.xcar.com.cn  可以省略BaseUrl
 @param parameters    参数列表 字典
 @param loadCacheFlag 是否加载缓存
 @param saveCacheFlag 是否保存缓存 如果保存缓存 在数据请求失败时候会走缓存
 @param uid           判断请求数据返回是当前用户
 @param alertFlag     如果请求失败 是否提醒
 @param compliteBlock 请求完成回调方法 注意：如果数据从缓存返回，则CompliteBlock中operation为nil;
 @return 返回值AFHTTPRequestOperation 可以根据返回对象取消请求
 */
- (AFHTTPRequestOperation *)getPath:(NSString *)path parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCacheFlag saveCache:(BOOL)saveCacheFlag  withUserId:(NSInteger)uid withCookie:(NSString *)cookie needAlert:(BOOL)alertFlag withCompliteBlock:(void (^)(AFHTTPRequestOperation *operation,id responseObject,NSInteger, NSError *error))compliteBlock;
@end