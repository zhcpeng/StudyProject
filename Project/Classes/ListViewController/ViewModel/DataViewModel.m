//
//  DataViewModel.m
//  MVVMDemo
//
//  Created by ZhangChunpeng on 16/6/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "DataViewModel.h"

@interface DataViewModel()



@end

@implementation DataViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemList = [NSMutableArray array];
    }
    return self;
}

- (void)getDataWhenCompletion:(void(^)())completion{
    
}

@end
