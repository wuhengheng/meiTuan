//
//  WHShopOrderFoodCell.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderFoodCell.h"
#import "WHShopOrderFoodModel.h"
#import "WHShopOrderCountView.h"


@interface WHShopOrderFoodCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *_descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *month_saled_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *praise_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *min_priceLabel;

///描述顶部约束
@property(weak,nonatomic) IBOutlet NSLayoutConstraint *descTopConstraint;

@property (nonatomic, weak) WHShopOrderCountView *countView;


@end
@implementation WHShopOrderFoodCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    //创建计算控件
    WHShopOrderCountView *countView = [WHShopOrderCountView shopOrderCountView];
    
    [self.contentView addSubview:countView];
    
    
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.offset(-8);
        make.size.mas_offset(countView.bounds.size);
    }];
    
    
    _countView = countView;
    
    
}

-(void)setFoodModel:(WHShopOrderFoodModel *)foodModel{
    _foodModel = foodModel;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]] placeholderImage:[UIImage imageNamed:@"img_food_loading"]];
    
    
    _nameLabel.text = foodModel.name;
    
    __descriptionLabel.text = foodModel.desc;
    
    
    _month_saled_contentLabel.text = foodModel.month_saled_content;
    
    _praise_contentLabel.text = foodModel.praise_content;
    
    _min_priceLabel.text = [NSString stringWithFormat:@"¥ %@",@(foodModel.min_price)];
    
    _descTopConstraint.constant = ([foodModel.desc stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0)? 0:8;
    
    
    _countView.foodModel = foodModel;
    
}



@end
