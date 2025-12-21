//
//  ShortVideoListCollectionLayout.m
//  ShortVideo
//
//  Created by KLC on 2020/6/30.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "VideoPlayListPageCollectionLayout.h"
#import <LibTools/LibTools.h>
@interface VideoPlayListPageCollectionLayout()
@property(nonatomic, assign) CGFloat lastProposedContentOffset;
@end
 
@implementation VideoPlayListPageCollectionLayout
- (void)prepareLayout{
    [super prepareLayout];
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置collectionView的cell大小
    self.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    //1. 获取UICollectionView停止的时候的可视范围
    CGRect rangeFrame;
    rangeFrame.size = self.collectionView.frame.size;
    rangeFrame.origin = proposedContentOffset;
    
    NSArray *array = [self layoutAttributesForElementsInRect:rangeFrame];
    
    //2. 计算在可视范围的距离中心线最近的Item
    CGFloat minCenterY = CGFLOAT_MAX;
    CGFloat collectionCenterY = proposedContentOffset.y + self.collectionView.frame.size.height * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.y - collectionCenterY) < ABS(minCenterY)){
            minCenterY = attrs.center.y - collectionCenterY;
        }
    }
    
    //3. 补回ContentOffset，则正好将Item居中显示
    CGFloat proposedY = proposedContentOffset.y + minCenterY;
    // 滑动一屏时的偏移量
    CGFloat mainScreenBounds = self.collectionView.frame.size.height;
    // 正向滑动仅滑动一屏
    if (proposedY - self.lastProposedContentOffset >= mainScreenBounds) {
        proposedY = mainScreenBounds + self.lastProposedContentOffset;
    }
    // 反向滑动仅滑动一屏
    if (proposedY - self.lastProposedContentOffset <= -mainScreenBounds) {
        proposedY = -mainScreenBounds + self.lastProposedContentOffset;
    }
//   // NSLog(@"过滤文字velocity == %f proposedY == %f"),velocity.y,proposedY);
    self.lastProposedContentOffset = proposedY;
    
    CGPoint finialProposedContentOffset = CGPointMake(proposedContentOffset.x, proposedY);
    return finialProposedContentOffset;
}
@end
