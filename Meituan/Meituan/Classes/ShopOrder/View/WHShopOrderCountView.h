//
//  WHShopOrderCountView.h
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHShopOrderFoodModel,WHShopOrderCountView;
typedef enum : NSUInteger {
    WHShopOrderCountViewBtnTypeAdd,
    WHShopOrderCountViewBtnTypeMinus
} WHShopOrderCountViewBtnType;


@protocol WHShopOrderCountViewDelegate <NSObject>

@optional
- (void)shopOrderCountViewValueChange:(WHShopOrderCountView *)countView;

@end


@interface WHShopOrderCountView : UIView
@property (nonatomic, strong) WHShopOrderFoodModel *foodModel;

@property (nonatomic, assign) WHShopOrderCountViewBtnType type;
/// 加号按钮
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic, weak) id<WHShopOrderCountViewDelegate> delegate;

+ (instancetype)shopOrderCountView;
@end
