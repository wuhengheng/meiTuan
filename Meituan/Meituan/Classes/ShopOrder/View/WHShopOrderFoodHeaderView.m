//
//  WHShopOrderFoodHeaderView.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderFoodHeaderView.h"
#import "WHShopOrderCategoryModel.h"
@implementation WHShopOrderFoodHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //    });
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)drawRect:(CGRect)rect {
    
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = [UIColor blackColor];
}

- (void)setCategoryModel:(WHShopOrderCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.name;
}


@end
