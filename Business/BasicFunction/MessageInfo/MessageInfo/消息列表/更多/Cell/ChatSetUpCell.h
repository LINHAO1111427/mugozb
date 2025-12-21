//
//  ChatSetUpCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatSetInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChatSetUpCellDelegate <NSObject>

@optional

- (void)clickPullBlack:(BOOL )isOn andType:(int)type;

@end

@interface ChatSetUpCell : UITableViewCell

@property(nonatomic,strong)ChatSetInfoModel *infoModel;

@property(nonatomic,weak)id<ChatSetUpCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
