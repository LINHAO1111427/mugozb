//
//  RoomPkSelectView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/18.
//  Copyright © 2019 Orely. All rights reserved.
//
// 语音房间内部pk选择

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoomPkSelectView : UIView


- (void)roomPKSelect:(void(^)(BOOL startPk))selectBlock;


@end

NS_ASSUME_NONNULL_END
