//
//  UIViewTestViewController.m
//  Project
//
//  Created by zhcpeng on 16/6/1.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "UIViewTestViewController.h"

@interface UIViewTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *view0;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, strong) UITableView *listView1;
@property (nonatomic, strong) UITableView *listView2;

@end

@implementation UIViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    _view0.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(10, 10, 100, 30);
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_view0 addSubview:button];
    
    
    
    
//    _view1 = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
//    _view1.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:_view1];
//    
//    _view2 = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
//    _view2.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:_view2];
//    
//    [_view2 addSubview:_view0];
    
    _listView1 = [[UITableView alloc]initWithFrame:self.view.bounds];
    _listView1.delegate = self;
    _listView1.dataSource = self;
    [self.view addSubview:_listView1];
    
    
    _listView2 = [[UITableView alloc]initWithFrame:self.view.bounds];
    _listView2.delegate = self;
    _listView2.dataSource = self;
    [self.view addSubview:_listView2];
    
    
    _listView2.hidden = YES;
    _listView1.tableHeaderView = _view0;
    
    
    
}


- (void)btnAction:(UIButton *)btn{
    
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
