//
//  WHShopController.m
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopController.h"
#import "WHFoodDetailController.h"
#import "WHNavigationBar.h"
#import "WHShopOrderController.h"
#import "WHShopCommentController.h"
#import "WHShopInfoController.h"
#import "WHShopPOI_InfoModel.h"
#import "WHShopHeaderView.h"

// 头部视图的最大和最小高度
#define KShopHeaderViewMaxHeight   180
#define KShopHeaderViewMinHeight   64
@interface WHShopController ()<UIScrollViewDelegate>

//头部视图
@property (nonatomic, weak) WHShopHeaderView *shopHeaderView;

//右边按钮
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

@property (nonatomic, weak) UIView *shopTagView;
@property (nonatomic, weak) UIView *shopTagLineView; // 小黄条
@property (nonatomic, weak) UIScrollView *scrollView;
/// 头部模型数据
@property (nonatomic, strong) WHShopPOI_InfoModel *shopPOI_infoModel;


@end


@implementation WHShopController

- (void)viewDidLoad {
    
    
    
    
    // 加载数据
    [self loadFoodData];
    
    
    
    [self setupUI];
    
    
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor greenColor];

  //默认设置
    [self settingNormal];
    

}

#pragma - mark 默认设置
-(void)settingNormal{
    
    //设置导航标题
    self.navItem.title = @"似曾相识燕归来";
    
    
    // 设置导航条标题文字颜色 为完全透明
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:0]};
    
    // 默认导航条的背景图片完全透明
    self.navBar.bgImageView.alpha = 0;
    
    
    // 设置导航条右边分享按钮
    _rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navItem.rightBarButtonItem = _rightButtonItem;
    self.navBar.tintColor = [UIColor whiteColor];
    
    
    // 添加平移
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    // 手势添加到控制器的view上
    [self.view addGestureRecognizer:pan];

    
    
}

- (void)setupUI {
    
    
    //创建头部视图
    [self settingShopHeaderView];
    
    
    //  添加标签栏
    [self settingShopTagView];
    
    //  添加滚动视图
    [self settingShopScrollView];
   
}

#pragma - mark 添加头部视图
-(void)settingShopHeaderView{
    
    //创建头部视图
    WHShopHeaderView *shopHeaderView = [[WHShopHeaderView alloc] init];
    shopHeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:shopHeaderView];
    
    
    [shopHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(KShopHeaderViewMaxHeight);
    }];
    
    
    
    
    _shopHeaderView = shopHeaderView;
    
    
    // 给头部视图传模型
    shopHeaderView.shopPOI_infoModel = _shopPOI_infoModel;
    
}

#pragma - mark 平移手势
- (void)panGesture:(UIPanGestureRecognizer *)pan {
    
    // 获取平移的距离
    CGPoint p = [pan translationInView:pan.view];
    // 头部视图的高度
    CGFloat shopHeaderViewUpdateHeight = _shopHeaderView.bounds.size.height;
    
    [_shopHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        //如果它当前的高度加上平移的值 <= 64 直接就让它变到64
        if (p.y + shopHeaderViewUpdateHeight < KShopHeaderViewMinHeight) {
            
            make.height.offset(KShopHeaderViewMinHeight);
            
            //如果它当前的高度加上平移的值 >= 180 直接就让它变到180
        } else if (p.y + shopHeaderViewUpdateHeight >= KShopHeaderViewMaxHeight) {
            
            make.height.offset(KShopHeaderViewMaxHeight);
            
        } else { // 在大于 64 及小于180之间让它慢慢变化
            
            make.height.offset(p.y + shopHeaderViewUpdateHeight);
        }
        
        
        
    }];
    
    
    // 计算导航条背景图片的透明度
    CGFloat alpha = [@(shopHeaderViewUpdateHeight) resultWithValue1:HMValueMake(64, 1) andValue2:HMValueMake(180, 0)];
    
    self.navBar.bgImageView.alpha = alpha;
    
    // 设置导航条标题文字颜色和导航条背景变化是一样的
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:alpha]};
    
    // 计算分享按钮的白色值
    CGFloat White = [@(shopHeaderViewUpdateHeight) resultWithValue1:HMValueMake(64, 0.4) andValue2:HMValueMake(180, 1)];
    
    // 设置分享按钮的颜色
    self.navBar.tintColor = [UIColor colorWithWhite:White alpha:1];
    
    
//如果当前是180高度就用白色状态栏,反至用黑色
    if (shopHeaderViewUpdateHeight == KShopHeaderViewMaxHeight && self.statusBarStyle != UIStatusBarStyleLightContent) {
        
        self.statusBarStyle = UIStatusBarStyleLightContent;
        
    } else if (shopHeaderViewUpdateHeight == KShopHeaderViewMinHeight && self.statusBarStyle != UIStatusBarStyleDefault){
        self.statusBarStyle = UIStatusBarStyleDefault;
  }
    
   //  恢复到初始值
    [pan setTranslation:CGPointZero inView:pan.view];
    
}


