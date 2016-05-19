//
//  MasonryListViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/16.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "MasonryListViewController.h"

#import "MasonryListViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface MasonryListViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation MasonryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    WS(ws);
    
//    NSLog(@"%@",ws.navigationController.navigationBar.mas_height);
    
    _myTableView = [[UITableView alloc]init];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_equalTo(ws.view);
//        make.top.mas_equalTo(kHeightNavBar);
//        make.top.mas_equalTo(64);
        make.edges.equalTo(ws.view);
    }];
    
//    self.navigationController.navigationBar
    
    
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"http://a.xcar.com.cn/interface/6.0/getNewsList.php" parameters:nil error:nil];
    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"start"] = @"1";
//    params[@"end"] = @"5";
//    
//    [session POST:@"" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求成功");
//    }];
    
    
    NSString *url = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=nzdKKvXg2ac17u%2F11woFew%3D%3D&devId=v6s%2FCHv6ajflr8IsNl3SdLT4a58iF6tOPb0frwrCO0S6kIXwHDb9QeOJKEDL2uNH&size=20&version=5.5.3&spever=false&net=wifi&lat=&lon=&ts=1458208006&sign=tp%2BijGqXSbjYoGvpjiPCMBM86q9h6ULxDxclsPK7HqF48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore";
    
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
        
        if (responseObject) {
            NSDictionary *dict = responseObject;
            NSMutableArray *list = [NSMutableArray arrayWithArray:[dict objectForKey:@"T1348647853363"]];
            [list removeObjectAtIndex:0];
            
            _itemList = list;
            
            [_myTableView reloadData];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//    [self performSelector:@selector(actionBtn) withObject:nil];
//#pragma clang diagnostic pop

    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentidier = @"CellIdentidier";
    MasonryListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentidier];
    if (!cell) {
        cell = [[MasonryListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentidier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.textLabel.text = _itemList[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[_itemList[indexPath.row] objectForKey:@"img"]]];
    cell.labelTitle.text = [_itemList[indexPath.row] objectForKey:@"title"];
    cell.labelDetail.text = [_itemList[indexPath.row] objectForKey:@"digest"];
    [cell.labelDetail alignTop];
    
    return cell;
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
