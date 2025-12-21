//
//  MessageShowRedPackView.h
//  Message
//
//  Created by klc_sl on 2021/6/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageRedPacketModel;

NS_ASSUME_NONNULL_BEGIN

@interface MessageShowRedPackView : UIView

@property (nonatomic, weak)UIImageView *imgV;
///标题
@property (nonatomic, weak)UILabel *titleL;
///是否打开
@property (nonatomic, weak)UILabel *openStatusL;

@property (nonatomic, weak)UILabel *coinL;
///白色遮盖
@property (nonatomic, weak)UIVisualEffectView *visualView;


@property (nonatomic, copy)void(^clickRedPt)(void);


- (void)showRedPtInfo:(MessageRedPacketModel *)redPtInfo isOwn:(BOOL)isOwn;

@end

NS_ASSUME_NONNULL_END
