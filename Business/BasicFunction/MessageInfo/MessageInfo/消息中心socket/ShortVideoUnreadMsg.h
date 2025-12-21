//
//  ShortVideoUnreadMsg.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <LibProjModel/IMRcvShortVideoSend.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShortVideoUnreadMsg : IMRcvShortVideoSend
 
@property (nonatomic,copy)void(^noReadBlock)(int noReadNum);

@end

NS_ASSUME_NONNULL_END
