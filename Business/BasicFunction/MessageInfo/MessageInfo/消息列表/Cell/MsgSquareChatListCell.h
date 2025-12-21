//
//  MsgSquareChatListCell.h

//  MessageInfo
//
//  Created by klc_sl on 2021/8/10.
//

#import <UIKit/UIKit.h>
@class AppHomeChatPlazaVOModel;

NS_ASSUME_NONNULL_BEGIN

@interface MsgSquareChatListCell : UITableViewCell

- (void)showSquareInfo:(AppHomeChatPlazaVOModel *)mModel;

@end

NS_ASSUME_NONNULL_END
