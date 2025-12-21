//
//  SelectLiveChannel.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppLiveChannelModel;
@interface SelectLiveChannel : UIView

+ (void)showType:(int)type selectId:(int64_t)selectId selectBlock:(void(^)(AppLiveChannelModel *channelModel))block;


@end

NS_ASSUME_NONNULL_END
