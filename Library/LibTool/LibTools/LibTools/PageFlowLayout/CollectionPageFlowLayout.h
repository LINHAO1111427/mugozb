//
//  CollectionPageFlowLayout.h
//  MPVideoLive
//
//  Created by admin on 2019/8/8.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionPageFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;


@property (strong, nonatomic) NSMutableArray *allAttributes;

@end

NS_ASSUME_NONNULL_END
