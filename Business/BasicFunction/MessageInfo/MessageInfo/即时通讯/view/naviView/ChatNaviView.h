//
//  ChatNaviView.h
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationBaseInfo.h"

NS_ASSUME_NONNULL_BEGIN


@interface ChatNaviView : UIView



- (instancetype)initWithChatType:(ConversationChatForType)chatType;

///用户信息
@property (nonatomic, weak)UILabel *navTitleL;

///返回按钮
@property (nonatomic, weak)UIButton *backBtn;


///家族详情按钮
@property (nonatomic, copy)void(^moreBtnClick)(ConversationChatForType chatType);
///是否为家族的排行榜
@property (nonatomic, copy)void(^rankBtnClick)(BOOL isFamily);

@property (nonatomic, copy)void(^attenBtnClick)(BOOL isAtten);


- (void)reloadSeatUser:(NSString *)userIcon;

- (void)setUserAtten:(BOOL)isAtten;


@end

NS_ASSUME_NONNULL_END
