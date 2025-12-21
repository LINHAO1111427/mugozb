//
//  MessageChatLisCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TXImKit/TXImKit.h>

@class MessageChatModel;

NS_ASSUME_NONNULL_BEGIN


@interface MessageChatLisCell : UITableViewCell

@property (nonatomic,copy)void(^cellLongTapBlock)(void);

- (void)showUserInfo:(MessageChatModel *)mModel;


@end

NS_ASSUME_NONNULL_END
