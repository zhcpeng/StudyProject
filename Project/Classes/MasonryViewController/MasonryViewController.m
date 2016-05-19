//
//  MasonryViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/16.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()

//@property (nonatomic, weak) <#type#> *<#value#>;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WS(ws);
    
    
    
//    uint podding = 10;
//    VAI(self.view, myView)
//    myView.backgroundColor = kUIColorFromRGB(0x888800);
//    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(podding);
//        make.top.mas_equalTo(podding);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(60);
//        //            make.top.equalTo(wSelf.contentView.mas_top).offset(podding);
//    }];
//    return;
    
    
    
    VAI(self.view, sv)
    
//    UIView *sv = [UIView new];
////    [sv showPlaceHolder];
    sv.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(300, 500));
//        make.edges.equalTo(ws.view);
    }];
//    return;
    
//    UIScrollView *scrollView = UIScrollView.new;
//    scrollView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:scrollView];
//    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    
    
    
//    UIView *<#view#> = [[UIView alloc]init];
//    [self.view addSubview:<#view#>];
    
//    UIView *view = [[UIView alloc]init];
//    [self.view addSubview:view];
    
//    VAI(self.view, view2)
//    view2.backgroundColor = [UIColor redColor];
    
    
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [sv addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];

    

    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    int count = 10;
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom).offset(5);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
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
