//
//  FirstViewController.h
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *itemList;         /**< 数据列表 */
@property (weak, nonatomic) IBOutlet UITableView *myTableView;  /**< 列表 */
@end
