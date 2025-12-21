//
//  FansGroupMsgUserListVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FansGroupMsgUserListVC : UIViewController

///粉丝团ID
@property (nonatomic, assign)int64_t groupId;
///团主ID
@property (nonatomic, assign)int64_t anchorId;

@end

NS_ASSUME_NONNULL_END
