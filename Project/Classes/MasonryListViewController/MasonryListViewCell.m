//
//  MasonryListViewCell.m
//  Project
//
//  Created by zhcpeng on 16/3/16.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "MasonryListViewCell.h"

@implementation MasonryListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float podding = 10;
        WS(wSelf)
        
        [self.contentView addSubview:self.imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(podding);
            make.top.mas_equalTo(podding * 0.5);
            make.width.mas_equalTo(150);
            //            make.height.mas_equalTo(60);
            make.bottom.mas_equalTo(wSelf.contentView.mas_bottom).offset(- podding * 0.5);
            //            make.top.equalTo(wSelf.contentView.mas_top).offset(podding);
        }];
        
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_labelTitle];
        [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(podding * 0.5);
            make.left.mas_equalTo(_imgView.mas_right).offset(podding);
            make.right.mas_equalTo(wSelf.contentView.mas_right).offset(-podding);
            make.height.mas_equalTo(30);
//            make.bottom.mas_equalTo()
        }];
        
        _labelDetail = [[UILabel alloc]init];
        _labelDetail.backgroundColor = kUIColorFromRGB(0x006666);
        _labelDetail.numberOfLines = 2;
        [self.contentView addSubview:_labelDetail];
        [_labelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_labelTitle.mas_bottom).offset(podding);
            make.left.mas_equalTo(_imgView.mas_right).offset(podding);
            make.right.mas_equalTo(wSelf.contentView.mas_right).offset(-podding);
            make.bottom.mas_equalTo(_imgView.mas_bottom);
        }];
        
        
    }
    return self;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        
    }
    return _imgView;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
