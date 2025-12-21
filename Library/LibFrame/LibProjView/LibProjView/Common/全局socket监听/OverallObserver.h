//
//  OverallObserver.h
//  LibProjView
//
//  Created by klc on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LibProjModel/IMRcvAnchorMsgSender.h>
#import <LibProjModel/IMRcvLiveMoneyMsgAllSend.h>
#import <LibProjModel/IMRcvPublicLiveSend.h>
#import <LibProjModel/IMRcvGradeRightMsgSender.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverallObserver : NSObject

+ (void)addAllBanner;

@end

@interface AnchorMsgObserver : IMRcvAnchorMsgSender

@end

@interface MoneyMsgAllObserver : IMRcvLiveMoneyMsgAllSend

@end

@interface PublicMsgAllObserver : IMRcvPublicLiveSend

@end

@interface GradeRightMsgObserver : IMRcvGradeRightMsgSender

@end

NS_ASSUME_NONNULL_END
