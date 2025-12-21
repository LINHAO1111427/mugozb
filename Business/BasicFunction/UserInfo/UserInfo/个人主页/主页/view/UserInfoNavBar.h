//
//  UserInfoNavBar.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInfoHomeVOModel;
@interface UserInfoNavBar : UIView

@property(nonatomic,strong)UserInfoHomeVOModel *homeModel;

@property (nonatomic, assign)BOOL isScrollOut;

@property (nonatomic, copy)void(^navAttenUserBtnClick)(BOOL isAtten);
@property (nonatomic, copy)void(^navUserAvaterBtnClick)(void);

- (instancetype)initWithFrame:(CGRect)frame superVc:(UIViewController *)superVc;

@end

NS_ASSUME_NONNULL_END
