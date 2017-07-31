//
//  WHNavigationController.m
//  Meituan
//
//  Created by wh on 2017/7/30.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHNavigationController.h"
#import "WHBaseController.h"

@interface WHNavigationController ()

@end

@implementation WHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 把导航控制器自带的导航条隐藏掉
    self.navigationBar.hidden = YES;


}




- (void)pushViewController:(WHBaseController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    // 只给导航根控制器以外的控制器添加左边返回按钮
    if (self.childViewControllers.count > 1) {
        
        
        // 给导航条设置左边按钮
        viewController.navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
        
    }
    
}

// 点击左边按钮返回
- (void)back {
    [self popViewControllerAnimated:YES];
}

// 实现此方法让子控制器去设置状态栏的样式
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}


@end
