//
//  AutoHeightCell.h
//  Project
//
//  Created by zhcpeng on 16/3/18.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoHeightCellModel.h"

@interface AutoHeightCell : UITableViewCell

@property (nonatomic, strong) AutoHeightCellModel *model;

@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImageView *imgView;

@end
