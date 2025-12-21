//
//  userTaskRewardToastView.h
//  MineCenter
//
//  Created by ssssssss on 2020/12/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiGradeReWarReModel;
typedef void (^taskRewardDissmissBlock)(BOOL isClose);
@interface userTaskRewardToastView : UIView
+ (void)showTaskRewardToastOn:(UIView *)superView isAnchor:(BOOL)isAnchor  withReward:(ApiGradeReWarReModel*)reward callBack:(taskRewardDissmissBlock)callBack;
@end

NS_ASSUME_NONNULL_END
