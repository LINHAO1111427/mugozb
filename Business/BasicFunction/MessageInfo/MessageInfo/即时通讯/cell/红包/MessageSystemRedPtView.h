//
//  MessageSystemRedPtView.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/11.
//

#import <UIKit/UIKit.h>
///显示XXX收到了红包
@class GroupOpenRedPacketMsgObj;

NS_ASSUME_NONNULL_BEGIN

@interface MessageSystemRedPtView : UIView

@property (nonatomic, weak)UILabel *titleL;

@property (nonatomic, weak)UIButton *nameBtn;

@property (nonatomic, assign)int64_t sendUserId;

///点击某一个人的ID
@property (nonatomic, copy)void(^clickUserInfo)(int64_t userId);


- (void)showSystemRedPt:(GroupOpenRedPacketMsgObj *)redInfo;


@end

NS_ASSUME_NONNULL_END
