//
//  RootListTableViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "RootListTableViewController.h"

//#import "FirstViewController.h"
//#import "MasonryViewController.h"
//#import "MasonryListViewController.h"
//#import "AutoHeightCellViewController.h"
//#import "CollectionViewController.h"

@interface RootListTableViewController ()

@end

@implementation RootListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.itemList = [NSMutableArray array];
    [_itemList addObject:@"FirstViewController"];
    [_itemList addObject:@"MasonryViewController"];
    [_itemList addObject:@"MasonryListViewController"];
    [_itemList addObject:@"AutoHeightCellViewController"];
    [_itemList addObject:@"CollectionViewController"];
    [_itemList addObject:@"NavBarViewController"];
    [_itemList addObject:@"TextFieldViewController"];
    [_itemList addObject:@"UILabelMaxViewController"];
    [_itemList addObject:@"YYLabelViewController"];
    [_itemList addObject:@"NSUserDefaultsTimeViewController"];
    [_itemList addObject:@"NSPredicateViewController"];
    [_itemList addObject:@"ListViewController"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentidier = @"CellIdentidier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentidier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentidier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _itemList[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc;
    NSString *className = _itemList[indexPath.row];
    NSString *path = [[NSBundle mainBundle] pathForResource:className ofType:@"xib"];
    if (path.length > 0) {
        vc = [(UIViewController *)[NSClassFromString(className) alloc]initWithNibName:className bundle:nil];
    }else{
        vc = [[NSClassFromString(className) alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];

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
