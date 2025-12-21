//
//  LiveSystemNoticeView.h
//  TCDemo
//
//  Created by CH on 2019/11/21.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiSimpleMsgRoomModel;
@interface LiveSystemNoticeView : UIView

- (void)showSystemNoticeModel:(ApiSimpleMsgRoomModel *)noticeModel;

- (void)playNoticeAndFinishBlock:(void(^)(void))finishBlock;

@end

NS_ASSUME_NONNULL_END
