//
//  WHFoodDetailController.m
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHFoodDetailController.h"
#import "WHNavigationBar.h"
#import "WHFoodDetailFlowLayout.h"
#import "WHShopOrderFoodModel.h"
#import "WHShopOrderCategoryModel.h"
#import "WHFoodDetailCell.h"
@interface WHFoodDetailController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
static NSString *foodDetailCellID = @"foodDetailCellID";

@implementation WHFoodDetailController

- (void)viewDidLoad {
    [self setupUI]; // 注意导航条层次问题
    [super viewDidLoad];
    
    
    
    self.navBar.bgImageView.alpha = 0;// 让导航条背景图片透明
    
    self.navBar.tintColor = [UIColor whiteColor];
    
    // 不让系统再帮忙自动内缩
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)setupUI {
    // 创建布局对象
    WHFoodDetailFlowLayout *flowLayout = [[WHFoodDetailFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    [self.view addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    collectionView.bounces = NO;
    
    collectionView.pagingEnabled = YES;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"WHFoodDetailCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:foodDetailCellID];
    
    collectionView.backgroundColor = [UIColor purpleColor];
    
}

#pragma mark -数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _categoryData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 食物模型的个数就表示 当前组格子的个数
    return _categoryData[section].spus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建
    WHFoodDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foodDetailCellID forIndexPath:indexPath];
    // 2.传递数据
    cell.foodModel = _categoryData[indexPath.section].spus[indexPath.row];
    // 3.返回cell
    return cell;
    
}


@end
