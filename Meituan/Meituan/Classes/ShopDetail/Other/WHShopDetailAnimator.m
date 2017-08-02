//
//  WHShopDetailAnimator.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopDetailAnimator.h"

typedef enum : NSUInteger {
    WHShopDetailAnimatorTransitioningTypePresent,
    WHShopDetailAnimatorTransitioningTypeDismiss,
} WHShopDetailAnimatorTransitioningType;

@interface WHShopDetailAnimator ()<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) WHShopDetailAnimatorTransitioningType transitioningType;
@end
@implementation WHShopDetailAnimator


/// 此方法是modal时调用 谁来处理modal及modal的动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    // modal
    _transitioningType = WHShopDetailAnimatorTransitioningTypePresent;
    return self;
}

/// 此方法是dismiss时调用 谁来处理dismiss及dismiss的动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    // dismiss
    _transitioningType = WHShopDetailAnimatorTransitioningTypeDismiss;
    return self;
}


// 返回转场动画时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

// modal和dismiss时都会调用此方法
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    // 获取到要去的界面 在modal时toView就是商家详情界面的view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // 获取来源控制器的view,当dismiss时,formView是商家详情界面的view
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    // 获取到容器视图,modal出来的界面想要显示 必须要把它添加到容器视图中
    UIView *containerView = [transitionContext containerView];
    
    
    if (_transitioningType == WHShopDetailAnimatorTransitioningTypePresent) {
        // 一开始小的看不见
        toView.transform = CGAffineTransformMakeScale(0, 0);
        // 把modal出来的界面添加到容器视图中
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            // 恢复transform
            toView.transform = CGAffineTransformIdentity;
            
            
        } completion:^(BOOL finished) {
            
            // 转场完成后告诉系统转场完成
            [transitionContext completeTransition:YES];
        }];
        
        
        
    } else { // dismiss
        
        
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            // 恢复transform
            fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            
            
        } completion:^(BOOL finished) {
            
            // 转场完成后告诉系统转场完成
            [transitionContext completeTransition:YES];
        }];
        
    }
    
}

@end
