//
//  MessageTool.h
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import <Foundation/Foundation.h>
#import <MessageInfo/ConversationBaseInfo.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectPhotoBlock)(NSString *picUrl, BOOL isOnce);

@interface MessageTool : NSObject

- (instancetype)initWithChatType:(ConversationChatForType)chatType;

- (void)selectPhoto:(SelectPhotoBlock)selectBlock;


@end

NS_ASSUME_NONNULL_END
