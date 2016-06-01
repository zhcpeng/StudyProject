//
//  NSObject+UnrecognizedSelector.m
//  Project
//
//  Created by zhcpeng on 16/5/24.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "NSObject+UnrecognizedSelector.h"
#import <objc/runtime.h>

@implementation NSObject (UnrecognizedSelector)

//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
//    NSMethodSignature *sig = [super methodSignatureForSelector:selector];
//    if(!sig) {
//        NSString *selString = NSStringFromSelector(selector);
//        if ([selString hasPrefix:@"_"]) {
//            SEL cleanedSelector = NSSelectorFromString([selString substringFromIndex:1]);
//            sig = [super methodSignatureForSelector:cleanedSelector];
//        }
//    }
//    return sig;
//}
//
//- (void)forwardInvocation:(NSInvocation *)inv {
//    NSString *selString = NSStringFromSelector([inv selector]);
//    if ([selString hasPrefix:@"_"]) {
//        SEL cleanedSelector = NSSelectorFromString([selString substringFromIndex:1]);
//        if ([self respondsToSelector:cleanedSelector]) {
//            inv.selector = cleanedSelector;
//            [inv invokeWithTarget:self];
//        }
//    }else {
//        [super forwardInvocation:inv];
//    }
//}



@end
