//
//  WHShopOrderController.m
//  Meituan
//
//  Created by wh on 2017/7/31.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderController.h"
#import "WHShopOrderCategoryModel.h"
#import "WHShopOrderFoodModel.h"
#import "WHShopOrderCategoryCell.h"
#import "WHShopOrderFoodHeaderView.h"
#import "WHShopOrderFoodCell.h"



@interface WHShopOrderController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *categoryTableView;

@end
static NSString *categoryCellID = @"categoryCellID";
static NSString *foodCellID = @"foodCellID";
static NSString *foodHeaderViewID = @"foodHeaderViewID";

@implementation WHShopOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupUI];
}

#pragma mark - 界面搭建
- (void)setupUI {
    
    // 类型表格
    [self settingCategoryTableView];
    
    // 食物表格
    [self settingFoodTableView];
    
}
#pragma mark - 类型表格处理
- (void)settingCategoryTableView {
    
    UITableView *categoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:categoryTableView];
    
    [categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(100);
    }];
    
    _categoryTableView = categoryTableView;
    
    categoryTableView.delegate = self;
    categoryTableView.dataSource = self;
    
    // 注册cell
    [categoryTableView registerClass:[WHShopOrderCategoryCell class] forCellReuseIdentifier:categoryCellID];
    
    
    // 设置行高
    categoryTableView.rowHeight = 60;
    
    // 隐藏分割线
    categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}
#pragma mark - 食物表格处理
- (void)settingFoodTableView {
    
    UITableView *foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:foodTableView];
    
    [foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(_categoryTableView.mas_right).offset(0);
    }];
    
    foodTableView.delegate = self;
    foodTableView.dataSource = self;
    
    
     UINib *nib = [UINib nibWithNibName:@"WHShopOrderFoodCell" bundle:nil];
    // 注册cell
    [foodTableView registerNib:nib forCellReuseIdentifier:foodCellID];


    // 注册头部视图
    [foodTableView registerClass:[WHShopOrderFoodHeaderView class] forHeaderFooterViewReuseIdentifier:foodHeaderViewID];
    
    // 设置每一组的组头统一高度
    foodTableView.sectionHeaderHeight = 30;
    
    // 设置预估行高
    foodTableView.estimatedRowHeight = 150;
}

#pragma mark - 返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _categoryTableView) { // 返回类别表格的组数
        return 1;
    }
    
    return _categoryData.count; // 类别模型的个数就表示食物表格的组数
}

#pragma mark - 返回每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _categoryTableView) { // 返回类型表格行数
        return _categoryData.count; // 类型模型有多少个就表格类型表格有多少行
    }
    
    return _categoryData[section].spus.count;// 当前组有多少个食物就表示食物表格当前组有多少行
}

#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 返回类型表格cell
    if (tableView == _categoryTableView) {
        WHShopOrderCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID forIndexPath:indexPath];
        // 取出类别模型
        // 给cell传模型
        cell.categoryModel = _categoryData[indexPath.row];
        return cell;
        
    }
    
    
    
    // 返回食物表格cell
    WHShopOrderFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodCellID forIndexPath:indexPath];
    // 先取出表格一组食物的类型模型
    WHShopOrderCategoryModel *categoryModel = _categoryData[indexPath.section];
    // 取出表格一个食物的模型
    WHShopOrderFoodModel *foodModel = categoryModel.spus[indexPath.row];
    
    cell.foodModel = foodModel;
    
  //  cell.textLabel.text = foodModel.name;
    
    return cell;
}

// 返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WHShopOrderFoodHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:foodHeaderViewID];
    
    headerView.categoryModel = _categoryData[section];
    
    return headerView;
}
@end
