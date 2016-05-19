//
//  NavigationTabBars.m
//  XCar6
//
//  Created by zhcpeng on 16/4/13.
//  Copyright © 2016年 爱卡汽车. All rights reserved.
//

#import "NavigationTabBars.h"


NSString *const kNavigationTabBarsCollectionViewCellIdentifier = @"kNavigationTabBarsCollectionViewCellIdentifier";

@interface NavigationTabBars ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;     ///< 标签显示容器
@property (nonatomic, strong) UIView *indicatorView;                ///< 选中标签下横线
@property (nonatomic, assign) NSUInteger oldSelectedIndex;          ///< 上次选中的cell的index

@end

@implementation NavigationTabBars

#pragma mark - Public
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles{
    self = [super init];
    if (self){
        _titles = titles;
        _oldSelectedIndex = 0;
    }
    return self;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex animate:(BOOL)animate{
    [self updateSelectedCellWithIndex:selectedIndex oldIndex:self.oldSelectedIndex animate:animate];
}
- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
//    [self commonInit];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.frame = self.frame;
    [self commonInit];
    [self updateSelectedCellWithIndex:0 oldIndex:0 animate:NO];
    

    [self themeChangedNotification:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChangedNotification:) name:XCarThemeChangedNotification object:nil];
    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NavigationTabBarsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNavigationTabBarsCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setBarTitle:self.titles[indexPath.item]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath.row;
    [self updateSelectedCellWithIndex:indexPath.row oldIndex:self.oldSelectedIndex animate:YES];
    
    if ([self.delegate respondsToSelector:@selector(navigationTabBars:didSelectedIndex:)]) {
        [self.delegate navigationTabBars:self didSelectedIndex:indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titles[indexPath.item];
    if (title.length > 0) {
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        return CGSizeMake(size.width + 10 + 1, self.collectionView.bounds.size.height);
    }
    return CGSizeZero;
}


#pragma mark - Private
- (void)updateSelectedCellWithIndex:(NSUInteger)index oldIndex:(NSUInteger)oldIndex animate:(BOOL)animate{
    if (index == oldIndex && index != 0) {
        return;
    }
    NavigationTabBarsCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kNavigationTabBarsCollectionViewCellIdentifier forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    cell.titleButton.enabled = YES;
    NavigationTabBarsCollectionViewCell *oldCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kNavigationTabBarsCollectionViewCellIdentifier forIndexPath:[NSIndexPath indexPathForRow:oldIndex inSection:0]];
    oldCell.titleButton.enabled = NO;
    
//    CGSize intrinsicSize = cell.titleButton.intrinsicContentSize;
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
//            [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
////                make.bottom.equalTo(self.collectionView.mas_bottom).offset(-2);
//                make.top.equalTo(@38);
//                make.height.equalTo(@2);
//                make.width.mas_equalTo(intrinsicSize.width);
//                make.left.mas_equalTo(@(cell.frame.origin.x - 5));
//            }];
            self.indicatorView.frame = CGRectMake(cell.frame.origin.x - 3, 38, cell.frame.size.width + 6, 2);
        } completion:nil];
    }else{
//        [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.collectionView.mas_bottom).offset(-2);
//            make.height.equalTo(@2);
//            make.width.mas_equalTo(intrinsicSize.width);
//            make.left.mas_equalTo(cell.frame.origin.x).offset(5);
//        }];
        self.indicatorView.frame = CGRectMake(cell.frame.origin.x - 3, 38, cell.frame.size.width + 6, 2);
    }
}

#pragma mark - Getter And Setter
- (void)commonInit{
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.indicatorView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
//        flowLayout.itemSize = CGSizeMake(100 , 40);
        flowLayout.scrollDirection= UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NavigationTabBarsCollectionViewCell class] forCellWithReuseIdentifier:kNavigationTabBarsCollectionViewCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}


#pragma mark - Theme

-(void)themeChangedNotification:(NSNotification *)notification{    
//    switch ([XCarUtility currentTheme]) {
//        case XCarThemeStyleWhite:{
//            self.indicatorView.backgroundColor = [UIColor w_blueColor1];
//            break;
//        }
//        case XCarThemeStyleBlack:{
//            self.indicatorView.backgroundColor = [UIColor b_blueColor1];
//            break;
//        }
//    }
    self.indicatorView.backgroundColor = [UIColor blueColor];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end



@implementation NavigationTabBarsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self themeChangedNotification:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedNotification:) name:XCarThemeChangedNotification object:nil];
    }
    return self;
}

- (void)setBarTitle:(NSString *)title{
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self layoutIfNeeded];
}

- (void)commonInit{
    [self.contentView addSubview:self.titleButton];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}

- (UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.userInteractionEnabled = NO;
        _titleButton.backgroundColor = [UIColor clearColor];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _titleButton.enabled = NO;
    }
    return _titleButton;
}

#pragma mark - Theme

-(void)themeChangedNotification:(NSNotification *)notification{
//    switch ([XCarUtility currentTheme]) {
//        case XCarThemeStyleWhite:{
//            [self.titleButton setTitleColor:[UIColor w_darkTextColor] forState:UIControlStateNormal];
//            [self.titleButton setTitleColor:[UIColor w_blueColor1] forState:UIControlStateDisabled];
//            break;
//        }
//        case XCarThemeStyleBlack:{
//            [self.titleButton setTitleColor:[UIColor b_blueColor1] forState:UIControlStateDisabled];
//            [self.titleButton setTitleColor:[UIColor b_titleColor] forState:UIControlStateNormal];
//            break;
//        }
//    }
    [self.titleButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self.titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end




