//
//  XCARChannelView.h
//  yuedu
//
//  Created by Zhang on 15/9/19.
//  Copyright © 2015年 北京易利友信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCARChannelViewDelegate;
@protocol XCARChannelViewDatasorce;

@interface XCARChannelView : UIView
@property (nonatomic, strong) NSArray *eventsArray;
@property (nonatomic, weak) id<XCARChannelViewDatasorce> dataSource;
@property (nonatomic, weak) id<XCARChannelViewDelegate> delegate;

-(void)reloadData;

@property (nonatomic,assign) NSInteger selectedIndex;

-(void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate;

@end

@protocol XCARChannelViewDelegate <NSObject>

-(void)channelView:(XCARChannelView *)channelView didSelectIndex:(NSInteger)index;

@end

@protocol XCARChannelViewDatasorce <NSObject>
@required

- (NSInteger)numberOfChannelsForChannelView:(XCARChannelView *)channelView;

- (NSString *)titleForChannelForChannelView:(XCARChannelView *)channelView atIndex:(NSInteger)index;

@end