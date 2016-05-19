//
//  CollectionViewCell.m
//  Project
//
//  Created by zhcpeng on 16/3/21.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WS(wSelf)
        _textLabel = [[UILabel alloc]init];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wSelf.contentView);
        }];
        self.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                                 alpha:1];
    }
    return self;
}



@end
