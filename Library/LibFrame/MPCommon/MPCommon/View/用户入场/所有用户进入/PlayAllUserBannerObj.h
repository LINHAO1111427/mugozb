//
//  PlayAllUserBannerObj.h
//  LiveCommon
//
//  Created by kalacheng on 2020/9/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiSimpleMsgRoomModel;

@interface PlayAllUserBannerObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)playAllUserView:(ApiSimpleMsgRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
