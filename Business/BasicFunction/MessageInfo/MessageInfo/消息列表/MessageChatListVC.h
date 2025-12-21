//
//  MessageChatListVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageChatListVC : UIViewController<JXCategoryListContentViewDelegate>

///是否为全屏（处理mjrefresj） 传
@property (nonatomic, assign)BOOL isFullScreen;


- (UIView *)listView;

- (void)updateChatMsg;

- (void)deleteAllConversations;//移除所有会话列表
@end

NS_ASSUME_NONNULL_END
