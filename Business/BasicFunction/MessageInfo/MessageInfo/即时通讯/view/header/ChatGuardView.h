//
//  ChatGuardView.h
//  Message
//
//  Created by klc_tqd on 2020/5/19.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatGuardView : UIView

@property(nonatomic,copy)void(^clickChatGuardViewBlock)(void);
@end

NS_ASSUME_NONNULL_END