#pragma mark - 添加标题栏
- (void)settingShopTagView {
    UIView *shopTagView = [[UIView alloc] init];
    
    shopTagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopTagView];
    
    [shopTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_shopHeaderView.mas_bottom).offset(0);
        make.height.offset(44);
    }];
    
    _shopTagView = shopTagView;
    
    
    // 添加标签栏中的按钮
    UIButton *orderBtn = [self makeSHopTagButtonWithTitle:@"点菜"];
    // 给点菜按钮设置默认就是加粗
    orderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    [self makeSHopTagButtonWithTitle:@"评价"];
    [self makeSHopTagButtonWithTitle:@"商家"];
    
    [shopTagView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    
    [shopTagView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    // TODO: 添加模拟滚动指示小黄条
    UIView *shopTagLineView = [[UIView alloc] init];
    shopTagLineView.backgroundColor = [UIColor primaryYellowColor];
    [shopTagView addSubview:shopTagLineView];
    
    [shopTagLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(4);
        make.bottom.offset(0);
        // 小黄条加约束的代码要写在按钮添加约束的后面
        make.centerX.equalTo(orderBtn).offset(0);
    }];
    
    _shopTagLineView = shopTagLineView;
}


#pragma mark - 创建及添加标签栏中的按钮
- (UIButton *)makeSHopTagButtonWithTitle:(NSString *)title {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    // 给按钮添加监听事件
    [btn addTarget:self action:@selector(shopTagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 用标签视图子控件的个数来当按钮的tag
    btn.tag = _shopTagView.subviews.count;
    
    // 把按钮添加到标签栏中
    [_shopTagView addSubview:btn];
    
    return btn;
}

#pragma mark - 点击标签栏中的按钮时调用此方法
- (void)shopTagBtnClick:(UIButton *)btn {
    
    // 动画的方法让scrollView中的内容滚动
    [_scrollView setContentOffset:CGPointMake(btn.tag * _scrollView.bounds.size.width, 0) animated:YES];
    
}

#pragma mark - 添加滚动视图
- (void)settingShopScrollView {
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.equalTo(_shopTagView.mas_bottom).offset(0);
    }];
    
    
    // 创建三个控制器
    WHShopOrderController *vc1 = [[WHShopOrderController alloc] init];
    WHShopCommentController *vc2 = [[WHShopCommentController alloc] init];
    WHShopInfoController *vc3 = [[WHShopInfoController alloc] init];
    NSArray *vcs = @[vc1, vc2, vc3];
    
    for (UIViewController *vc in vcs) {
        // 把控制器的view添加到scrollView中
        [scrollView addSubview:vc.view];
        
        // 建立父子控制器关系
        [self addChildViewController:vc];
        
        // 告诉父控制器已经添加好了
        [vc didMoveToParentViewController:self];
    }
    
    [scrollView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.equalTo(scrollView);
    }];
    
    [scrollView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    // 给scrollView设置代理
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
}


#pragma mark - 监听scrollView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 取小数页
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
   
    // 计算小黄条一次走的距离
    CGFloat transformOnceX = _shopTagView.bounds.size.width / (_shopTagView.subviews.count - 1);
    
    // 设置小黄条水平方向偏移
    // 控件加了约束后不要修改frame,但是可以修改transform,因为不是一套机制
    _shopTagLineView.transform = CGAffineTransformMakeTranslation(transformOnceX * page, 0);
    
}

#pragma mark - 手动拖拽滚动完全停下后来调用此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 要整页数
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 遍历标签栏中的所有子控件
    for (NSInteger i = 0; i < _shopTagView.subviews.count; i++) {
        
        // 获取子控件
        UIButton *btn = _shopTagView.subviews[i];
        
        // 判断当前控件是不是按钮
        if ([btn isKindOfClass:[UIButton class]]) {
            // i == 页数 刚就就对应相的按钮
            if (page == i) { // 如果当前页数和按钮对应时,就把按钮中的文字字体加粗
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            } else { // 反之就把按钮的文字再恢复到不加粗
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
        }
    }
    
}

#pragma mark - 代码方法滚动并且有动画时,滚动完停来会调用此方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 手动去调用 手动拖拽停下来的方法,去更新字体
    [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - 加载数据
- (void)loadFoodData {
    
    // 1.加载json 文件 ---> NSData
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil]];
    // 2. NSData ---> dict
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // 3.获取自己想要的头部视图的数据
    NSDictionary *poi_dict = jsonDict[@"data"][@"poi_info"];
    
    // 4.字典转模型
    WHShopPOI_InfoModel *poi_infoModel = [WHShopPOI_InfoModel shopPOI_infoWithDict:poi_dict];
    
    _shopPOI_infoModel = poi_infoModel;
    
    
}





//push   shop控制器
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    WHFoodDetailController *foodDeatilVC = [[WHFoodDetailController alloc] init];
//
//    [self.navigationController pushViewController:foodDeatilVC animated:YES];
//
//}






@end
