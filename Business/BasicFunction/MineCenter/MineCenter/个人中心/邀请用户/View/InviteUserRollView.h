//
//  InviteUserRollView.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteUserRollView : UIView

@property (nonatomic, strong)NSArray *inviteArray;
- (void)startRoll;
- (void)stoptRoll;

@end

NS_ASSUME_NONNULL_END
