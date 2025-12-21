//
//  PkProgressView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/17.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PkProgressView : UIView

/// pk开始数据
@property(nonatomic,strong) NSDictionary *pkData;

- (void)updateMyTotal:(NSInteger )myTotal enemyTotal:(NSInteger )enemyTotal;

@end

NS_ASSUME_NONNULL_END
