//
//  MinePrizeGroupCell.h
//  LibProjView
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GamePrizeRecordModel;
@interface MinePrizeGroupCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, weak)UICollectionView *collV;


@property (nonatomic, copy)NSArray<GamePrizeRecordModel *> *items;


@end

NS_ASSUME_NONNULL_END
