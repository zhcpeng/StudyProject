//
//  NavBarViewController.m
//  Project
//
//  Created by zhcpeng on 16/4/15.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "NavBarViewController.h"
#import "NavigationTabBars.h"

#import "XCARChannelView.h"

@interface NavBarViewController ()<UIScrollViewDelegate,XCARChannelViewDatasorce,XCARChannelViewDelegate>

@property (nonatomic, strong) NavigationTabBars *tabBarView;            ///< 新年款标签栏
@property (nonatomic,strong) XCARChannelView *channelView;
@property (nonatomic, strong) NSMutableArray *itemList;

@end

@implementation NavBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *list = [NSMutableArray array];
    for (int i = 2016; i > 2000; i--) {
        NSString *str = [NSString stringWithFormat:@"%d款",i];
        [list addObject:str];
    }
    self.itemList = list;
    
    self.tabBarView = [[NavigationTabBars alloc]initWithTitles:[list copy]];
    self.tabBarView.frame = CGRectMake(0, 200, kScreenWidth, 40);
    [self.view addSubview:self.tabBarView.view];
    
//    self.tabBarView.view.frame = CGRectMake(0, 200, kScreenWidth, 40);
    [self addChildViewController:self.tabBarView];
    self.tabBarView.view.backgroundColor = [UIColor orangeColor];
    //    self.tabBarView.view.frame = CGRectMake(0, 200, kScreenWidth, 40);
    

    
    [self.view addSubview:self.channelView];
    [self.channelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);//.insets(UIEdgeInsetsMake(0, 8, 0, 8));
//        make.height.equalTo(@35);
        make.left.right.equalTo(self.view);//.insets(UIEdgeInsetsMake(0, 8, 0, 8));
        make.height.equalTo(@35);
        make.top.mas_equalTo(100);
    }];
    [self.channelView reloadData];
}

- (XCARChannelView *)channelView{
    if (!_channelView) {
        _channelView = [[XCARChannelView alloc]init];
        _channelView.delegate = self;
        _channelView.dataSource = self;
    }
    return _channelView;
}

#pragma mark - XCARChannelViewDatasorce
- (NSInteger)numberOfChannelsForChannelView:(XCARChannelView *)channelView{
    return self.itemList.count;
}

- (NSString *)titleForChannelForChannelView:(XCARChannelView *)channelView atIndex:(NSInteger)index{
    return self.itemList[index];
}

#pragma mark - XCARChannelViewDelegate
-(void)channelView:(XCARChannelView *)channelView didSelectIndex:(NSInteger)index{
//    [self.mainScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
//    self.currentPage = index;
    NSLog(@"%ld",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
