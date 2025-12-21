//
//  ChatAudioView.h
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChatAudioViewDelegate <NSObject>
@optional
- (void)sendMessageRecordUrlToOther:(NSString *)recordUrl andTimeStr:(NSString *)timeStr;
@end
@interface ChatAudioView : UIView

@property(nonatomic,weak)id<ChatAudioViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
