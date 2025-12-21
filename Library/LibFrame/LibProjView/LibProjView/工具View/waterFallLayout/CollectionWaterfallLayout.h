//
//  HomeCollectionWaterfallLayout.h
//  MPVideoLive
//
//  Created by ssssssss on 2020/1/8.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CollectionWaterfallLayout;

@protocol  CollectionWaterfallLayoutDelegate<NSObject>

@required
/**
 * 每个item的高度e
 */
- (CGFloat)waterFallLayout:(CollectionWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(CollectionWaterfallLayout *)waterFallLayout;


@end


@interface CollectionWaterfallLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<CollectionWaterfallLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
