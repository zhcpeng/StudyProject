//
//  ListViewCell.m
//  MVVMDemo
//
//  Created by ZhangChunpeng on 16/6/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
