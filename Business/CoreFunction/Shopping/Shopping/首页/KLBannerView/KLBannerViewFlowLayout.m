//
//  HZBannerViewFlowLayout.m
//
//  Created by sssssssss on 2020/8/11.
//  Copyright © 2020 . All rights reserved.
//
 

#import "KLBannerViewFlowLayout.h"

@implementation KLBannerViewFlowLayout

//设置放大动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *arr = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    //屏幕左边
    CGFloat leftX = self.collectionView.contentOffset.x+12;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = attributes.frame.origin.x - leftX;
        if (distance > 0) {//在右边
            CGFloat apartScale = distance/self.collectionView.bounds.size.width;
            CGFloat scale = fabs(cos(apartScale * M_PI/3.0));
//            attributes.transform = CGAffineTransformMakeTranslation(12-(attributes.frame.size.width *(1-scale))/2.0, 0);
            attributes.transform = CGAffineTransformMakeScale(scale, scale);
            
        }
    }
    return arr;
}
 
/*
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
    
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.frame.origin.x - targetP.x) - self.collectionView.bounds.size.width+12;
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    // 移动间距
    targetP.x += minDelta;
    if (targetP.x < 0) {
        targetP.x = 0;
    }
    return targetP;
}
  
- (void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
*/

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

 

@end
