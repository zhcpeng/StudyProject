//
//  ListViewCell.h
//  MVVMDemo
//
//  Created by ZhangChunpeng on 16/6/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataModel.h"

@interface ListViewCell : UITableViewCell

@property (nonatomic, strong) DataModel *model;            ///< 数据模型

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *labelTitle;

@end
