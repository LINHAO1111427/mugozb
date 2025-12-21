//
//  MessageTableViewCell.h
//  TCDemo
//
//  Created by CH on 2019/11/14.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel,MessageTableViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol MessageTableViewCellDelegate <NSObject>
///点击用户头像
- (void)userAvaterClickAtMessageTableViewCell:(MessageTableViewCell *)cell;
///点击消息内容
- (void)messageInfoClickAtMessageTableViewCell:(MessageTableViewCell *)cell;

@end

@interface MessageTableViewCell : UITableViewCell


@property(nonatomic, copy) NSIndexPath *indexPath;

@property(nonatomic, strong) MessageModel *model;

@property (nonatomic, weak)id<MessageTableViewCellDelegate> delegate;


//+ (CGFloat)viewHeight:(MessageModel *)model;

@end

NS_ASSUME_NONNULL_END
