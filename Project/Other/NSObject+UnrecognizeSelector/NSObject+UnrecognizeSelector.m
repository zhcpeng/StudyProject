//
//  NSObject+UnrecognizeSelector.m
//  Project
//
//  Created by ZhangChunpeng on 16/6/17.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "NSObject+UnrecognizeSelector.h"

#define INIT_INV(_last_arg_, _return_) \
NSMethodSignature * sig = [self methodSignatureForSelector:sel]; \
if (!sig) { [self doesNotRecognizeSelector:sel]; return _return_; } \
NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig]; \
if (!inv) { [self doesNotRecognizeSelector:sel]; return _return_; } \
[inv setTarget:self]; \
[inv setSelector:sel]; \
va_list args; \
va_start(args, _last_arg_); \
[NSObject setInv:inv withSig:sig andArgs:args]; \
va_end(args);




@implementation NSObject (UnrecognizeSelector)

- (void)test{
    
//    NSMethodSignature * sig = [self methodSignatureForSelector:sel];
//    if (!sig) {
//        [self doesNotRecognizeSelector:sel]; return _return_;
//    }
//    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
//    if (!inv) {
//        [self doesNotRecognizeSelector:sel]; return _return_;
//    }
//    [inv setTarget:self];
//    [inv setSelector:sel];
//    va_list args;
//    va_start(args, _last_arg_);
//    [NSObject setInv:inv withSig:sig andArgs:args];
//    va_end(args);
    
}

@end
