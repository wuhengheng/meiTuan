//
//  HMShopCarView.m
//  HMWaiMai
//
//  Created by apple on 2017/8/5.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "WHShopCarView.h"

@implementation WHShopCarView

+ (instancetype)shopCarView {
    return [[[UINib nibWithNibName:@"WHShopCarView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
}

@end
