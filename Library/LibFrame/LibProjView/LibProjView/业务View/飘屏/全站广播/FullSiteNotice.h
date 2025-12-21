//
//  RechangeSuccessNotice.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiSimpleMsgRoomModel;

@interface FullSiteNotice : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)fullStationCongratulation:(ApiSimpleMsgRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
