//
//  RACSampleViewController.m
//  Project
//
//  Created by ZhangChunpeng on 16/6/20.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "RACSampleViewController.h"

@interface RACSampleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
- (IBAction)buttonClicked:(UIButton *)sender;

@end

@implementation RACSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(UIButton *)sender {
}
@end
