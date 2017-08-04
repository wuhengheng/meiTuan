//
//  WHFoodDetailFlowLayout.m
//  Meituan
//
//  Created by wh on 2017/8/4.
//  Copyright © 2017年 wh. All rights reserved.
//

#import "WHFoodDetailFlowLayout.h"

@implementation WHFoodDetailFlowLayout
- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
}
@end
