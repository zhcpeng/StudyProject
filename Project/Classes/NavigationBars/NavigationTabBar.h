//
//  NavigationTabBar.h
//  XCar6
//
//  Created by ZhangAimin on 14/11/17.
//  Copyright (c) 2014年 爱卡汽车. All rights reserved.
//

/**
 标签切换工具栏  用于标签切换
 */

#import <UIKit/UIKit.h>

@protocol NavigationTabBarDelegate;
@interface NavigationTabBar : UIView

/**
 标签数组
 */
@property (nonatomic,strong) NSArray * titles;

/**
 是否展示搜索按钮
 */
@property (nonatomic,assign) BOOL showSearch;

/**
 设置选择的索引 默认有动画 从0开始
 */
@property (nonatomic,assign) NSUInteger selectedIndex;
/**
 代理
 */
@property (nonatomic,weak) id<NavigationTabBarDelegate> delegate;
/**
 初始化方法
 
 @param frame      设置大小位置
 @param titles     标题数组
 @param showSearch 是否显示搜索按钮
 
 @return Tab栏
 */
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles hasSearchItem:(BOOL)showSearch;
/**
 设置选择的标题
 
 @param selectedIndex 选择标题的索引 从0开始
 @param animate       是否是使用动画
 */
-(void)setSelectedIndex:(NSUInteger)selectedIndex animate:(BOOL)animate;
@end

@protocol NavigationTabBarDelegate <NSObject>
@required
/**
 点击标题时回调 从0开始
 
 @param titleView Tab栏
 @param index     选择的位置 从0开始
 */
-(void)navigationTabBar:(NavigationTabBar*)titleView didSelectedIndex:(NSUInteger)index;
@optional
/**
 搜索按钮点击
 
 @param titleView    Tab栏
 @param searchButton 搜索按钮
 */
-(void)navigationTabBar:(NavigationTabBar *)titleView searchButtonClicked:(UIButton *)searchButton;

@end