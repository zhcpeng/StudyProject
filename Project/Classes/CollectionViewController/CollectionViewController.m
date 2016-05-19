//
//  CollectionViewController.m
//  Project
//
//  Created by zhcpeng on 16/3/21.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

#import "CollectionViewController.h"

#import "CollectionViewCell.h"

#define kPodding 10
#define kWidth ((kScreenWidth - kPodding * 5) / 4.0)

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(kWidth, kWidth)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.minimumInteritemSpacing = kPodding;  //行间距
//    flowLayout.minimumLineSpacing = 10;
    _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.backgroundColor = kUIColorFromRGB(0x930000);
    [_myCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.view addSubview:_myCollectionView];
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _itemList = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        [_itemList addObject:@(i)];
    }
    
    
    
}

#pragma mark - collectionView DataSource Or delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return _itemList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kWidth, kWidth);
//    return CGSizeMake(k, <#CGFloat height#>)
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kPodding, kPodding, kPodding, kPodding);
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
