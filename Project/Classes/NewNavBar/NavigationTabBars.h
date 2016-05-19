//
//  NavigationTabBars.h
//  XCar6
//
//  Created by zhcpeng on 16/4/13.
//  Copyright © 2016年 爱卡汽车. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  标签切换工具栏 用于标签切换 带滚动效果
 */

@protocol NavigationTabBarsDelegate;

@interface NavigationTabBars : UIViewController

@property (nonatomic,strong) NSArray <NSString *>* titles;          ///< 标签标题数组
@property (nonatomic,assign) NSUInteger selectedIndex;              ///< 设置选择的索引 默认有动画 从0开始
@property (nonatomic,weak) id<NavigationTabBarsDelegate> delegate;  ///< NavigationTabBarsDelegate
@property (nonatomic, assign) CGRect frame;                       ///< 导航栏高度

/**
 初始化方法

 @param titles     标题数组
 
 @return Tab栏
 */
- (instancetype)initWithTitles:(NSArray <NSString *> *)titles;
/**
 设置选择的标题
 
 @param selectedIndex 选择标题的索引 从0开始
 @param animate       是否是使用动画
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex animate:(BOOL)animate;

@end


@protocol NavigationTabBarsDelegate <NSObject>

@required
/**
 点击标题时回调 从0开始
 
 @param titleView Tab栏
 @param index     选择的位置 从0开始
 */
- (void)navigationTabBars:(NavigationTabBars *)titleView didSelectedIndex:(NSUInteger)index;

@end




extern NSString *const kNavigationTabBarsCollectionViewCellIdentifier;

@interface NavigationTabBarsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *titleButton;        ///< 标签名字

- (void)setBarTitle:(NSString *)title;

@end
