//
//  SquareGroupMsgMemberVC.h
//  Message
//
//  Created by klc_tqd on 2020/5/14.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SquareGroupMsgMemberVC : UIViewController

///群Id
@property (nonatomic, assign)int64_t groupId;
///是否有广场禁言特权
@property (nonatomic, assign)BOOL isSquareMute;


@end

NS_ASSUME_NONNULL_END
