//
//  SystemNoticeObj.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/14.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiSimpleMsgRoomModel;
@interface SystemNoticeObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)addMsg:(ApiSimpleMsgRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
