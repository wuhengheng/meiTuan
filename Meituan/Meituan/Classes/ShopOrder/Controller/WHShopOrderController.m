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
#import "WHFoodDetailController.h"
#import "WHShopCarView.h"
#import "WHShopOrderCountView.h"
#import "WHShopCarModel.h"






@interface WHShopOrderController ()<UITableViewDelegate, UITableViewDataSource,WHShopOrderCountViewDelegate>


///分类tableView
@property (nonatomic, weak) UITableView *categoryTableView;

///食物tableView
@property (nonatomic, weak) UITableView *foodTableView;


/// 记录类别表格是不是手动选中
@property (nonatomic, assign) BOOL categoryTableViewClick;


@property (nonatomic, weak) WHShopCarView *shopCarView;


/// 保存所有选购的食物模型
@property (nonatomic, strong) NSMutableArray<WHShopOrderFoodModel *> *foodModelArray;

// 购物车模型
@property (nonatomic, strong) WHShopCarModel *shopCarModel;


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
    
    //添加购物车
    [self settingShopCarView];
    
    
    // 类型表格
    [self settingCategoryTableView];
    
    // 食物表格
    [self settingFoodTableView];
    
    [self.view bringSubviewToFront:_shopCarView];
    
    // 给表格装到数组中,传递出去
    _tableViews = @[_categoryTableView, _foodTableView];
    
}

#pragma mark - 添加购物车
- (void)settingShopCarView {
    
    WHShopCarView *shopCarView = [WHShopCarView shopCarView];
    [self.view addSubview:shopCarView];
    
    [shopCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(shopCarView.bounds.size.height);
    }];
    
    _shopCarView = shopCarView;
}


#pragma mark - 类型表格处理
- (void)settingCategoryTableView {
    
    UITableView *categoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:categoryTableView];
    
    [categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(100);
        make.bottom.equalTo(_shopCarView.mas_top).offset(0);
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
    
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 默认类别表格选中第0行
    [categoryTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    
    
}
#pragma mark - 食物表格处理
- (void)settingFoodTableView {
    
    UITableView *foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:foodTableView];
    
    [foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.left.equalTo(_categoryTableView.mas_right).offset(0);
        make.bottom.equalTo(_shopCarView.mas_top).offset(0);
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
    
    
    _foodTableView = foodTableView;
    
    
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
    
    //给countView设置代理
    cell.countView.delegate = self;
    
    
    
    return cell;
}

// 返回每一组的头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WHShopOrderFoodHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:foodHeaderViewID];
    
    headerView.categoryModel = _categoryData[section];
    
    return headerView;
}


#pragma mark - 选中cell调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_foodTableView == tableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        
        // 创建食物详情控制器
        WHFoodDetailController *foodDetailVC = [[WHFoodDetailController alloc] init];
        // 给食物详情控制器传所有食物模型
        foodDetailVC.categoryData = _categoryData;
        
         foodDetailVC.indexPath = indexPath;
        
        // 给食物详情控制器传购物车模型
        foodDetailVC.shopCarModel = self.shopCarModel;
        
        [self.navigationController pushViewController:foodDetailVC animated:YES];
   
        
    }
    
    
    if (_categoryTableView == tableView) {
        
        _categoryTableViewClick = YES;// 当前正在手动选中
        // 用类别表格个的索引来当 食物表格组的索引
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        // 让食物表格滚动
        [_foodTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果当前是食物表格在滚动
    if (_foodTableView == scrollView && _categoryTableViewClick == NO) {
        
        NSIndexPath *indexPath = [[_foodTableView indexPathsForVisibleRows] firstObject];
        
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
        [_categoryTableView selectRowAtIndexPath:selectIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
    }
    
}

// 当食物表格动画方法滚动停下来后,此时类别表格的选中再设置为NO
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _categoryTableViewClick = NO;
}

- (void)shopOrderCountViewValueChange:(WHShopOrderCountView *)countView {
    
    switch (countView.type) {
        case WHShopOrderCountViewBtnTypeAdd:
            
          //  NSLog(@"多选了一个食物");
            // 选购一个食物就把这个食物添加到数组
            [self.foodModelArray addObject:countView.foodModel];
         //   NSLog(@"%@", _foodModelArray);
            
            
            //            NSLog(@"%@", NSStringFromCGPoint(countView.addBtn.center));
            // 转换控件坐标系时,以它的直接父控件调用此方法 第一个参数传入要转换的控件位置 第二个参数传数要以那个控件的左上角为原点
            CGPoint startPoint = [countView convertPoint:countView.addBtn.center toView:_shopCarView];
            
            
            // 传入一个起点执行动画
            [self.shopCarView animWithStartPoint:startPoint];
            break;
            
        case WHShopOrderCountViewBtnTypeMinus:
            
            // 如果直接用removeObject:方法会把数组中同一个地址的对象全部删除,
            //            [self.foodModelArray removeObject:countView.foodModel];
            // 删除数组中指定索引的对象,一次只会删除一个
            [self.foodModelArray removeObjectAtIndex:[self.foodModelArray indexOfObject:countView.foodModel]];
            
            
        //    NSLog(@"%@", _foodModelArray);
            
            
            
            break;
            
        default:
            break;
    }

    
}


- (NSMutableArray<WHShopOrderFoodModel *> *)foodModelArray {
    if (_foodModelArray == nil) {
        _foodModelArray = [NSMutableArray array];
    }
    return _foodModelArray;
}
@end
