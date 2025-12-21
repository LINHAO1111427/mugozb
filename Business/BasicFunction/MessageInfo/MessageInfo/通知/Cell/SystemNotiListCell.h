//
//  SystemNotiListCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppHomeSystemNoticeVOModel;
@interface SystemNotiListCell : UITableViewCell
@property (nonatomic,strong)AppHomeSystemNoticeVOModel *model;
@property(nonatomic,copy)void(^cellLongTapBlock)(int64_t noticeId);
@end

NS_ASSUME_NONNULL_END
