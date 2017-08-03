//
//  WHShopOrderFoodCell.m
//  Meituan
//
//  Created by wh on 2017/8/3.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHShopOrderFoodCell.h"
#import "WHShopOrderFoodModel.h"


@interface WHShopOrderFoodCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *_descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *month_saled_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *praise_contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *min_priceLabel;



@end
@implementation WHShopOrderFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFoodModel:(WHShopOrderFoodModel *)foodModel{
    _foodModel = foodModel;
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]]];
    
    _nameLabel.text = foodModel.name;
    
    
}



@end
