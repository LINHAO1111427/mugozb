//
//  GameLuckUserListView.h
//  LiveCommon
//
//  Created by admin on 2020/1/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///幸运用户的最新十条中奖信息
@interface GameLuckUserListView : UIView


- (void)loadData;

- (void)timeStop;


@end

NS_ASSUME_NONNULL_END
