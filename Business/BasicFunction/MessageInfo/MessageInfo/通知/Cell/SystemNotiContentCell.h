//
//  SystemNotiContentCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AppSystemNoticeUserModel;
@interface SystemNotiContentCell : UITableViewCell
@property(nonatomic,strong)AppSystemNoticeUserModel *model;
+(CGFloat)getSystemNotiContentCellHeight:(AppSystemNoticeUserModel *)model;
@end

NS_ASSUME_NONNULL_END
