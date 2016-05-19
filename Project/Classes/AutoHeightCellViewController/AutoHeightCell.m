//
//  AutoHeightCell.m
//  Project
//
//  Created by zhcpeng on 16/3/18.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "AutoHeightCell.h"

@implementation AutoHeightCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        WS(wSelf);
        short podding = 10;
        short halfPodding = 5;
        
        [self.contentView addSubview:self.content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wSelf.contentView.mas_top).offset(halfPodding);
            make.left.mas_equalTo(podding);
            make.right.mas_equalTo(-podding);
        }];
        
        [self.contentView addSubview:self.imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(podding);
            make.right.mas_equalTo(-podding);
            make.top.mas_equalTo(_content.mas_bottom).offset(halfPodding);
            make.bottom.mas_equalTo(wSelf.contentView.mas_bottom).offset(-halfPodding);
        }];
        
    }
    return self;
}

- (void)setModel:(AutoHeightCellModel *)model{
    if (model) {
        _model = model;
        
        _content.text = model.content;
        
        if (model.imageName.length > 0) {
            _imgView.image = [UIImage imageNamed:model.imageName];
        }else{
            _imgView.image = nil;
        }
    }
}


- (UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.backgroundColor = kUIColorFromRGB(0x404440);
        _content.numberOfLines = 0;
    }
    return _content;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.contentMode = UIViewContentModeLeft;
    }
    return _imgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
