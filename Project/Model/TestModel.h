//
//  TestModel.h
//  Project
//
//  Created by zhcpeng on 16/5/10.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Data1,Linkinfo;
@interface TestModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) Data1 *data;

@end
@interface Data1 : NSObject

@property (nonatomic, assign) NSInteger supportCount;

@property (nonatomic, assign) NSInteger urlType;

@property (nonatomic, copy) NSString *authorIcon;

@property (nonatomic, assign) NSInteger isSupported;

@property (nonatomic, copy) NSString *shareContent;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *clickableUrl;

@property (nonatomic, copy) NSString *topicTitle;

@property (nonatomic, assign) NSInteger topicType;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *wapLink;

@property (nonatomic, strong) Linkinfo *linkInfo;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, assign) NSInteger shareSwitch;

@property (nonatomic, assign) NSInteger authorUid;

@property (nonatomic, copy) NSString *tvId;

@end

@interface Linkinfo : NSObject

@property (nonatomic, copy) NSString *publicTime;

@property (nonatomic, copy) NSString *statisticsUrl;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger pageNumber;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *url;

@end

