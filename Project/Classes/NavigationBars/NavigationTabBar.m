//
//  navigationTabBar.m
//  XCar6
//
//  Created by ZhangAimin on 14/11/17.
//  Copyright (c) 2014年 爱卡汽车. All rights reserved.
//

#import "NavigationTabBar.h"

@interface NavigationTabBar()

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) NSMutableArray *titleButtons;
@property (nonatomic,strong) UIButton *searchButton;

@end

@implementation NavigationTabBar

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles hasSearchItem:(BOOL)showSearch{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _showSearch = showSearch;
        _titleButtons = [[NSMutableArray alloc]init];
        
        if (_showSearch) {
            self.searchButton.hidden = NO;
        }
        
        [self commenInit];
        
        [self themeChangedNotification:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangedNotification:) name:XCarThemeChangedNotification object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame titles:nil hasSearchItem:NO];
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc]init];
        _searchButton.exclusiveTouch = YES;
        [_searchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchButton];
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(@30);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [self themeChangedNotification:nil];
    }
    return _searchButton;
}

-(void)commenInit{
    
    self.contentScrollView = [[UIScrollView alloc]init];
    [self addSubview:_contentScrollView];
    _contentScrollView.frame = CGRectMake(0, 0, kScreenWidth, 40);
    _contentScrollView.backgroundColor = [UIColor greenColor];
    CGFloat width = 0;
    
    for (UIButton *button in self.titleButtons) {
        [button removeFromSuperview];
    }
    [self.titleButtons removeAllObjects];

    UIView *lastView = nil;
    for (NSString *title in _titles) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSUInteger index = [_titles indexOfObject:title];
        titleButton.tag = index;
        if (index == 0) {
            titleButton.enabled = NO;
        }
        titleButton.exclusiveTouch = YES;
        [titleButton setTitle:title forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
        CGSize intrinsicSize = titleButton.intrinsicContentSize;
        [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentScrollView addSubview:titleButton];
        [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(lastView?lastView.mas_right:self.mas_left).offset(lastView?12:4);
            make.width.equalTo(@(intrinsicSize.width + 8));
        }];
        [self.titleButtons addObject:titleButton];
        lastView = titleButton;
        width += intrinsicSize.width + 8;
    }
    self.contentScrollView.contentSize = CGSizeMake(width, 40);
    
    _indicatorView = [[UIView alloc]init];
    UIView *firstButton = nil;
    if (_titles.count > 0) {
        firstButton = [self.titleButtons firstObject];
    }
    [self addSubview:_indicatorView];
    CGSize intrinsicSize = firstButton.intrinsicContentSize;
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(firstButton?firstButton.mas_left:self.mas_left);
        make.width.equalTo(firstButton?@(intrinsicSize.width+8):@0);
        make.height.equalTo(@2);
    }];
    
    [self themeChangedNotification:nil];
}

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self commenInit];
}

-(void)setShowSearch:(BOOL)showSearch{
    _showSearch = showSearch;
    if (_showSearch) {
        self.searchButton.hidden = NO;
    }else{
        _searchButton.hidden = !_showSearch;
    }
}

#pragma mark - Action

-(void)titleButtonClicked:(UIButton *)sender{
    
    self.selectedIndex = sender.tag;
    [self.delegate navigationTabBar:self didSelectedIndex:sender.tag];
}

-(void)searchButtonClicked:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(navigationTabBar:searchButtonClicked:)]) {
        [self.delegate navigationTabBar:self searchButtonClicked:sender];
    }
}

#pragma mark - Private

-(void)setSelectedIndex:(NSUInteger)selectedIndex animate:(BOOL)animate{
    
    if (self.titleButtons.count <= selectedIndex) {
        return;
    }
    UIButton *preSelectedButton = self.titleButtons[_selectedIndex];
    preSelectedButton.enabled = YES;
    _selectedIndex = selectedIndex;
     UIButton *selectedButton = self.titleButtons[_selectedIndex];
    selectedButton.enabled = NO;
    CGSize intrinsicSize = selectedButton.intrinsicContentSize;
    if (animate) {
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            
            [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mas_bottom);
                make.left.equalTo(selectedButton?selectedButton.mas_left:self.mas_left);
                make.width.equalTo(selectedButton?@(intrinsicSize.width+8):@0);
                make.height.equalTo(@2);
            }];
            [self layoutIfNeeded];
        } completion:NULL];
        
    }else{
        [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(selectedButton?selectedButton.mas_left:self.mas_left);
            make.width.equalTo(selectedButton?@(intrinsicSize.width+8):@0);
            make.height.equalTo(@2);
        }];
    }
    [self themeChangedNotification:nil];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [self setSelectedIndex:selectedIndex animate:YES];
}

#pragma mark - Theme

-(void)themeChangedNotification:(NSNotification *)notification{
    
//    switch ([XCarUtility currentTheme]) {
//        case XCarThemeStyleWhite:{
//            self.indicatorView.backgroundColor = [UIColor w_blueColor1];
//            for (UIButton *titleButton in self.titleButtons) {
//                [titleButton setTitleColor:[UIColor w_darkTextColor] forState:UIControlStateNormal];
//                [titleButton setTitleColor:[UIColor w_blueColor1] forState:UIControlStateDisabled];
//                NSInteger index = [self.titleButtons indexOfObject:titleButton];
//                if (index == _selectedIndex) {
//                    [titleButton setTitleColor:[UIColor w_blueColor1] forState:UIControlStateHighlighted];
//                }else{
//                    [titleButton setTitleColor:[UIColor w_darkTextColor] forState:UIControlStateHighlighted];
//                }
//            }
//
//            [_searchButton setImage:[UIImage imageNamed:@"sousuo_baitian"] forState:UIControlStateNormal];
//            [_searchButton setImage:[UIImage imageNamed:@"sousuo_baitian_hit"] forState:UIControlStateHighlighted];
//            break;
//        }
//        case XCarThemeStyleBlack:{
//            
//            self.indicatorView.backgroundColor = [UIColor b_blueColor1];
//            for (UIButton *titleButton in self.titleButtons) {
//                [titleButton setTitleColor:[UIColor b_blueColor1] forState:UIControlStateDisabled];
//                [titleButton setTitleColor:[UIColor b_titleColor] forState:UIControlStateNormal];
//                NSInteger index = [self.titleButtons indexOfObject:titleButton];
//                if (index == _selectedIndex) {
//                    [titleButton setTitleColor:[UIColor b_blueColor1] forState:UIControlStateHighlighted];
//                }else{
//                    [titleButton setTitleColor:[UIColor b_titleColor] forState:UIControlStateHighlighted];
//                }
//            }
//            [_searchButton setImage:[UIImage imageNamed:@"sousuo_heiye"] forState:UIControlStateNormal];
//             [_searchButton setImage:[UIImage imageNamed:@"sousuo_heiye_hit"] forState:UIControlStateHighlighted];
//            
//            break;
//        }
//    }
    
    self.indicatorView.backgroundColor = [UIColor blueColor];
//    for (UIButton *titleButton in self.titleButtons) {
//        [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
//        [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
//        NSInteger index = [self.titleButtons indexOfObject:titleButton];
//        if (index == _selectedIndex) {
//            [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//        }else{
//            [titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
//        }
//    }

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
