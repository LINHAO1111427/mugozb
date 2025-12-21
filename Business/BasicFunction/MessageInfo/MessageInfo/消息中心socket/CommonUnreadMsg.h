//
//  CommonUnreadMsg.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <LibProjModel/IMRcvCommonMsgSend.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonUnreadMsg : IMRcvCommonMsgSend

@property (nonatomic,copy)void(^noReadBlock)(int64_t noReadNum);

@end

NS_ASSUME_NONNULL_END
