//
//  FirstViewCell.h
//  Project
//
//  Created by zhcpeng on 16/3/14.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewCell : UITableViewCell

- (IBAction)buttonAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (copy, nonatomic) void(^CellClick)(NSIndexPath *indexPath);

//typedef void(^SDWebImageCompletionBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);
//@property (copy, nonatomic) SDWebImageNoParamsBlock cancelBlock;
//typedef void(^SDWebImageNoParamsBlock)();

@end
