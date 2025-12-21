//
//  MessageDyListCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApiCommentsMsgModel;

NS_ASSUME_NONNULL_BEGIN

@protocol DynamicMsgCommentRespondDelegate <NSObject>

@required
-(void)respondUserComment:(ApiCommentsMsgModel *)model;

-(void)deleteUserComment:(ApiCommentsMsgModel *)model;

@end





@interface MessageDyListCell : UITableViewCell

@property(nonatomic,strong)ApiCommentsMsgModel *model;

@property(nonatomic,weak)id <DynamicMsgCommentRespondDelegate>delegate ;

@end

NS_ASSUME_NONNULL_END
