//
//  MessageVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryListContainerView.h>
NS_ASSUME_NONNULL_BEGIN

@interface MessageCenterVC : UIViewController<JXCategoryListContentViewDelegate>
- (void)clearConversations;//清空聊天列表
@end

NS_ASSUME_NONNULL_END
