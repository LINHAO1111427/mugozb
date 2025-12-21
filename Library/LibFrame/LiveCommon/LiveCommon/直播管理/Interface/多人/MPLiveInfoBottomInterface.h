//
//  MPLiveInfoBottomInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MPLiveInfoBottomInterface <NSObject>


+ (instancetype)register;

- (void)reloadFunctionBtn;

@optional
///多人语音用到了
- (void)reloadUserLinkNumber:(int)linkNum;

@end

NS_ASSUME_NONNULL_END
