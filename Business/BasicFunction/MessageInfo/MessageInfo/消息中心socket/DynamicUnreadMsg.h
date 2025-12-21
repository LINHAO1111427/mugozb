//
//  DynamicUnreadMsg.h
//  LibProjView
//
//  Created by ssssssss on 2020/10/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <LibProjModel/IMRcvDynamiccircleSend.h>

NS_ASSUME_NONNULL_BEGIN

@interface DynamicUnreadMsg : IMRcvDynamiccircleSend
 
@property (nonatomic,copy)void(^noReadBlock)(int noReadNum);

@end

NS_ASSUME_NONNULL_END
