//
//  FirstViewCell.m
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "FirstViewCell.h"

@implementation FirstViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (self.CellClick) {
        self.CellClick(_indexPath);
    }
}
@end
