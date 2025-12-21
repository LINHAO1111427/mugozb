//
//  MessageChatFuncCell.h
//  Message
//
//  Created by klc_sl on 2021/8/7.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageChatFuncCell : UITableViewCell

@property (nonatomic, weak)UIImageView *headImgView;
@property (nonatomic, weak)UILabel *titleLabel;
@property (nonatomic, weak)UILabel *contentLabel;


/// 显示内容
/// @param funcType ///1家族 2广场 //其他不操作
/// @param userNumber 人数
- (void)showFuncType:(int)funcType userNumber:(int)userNumber;

@end

NS_ASSUME_NONNULL_END
