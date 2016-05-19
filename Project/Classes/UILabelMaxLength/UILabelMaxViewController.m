//
//  UILabelMaxViewController.m
//  Project
//
//  Created by zhcpeng on 16/5/13.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "UILabelMaxViewController.h"
#import "YYLabel.h"

@interface UILabelMaxViewController ()

@end

@implementation UILabelMaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    label.font = [UIFont systemFontOfSize:10];
//    label.preferredMaxLayoutWidth = kScreenWidth;
//    label.numberOfLines = 0;
//    label.textColor = [UIColor redColor];
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    [scroll addSubview:label];
//    label.text = @"111111";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *data = [[NSData alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"]];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
//        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:10] forWidth:kScreenWidth lineBreakMode:NSLineBreakByWordWrapping];
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, size.height + 100)];
        YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, size.height + 100)];
        label.font = [UIFont systemFontOfSize:10];
        label.preferredMaxLayoutWidth = kScreenWidth;
        label.numberOfLines = 0;
        label.textColor = [UIColor redColor];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [scroll addSubview:label];
        
        
        label.text = str;
//        CGSize size = [label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        label.frame = CGRectMake(0, 0, kScreenWidth, size.height+100);
        scroll.contentSize = CGSizeMake(kScreenWidth, size.height +20);
        
        
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
