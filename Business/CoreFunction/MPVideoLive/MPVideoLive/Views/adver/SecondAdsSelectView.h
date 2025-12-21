//
//  SecondAdsSelectView.h
//  MPVideoLive
//
//  Created by klc_sl on 2021/6/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondAdsSelectView : UIView

@property (nonatomic, copy)NSArray *adList;

+ (void)showSecondLevelAdver:(NSArray<LiveRoomAdsModel *> *)adlist;


@end

NS_ASSUME_NONNULL_END
