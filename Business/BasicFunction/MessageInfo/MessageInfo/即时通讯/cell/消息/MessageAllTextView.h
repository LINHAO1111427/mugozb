//
//  MessageAllTextView.h
//  Message
//
//  Created by klc_sl on 2021/8/6.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageAllTextView : UIView


@end


///纯文字
@interface MessageTextView : MessageAllTextView
//聊天的内容
@property (nonatomic, weak)UILabel *contentLabel;
///是否置顶的view
@property (nonatomic, weak)UIImageView *topImgV;

- (void)showTopIsOwner:(BOOL)isOwner content:(NSString *)content isTop:(BOOL)isTop;

@end



///一对一通话信息
@interface MessageOtoCallView : MessageAllTextView

//聊天的内容
@property (nonatomic , weak)UILabel *contentLabel;

- (void)showOtoCallStr:(NSString *)callStr isVideo:(BOOL)isVideo isOwner:(BOOL)isOwner;


@end


///语音信息
@interface MessageAudioView : MessageAllTextView
//语音
@property (nonatomic, weak) UIImageView *audioImgView;
//语音时长
@property (nonatomic, weak) UILabel *audioTimeLabel;

- (void)showMsgIsOwner:(BOOL)isOwner time:(NSString *)time;



@end


///求赏
@interface MessageAskGiftView : MessageAllTextView
//礼物图片
@property (nonatomic, weak) UIImageView *giftImgView;
//name
@property (nonatomic, weak) UILabel *showLabel;

- (void)showMsgIsOwner:(BOOL)isOwner giftIcon:(NSString *)icon showStr:(NSString *)showStr;

@end


NS_ASSUME_NONNULL_END
