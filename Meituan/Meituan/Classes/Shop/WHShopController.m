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

// 头部视图的最大和最小高度
#define KShopHeaderViewMaxHeight   180
#define KShopHeaderViewMinHeight   64
@interface WHShopController ()

//头部视图
@property (nonatomic, weak) UIView *shopHeaderView;

//右边按钮
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
@end


@implementation WHShopController

- (void)viewDidLoad {
    [self setupUI];
    
    
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor greenColor];

  
    [self settingNormal];
    

}

#pragma - mark 默认设置
-(void)settingNormal{
    
    
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
    UIView *shopHeaderView = [[UIView alloc] init];
    shopHeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:shopHeaderView];
    
    
    [shopHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(KShopHeaderViewMaxHeight);
    }];
    
    
    
    
    _shopHeaderView = shopHeaderView;
}





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










//push   shop控制器
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    WHFoodDetailController *foodDeatilVC = [[WHFoodDetailController alloc] init];
//
//    [self.navigationController pushViewController:foodDeatilVC animated:YES];
//
//}






@end
