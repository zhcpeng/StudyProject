//
//  DataViewModel.h
//  MVVMDemo
//
//  Created by ZhangChunpeng on 16/6/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataModel.h"

@interface DataViewModel : NSObject

@property (nonatomic, strong) DataModel *model;
@property (nonatomic, strong) NSMutableArray *itemList;

- (void)getDataWhenCompletion:(void(^)())completion;

@end
