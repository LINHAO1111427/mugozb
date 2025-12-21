//
//  GameResultPrizeItemCell.h
//  klcProject
//
//  Created by klc_sl on 2020/7/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamePrizeRecordModel;

NS_ASSUME_NONNULL_BEGIN

@interface GameResultPrizeItemCell : UITableViewCell

@property (nonatomic, weak)UIImageView *prizeImgV;

@property (nonatomic, weak)UILabel *contentL;

@property (nonatomic, weak)UILabel *prizeCoinL;


@property (nonatomic, strong)GamePrizeRecordModel *model;

@end

NS_ASSUME_NONNULL_END
