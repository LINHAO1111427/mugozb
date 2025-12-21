//
//  PKSelectAlert.h
//  MPVideoLive
//
//  Created by admin on 2019/8/13.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PKSelectAlert : UIView

- (instancetype)initWithAlertTitle:(NSString *)title;

- (void)clickDefaultPk:(void (^)(void))defaultBlock magicPk:(void(^)(void))magicBlock;

- (void)show;

@end

NS_ASSUME_NONNULL_END
