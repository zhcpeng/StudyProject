//
//  CollectionViewController.h
//  Project
//
//  Created by zhcpeng on 16/3/21.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *itemList;     ///< 数据列表

@end
