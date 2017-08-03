//
//  WHShopOrderCountView.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderCountView.h"
#import "WHShopOrderFoodModel.h"




@interface WHShopOrderCountView ()

@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation WHShopOrderCountView

+ (instancetype)shopOrderCountView {
    return [[[UINib nibWithNibName:@"WHShopOrderCountView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
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
    // 更新初始状态
    [self updateState];
}

#pragma mark 减号
- (IBAction)minusBtnClick {
    
    // 直接操作模型中的属性值
    _foodModel.count--;
    
    [self updateState];
}

#pragma mark - 加号
- (IBAction)addBtnClick {
    _foodModel.count++;
    
    [self updateState];
}

#pragma mark - 更新状态
- (void)updateState {
    // 如果当前数量是0它就两个都隐藏
    _minusBtn.hidden = (_foodModel.count == 0);
    _countLabel.hidden = (_foodModel.count == 0);
    
    // 显示数量
    _countLabel.text = @(_foodModel.count).description;
}



- (void)setFoodModel:(WHShopOrderFoodModel *)foodModel {
    _foodModel = foodModel;
    
    [self updateState];
}


@end
