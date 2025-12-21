//
//  PLayMountsAnimationObj.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AppJoinRoomVOModel;
NS_ASSUME_NONNULL_BEGIN

@interface PLayMountsAnimationObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView bannerSuperView:(UIView *)bannerSuperV;

- (void)playUserJoinAnimation:(AppJoinRoomVOModel *)userModel;


@end

NS_ASSUME_NONNULL_END
