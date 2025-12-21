//
//  UserInfoBottomFuncView.h
//  UserInfo
//
//  Created by klc_sl on 2021/3/5.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UserInfoHomeVOModel;

@interface UserInfoBottomFuncView : UIView


@property (nonatomic, strong) UserInfoHomeVOModel *homeModel;

@property (nonatomic, copy)void(^attenUserBtnClick)(BOOL isAtten);

@end


NS_ASSUME_NONNULL_END
