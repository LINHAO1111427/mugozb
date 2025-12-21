//
//  CAuthorityTipView.h
//  MineCenter
//
//  Created by ssssssss on 2020/11/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/MyAnchorVOModel.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    AuthorityStatusApply = -1,//未申请
    AuthorityStatusPassed = 0,//已通过
    AuthorityStatusReview    ,//审核中
    AuthorityStatusRejected  ,//被拒绝
    
} AuthorityStatus;
 
@interface CAuthorityTipView : UIView
@property (nonatomic, strong)UIButton *reApplayBtn;//重新提交审核的按钮
@property (nonatomic, strong)MyAnchorVOModel *model;
@property (nonatomic, assign)AuthorityStatus aStatus;//认证状态
@end

NS_ASSUME_NONNULL_END
