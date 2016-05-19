//
//  CMAltimeterViewController.m
//  Project
//
//  Created by zhcpeng on 16/4/22.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "CMAltimeterViewController.h"

//#import "CMAltimeter.h"

//#import <CoreMotion>
@import CoreMotion;

@interface CMAltimeterViewController ()

@end

@implementation CMAltimeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    if([CMAltimeter isRelativeAltitudeAvailable]){
//        CMAltimeter *altimeter = [[CMAltimeter alloc] init];
//        [altimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:^(CMAltitudeData *altitudeData, NSError *error) {
//            
//            if(error)
//                [label setText:[NSString stringWithFormat:@"%@",error.localizedDescription]];
//            else
//                [label setText:[NSString stringWithFormat:@"%@",altitudeData.relativeAltitude]];
//            
//        }];
//    }
//    else{
//        [label setText:@"That's not iPhone 6 for sure ;)"];
//    }
    
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
