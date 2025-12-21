//
//  GameNormalBoxView.h
//  LiveCommon
//
//  Created by klc_sl on 2021/5/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameNormalBoxView : UIView

@property (nonatomic, copy)NSString *LuckyStartTime;

@property (nonatomic, copy)NSString *luckyEndTime;

@property (nonatomic, copy)void(^reloadPrizeList)(void);



- (instancetype)initWithFrame:(CGRect)frame isLuckyBox:(BOOL)luckyBox;

- (void)resetData;


@end

NS_ASSUME_NONNULL_END
