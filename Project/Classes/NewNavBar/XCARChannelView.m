//
//  DAMChannelView.m
//  yuedu
//
//  Created by Zhang on 15/9/19.
//  Copyright © 2015年 北京易利友信息技术有限公司. All rights reserved.
//

#import "XCARChannelView.h"
#define HomeViewTitleViewDefaultHeight 44

@interface XCARChannelView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIImageView *leftCover;
@property (nonatomic, strong) UIImageView *rigthCover;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *sepLine;

@end

@implementation XCARChannelView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //title的承载视图 主滚动窗口
        [self addSubview:self.mainScrollview];
        [self.mainScrollview addSubview:self.indicatorView];
        [self addSubview:self.rigthCover];
        [self addSubview:self.leftCover];
        [self addSubview:self.sepLine];
        
        [self.leftCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 8, 0, 0));
        }];
        
        [self.rigthCover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 8));;
        }];
        
        [self.mainScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 8, 0, 8));
        }];
        
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
        [self themeChangedNotification:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangedNotification:) name:XCarThemeChangedNotification object:nil];
    }
    return self;
}

#pragma mark - Setter

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex >= 0 && selectedIndex < self.eventsArray.count) {
//        [MobClick event:self.eventsArray[selectedIndex]];
    }
    [self setSelectedIndex:selectedIndex animate:YES];
}

-(void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate{
    NSInteger channelsCount = [self.dataSource numberOfChannelsForChannelView:self];
    if (selectedIndex >= 0 && selectedIndex < channelsCount && channelsCount > 0) {
        _selectedIndex = selectedIndex;
        self.selectedButton.enabled = YES;
        self.selectedButton = (UIButton *)self.titleButtons[_selectedIndex];
        self.selectedButton.enabled = NO;
        if (animate){
            [self layoutIfNeeded];
            [UIView animateWithDuration:0.25 animations:^{
                [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.width.and.bottom.equalTo(self.selectedButton);
                    make.height.equalTo(@2);
                }];
                [self layoutIfNeeded];
            }];
        }else{
            [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.width.and.bottom.equalTo(self.selectedButton);
                make.height.equalTo(@2);
            }];
        }
        [self.mainScrollview scrollRectToVisible:CGRectMake(MAX(_selectedButton.frame.origin.x-100, 0),0, CGRectGetWidth(_mainScrollview.frame), CGRectGetHeight(_mainScrollview.frame)) animated:YES];
    }
    
}
#pragma mark - Actions

-(void)titleButtonClicked:(UIButton *)sender{
    
    self.selectedIndex = sender.tag;
    if ([self.delegate respondsToSelector:@selector(channelView:didSelectIndex:)]) {
        [self.delegate channelView:self didSelectIndex:sender.tag];
    }
}
#pragma mark - UIScrollViewDelegate


#pragma mark - PrivateMethod

