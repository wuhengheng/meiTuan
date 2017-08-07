//
//  HMShopCarView.m
//  HMWaiMai
//
//  Created by apple on 2017/8/5.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "WHShopCarView.h"

#import "WHShopCarModel.h"

#import "WHShopOrderFoodModel.h"

@interface WHShopCarView ()<CAAnimationDelegate>
/// 购物车小按钮
@property (weak, nonatomic) IBOutlet UIButton *carBtn;
/// 总价
@property (weak, nonatomic) IBOutlet UILabel *sum_priceLabel;
/// 请添加
@property (weak, nonatomic) IBOutlet UIButton *pleaseAddBtn;

@property (nonatomic, weak) UILabel *foodCountLabel;

@end
@implementation WHShopCarView

+ (instancetype)shopCarView {
    return [[[UINib nibWithNibName:@"WHShopCarView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    // 添加选购视图数量label
    UILabel *foodCountLabel = [UILabel makeLabelWithText:@"" andTextFont:12 andTextColor:[UIColor whiteColor]];
    foodCountLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    
    [self.carBtn addSubview:foodCountLabel];
    
    [foodCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.width.height.offset(16);
    }];
    
    // 设置label中的内容居中
    foodCountLabel.textAlignment = NSTextAlignmentCenter;
    // 让字体自适应
    foodCountLabel.adjustsFontSizeToFitWidth = YES;
    
    // 让基线居中
    foodCountLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    // 让它默认隐藏
    foodCountLabel.hidden = YES;
    
    _foodCountLabel = foodCountLabel;
}


- (void)setShopCarModel:(WHShopCarModel *)shopCarModel {
    _shopCarModel = shopCarModel;
    
    NSNumber *sum_price = [shopCarModel.foodModelArray valueForKeyPath:@"@sum.min_price"];
    
    // 设置总价
    _sum_priceLabel.text = [NSString stringWithFormat:@"¥ %@", sum_price];
    
    // 设置购物车小按钮的状态
    // 当按钮设置为选中状态时再点击会看到按钮的默认状态
    //    _carBtn.selected = shopCarModel.foodModelArray.count;
    //
    //    _carBtn.userInteractionEnabled = NO;
    UIImage *image = [UIImage imageNamed:shopCarModel.foodModelArray.count ? @"button_shoppingCart_noEmpty" : @"button_shoppingCart_empty"];
    [_carBtn setImage:image forState:UIControlStateNormal];
    
    
    // 系统样式的按钮在修改里面内容时可能会用动画,如果不想要,就把它改成custom
    [_pleaseAddBtn setTitle:shopCarModel.foodModelArray.count ? @"结  账" : @"请添加" forState:UIControlStateNormal];
    // 更改按钮背景颜色
    _pleaseAddBtn.backgroundColor = shopCarModel.foodModelArray.count ? [UIColor primaryYellowColor] : [UIColor lightGrayColor];
    
    
    // 是否要显示数量label
    _foodCountLabel.hidden = (shopCarModel.foodModelArray.count == 0);
    _foodCountLabel.text = @(shopCarModel.foodModelArray.count).description;
    
//    [self anim];
    
}

- (void)animWithStartPoint:(CGPoint)startPoint {
    // 动画的小红点
    UIImageView *animImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_common_point"]];
    [self addSubview:animImageView];
    
    // 关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    // 创建关键帧动画路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 起点
  //  CGPoint startPoint = CGPointMake(350, -300);
    
    // 线的终点,在小购物车中心
    CGPoint endPoint = _carBtn.center;
    
    // 起点
    [path moveToPoint:startPoint];
    // 通过传入终点及一个控制点 来画一个贝塞尔曲线
    [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(startPoint.x - 150, startPoint.y - 100)];
    
    // 指定动画属性
    anim.keyPath = @"position";
    
    //  指定动画路径
    anim.path = path.CGPath;
    
    anim.duration = 2;
    anim.repeatCount = 1;
    
    // 动画完成后停在动画后的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    
    anim.delegate = self;
    
    
    // 把小线点存到动画 只有遵守了CAAction的协议才能这样干
    [anim setValue:animImageView forKey:@"animImageView"];

    
    [animImageView.layer addAnimation:anim forKey:nil];
    
    

    
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    // 动画完成之后从父控件上移除
    [[anim valueForKeyPath:@"animImageView"] removeFromSuperview];
    
    [UIView animateWithDuration:0.25 animations:^{
        _carBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            _carBtn.transform = CGAffineTransformIdentity;
        }];
    }];
    
}

@end
