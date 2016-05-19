//
//  ViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "ViewController.h"

#import "RootListTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:.0 green:0.5 blue:0.5 alpha:1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        RootListTableViewController *vc = [[RootListTableViewController alloc] initWithNibName:@"RootListTableViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    });
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
