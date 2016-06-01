//
//  NSPredicateViewController.m
//  Project
//
//  Created by zhcpeng on 16/5/26.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "NSPredicateViewController.h"

@interface NSPredicateViewController ()

@end

@implementation NSPredicateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"for in 与 NSPredicate";
    
    
    NSMutableArray *list = [NSMutableArray array];
    int i = 100;
    while (i--) {
        NSPredicateModel *model = [[NSPredicateModel alloc]init];
        model.value = arc4random() % 100;
        [list addObject:model];
    }
    
    clock_t start,finish;
    double duration;
    start = clock();
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"value == 10"];
    NSArray *result = [list filteredArrayUsingPredicate:pre];
    
    
    
    
    finish = clock();
    duration = (double)(finish - start)/CLOCKS_PER_SEC;
    printf("耗时%f ms\n",1000 * duration);
    
    
    
    clock_t start2,finish2;
    double time2;
    
    start2 = clock();
    
    NSMutableArray *result2 = [NSMutableArray array];
    for (NSPredicateModel *model in list) {
        if (model.value == 10) {
            [result2 addObject:model];
        }
    }
    
    
    finish2 = clock();
    time2 = (double)(finish2 - start2)/CLOCKS_PER_SEC;
    printf("耗时%f ms\n",1000 * time2);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
