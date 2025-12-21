//
//  MsgSendStatusView.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/24.
//

#import <UIKit/UIKit.h>
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MsgSendStatusView : UIView

@property (nonatomic, weak) UIImageView *sendFailView;
@property (nonatomic, weak) UIActivityIndicatorView *circleView;
@property (nonatomic, assign) int msgCode;
@property (nonatomic, assign) ConversationChatForType chatType;
@property (nonatomic, copy) NSDictionary *extraInfo;

@property (nonatomic, copy)void(^reSendBtnClick)(void);

- (void)showMsgStatus:(int)code extra:(NSDictionary *)extra;

@end

NS_ASSUME_NONNULL_END
