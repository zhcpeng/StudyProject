//
//  FirstViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "FirstViewController.h"

#import "FirstViewCell.h"

#import "NavigationTabBars.h"
//#import "NavigationTabBar.h"

@interface FirstViewController ()



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.itemList = [NSMutableArray array];
    
    _myTableView.hidden = YES;
    
    self.view.backgroundColor = kUIColorFromRGB(0xff0000);
    
    UIView *alphaView = [[UIView alloc]init];
    alphaView.alpha = 0;
    alphaView.backgroundColor = kUIColorFromRGB(0x00ff00);
    [self.view addSubview:alphaView];
    [alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view).offset(100);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    
    [UIView animateWithDuration:5 animations:^{
        alphaView.alpha = 0.8;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [alphaView addGestureRecognizer:tap];
    
//    floorf(4);
    
//    NSMutableArray *list = [NSMutableArray array];
//    for (int i = 2016; i > 2000; i--) {
//        NSString *str = [NSString stringWithFormat:@"%d款",i];
//        [list addObject:str];
//    }
    
//    self.tabBarView = [[NavigationTabBars alloc]initWithTitles:[list copy]];
//    self.tabBarView = [[NavigationTabBars alloc]init];
//    [self.view addSubview:self.tabBarView];
//    self.tabBarView.titles = list;
//    self.tabBarView.backgroundColor = [UIColor orangeColor];
//    
//    self.tabBarView.frame = CGRectMake(0, 200, kScreenWidth, 40);
//    [self.tabBarView.view setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    self.tabBarView.view.frame = CGRectMake(0, 100, kScreenWidth, 40);
//    self.tabBarView.frame = CGRectMake(0, 100, kScreenWidth, 40);
//    [self addChildViewController:self.tabBarView];
    
    
    

    
    
    __block UIButton *btnItemRight = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btnItemRight];
/*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
//            [rightItem setTitle:[NSString stringWithFormat:@"%zu%zu%zu%zu",index,index,index,index]];
//            NSLog(@"%zu",index);
//            sleep(1);
//        });
        
        __block NSUInteger count = 0;
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (count < 10) {
                count++;
                
                [rightItem setTitle:[NSString stringWithFormat:@"%lu%lu%lu%lu",(unsigned long)count,(unsigned long)count,(unsigned long)count,(unsigned long)count]];
                            NSLog(@"%lu",count);
                
            }else{
                dispatch_source_cancel(timer);
            }
        });
//        dispatch_resume(timer); *_timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//        dispatch_source_set_event_handler(_timer, ^{
//            if (timeout<=0) {
//                dispatch_source_cancel(_timer);
//                
//                _timer = nil;
//                //时间结束
//            }else{
//                //没到固定时间
//                timeout--;
//            }
//        });
//        dispatch_resume(_timer);
    });
*/
    
    __block NSUInteger count = 0;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (count < 10) {
            count++;
            
            [rightItem setTitle:[NSString stringWithFormat:@"%lu%lu%lu%lu",(unsigned long)count,(unsigned long)count,(unsigned long)count,(unsigned long)count]];
            NSLog(@"%lu",count);
            
        }else{
            dispatch_source_cancel(timer);
        }
    });
    
    self.navigationItem.rightBarButtonItem = rightItem;

    

}

- (void)tapAction:(UIGestureRecognizer *)gest{
    NSLog(@"单击！");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.itemList.count;
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentidier = @"CellIdentidier";
    FirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentidier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.textLabel.text = _itemList[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.indexPath = indexPath;
    cell.CellClick = ^(NSIndexPath *indexPath){
        NSLog(@"%ld",indexPath.row);
    };
    
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
