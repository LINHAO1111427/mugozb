//
//  LiveInfoMsgList.h
//  TCDemo
//
//  Created by admin on 2019/10/12.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LiveInfoMsgList : UIView

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)addMsg:(MessageModel *)model;

/// 滚动到最后一行
- (void)scrollLastLine;

@end

NS_ASSUME_NONNULL_END
