//
//  GamePrizeListView.h
//  klcProject
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GameAwardsVOModel;

@interface GamePrizeListView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)UICollectionView *collV;

@property (nonatomic, copy)NSArray<GameAwardsVOModel *> *items;

@end

NS_ASSUME_NONNULL_END