-(void)reloadData{

    NSInteger channelsCount = [self.dataSource numberOfChannelsForChannelView:self];
    UIView *contentView = [self.mainScrollview viewWithTag:1290];
    if (contentView == nil) {
        contentView = [[UIView alloc]init];
        contentView.tag = 1290;
        [self.mainScrollview addSubview:contentView];
    }
    
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollview);
        make.height.equalTo(self.mainScrollview.mas_height);
    }];
    
    //数量不足 添加
    while (channelsCount < self.titleButtons.count) {
        UIButton *titleButton = [self.titleButtons lastObject];
        [titleButton removeFromSuperview];
        [self.titleButtons removeLastObject];
    }
    //数量过多 移除
    while (channelsCount > self.titleButtons.count) {
        UIButton *titleButton = [[UIButton alloc]init];
        titleButton.exclusiveTouch = YES;
        [self.titleButtons addObject:titleButton];
        [contentView addSubview:titleButton];
    }
    
    UIView *lastView;
    for (int i = 0; i < self.titleButtons.count; i++) {
        UIButton *titleButton = (UIButton *)self.titleButtons[i];
        [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.tag = i;
        NSString *title = [self.dataSource titleForChannelForChannelView:self atIndex:i];
        [titleButton setTitle:title forState:UIControlStateNormal];
        CGFloat intrinsicWidth = titleButton.intrinsicContentSize.width;
        [titleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(contentView);
            make.left.equalTo(lastView?lastView.mas_right:contentView.mas_left).offset(lastView?12:4);
            make.width.equalTo(@(intrinsicWidth+10));
        }];
        lastView = titleButton;
    }
    
    UIView *sizingView = [self.mainScrollview viewWithTag:1291];
    if (!sizingView) {
        sizingView = [[UIView alloc]init];
        sizingView.tag = 1291;
        [self.mainScrollview addSubview:sizingView];
    }
    [sizingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.and.bottom.equalTo(contentView);
        make.left.equalTo(lastView.mas_right).offset(8);
    }];
    
    UIButton *titleButton0 = self.titleButtons[0];
    self.mainScrollview.contentOffset = CGPointZero;
    [self setSelectedIndex:titleButton0.tag animate:NO];
    [self themeChangedNotification:nil];
}
-(void)themeChangedNotification:(NSNotification *)notification{
//    
//    switch ([XCarUtility currentTheme]) {
//        case XCarThemeStyleWhite:{
//            self.leftCover.image = [UIImage imageNamed:@"baitian_cover_left"];
//            self.rigthCover.image = [UIImage imageNamed:@"baitian_cover_right"];
             self.backgroundColor = [UIColor grayColor];
            self.sepLine.backgroundColor = [UIColor darkGrayColor];
            for (int i = 0; i < self.titleButtons.count; i++) {
                UIButton *titleButton = (UIButton *)self.titleButtons[i];
                [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
            }
            
//            break;
//        }
//        case XCarThemeStyleBlack:{
//            self.leftCover.image = [UIImage imageNamed:@"heiye_cover_left"];
//            self.rigthCover.image = [UIImage imageNamed:@"heiye_cover_right"];
//            self.backgroundColor = [UIColor b_blackColor1];
//            self.sepLine.backgroundColor = [UIColor b_lineColor];;
//            for (int i = 0; i < self.titleButtons.count; i++) {
//                UIButton *titleButton = (UIButton *)self.titleButtons[i];
//                [titleButton setTitleColor:[UIColor b_titleColor] forState:UIControlStateNormal];
//                [titleButton setTitleColor:[UIColor b_blueColor1] forState:UIControlStateDisabled];
//            }
//            break;
//        }
//    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(NSMutableArray *)titleButtons{
    if (!_titleButtons) {
        _titleButtons = [[NSMutableArray alloc]init];
    }
    return _titleButtons;
}

-(UIScrollView *)mainScrollview{
    if (!_mainScrollview) {
        _mainScrollview = [[UIScrollView alloc]init];
        _mainScrollview.delegate = self;
        _mainScrollview.scrollsToTop = NO;
        _mainScrollview.alwaysBounceHorizontal = YES;
        _mainScrollview.backgroundColor = [UIColor clearColor];
        _mainScrollview.showsHorizontalScrollIndicator = NO;
        _mainScrollview.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollview;
}

-(UIImageView *)leftCover{
    if (!_leftCover) {
        _leftCover = [[UIImageView alloc]init];
    }
    return _leftCover;
}

-(UIImageView *)rigthCover{
    if (!_rigthCover) {
        _rigthCover = [[UIImageView alloc]init];
    }
    return _rigthCover;
}

-(UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.backgroundColor = [UIColor blueColor];
        _indicatorView.frame = CGRectMake(0, 42, 42, 2);
    }
    return _indicatorView;
}

-(UIView *)sepLine{
    if (!_sepLine) {
        _sepLine = [[UIView alloc]init];
    }
    return _sepLine;
}

@end
