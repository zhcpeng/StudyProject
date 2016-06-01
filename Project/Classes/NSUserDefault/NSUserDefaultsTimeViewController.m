//
//  NSUserDefaultsTimeViewController.m
//  Project
//
//  Created by zhcpeng on 16/5/25.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "NSUserDefaultsTimeViewController.h"

@interface NSUserDefaultsTimeViewController ()

@property (nonatomic , copy) NSString *string;

@end

@implementation NSUserDefaultsTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSUserDefaults 效率";
    
    [[NSUserDefaults standardUserDefaults] setObject:@"test" forKey:@"key"];
    
    
    self.string = @"11111";
    
    clock_t start,finish;
    double duration;
    start = clock();

    //
    for (int i = 0; i < 100; i++) {
//        NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
//        [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
//        NSString *newString = self.string;
        
//        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSDate *date = [NSDate date];
        NSDateFormatter *famtter = [[NSDateFormatter alloc]init];
        [famtter setDateFormat:@"yyyy-MM-DD"];
        NSString *dateString = [famtter stringFromDate:date];
    }
    
    //
    
    finish = clock();
    duration = (double)(finish - start)/CLOCKS_PER_SEC;
    printf("耗时%f ms\n",1000 * duration);

    
    
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
