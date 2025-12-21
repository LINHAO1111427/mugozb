//
//  UserInfoHeaderView.h
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyInfoAtUserDetailView.h"


NS_ASSUME_NONNULL_BEGIN

@class  UserInfoHomeVOModel;

@interface UserInfoHeaderView : UIView

@property (nonatomic, weak)UIViewController *superVc;

@property(nonatomic,strong)UserInfoHomeVOModel *homeModel;

@property (nonatomic, copy)void(^attenUserBtnClick)(BOOL isAtten);

@property (nonatomic, copy)void(^reloadHeightBlock)(void);

@property (nonatomic, assign)CGFloat headerInfoPointY;

@property (nonatomic, weak)FamilyInfoAtUserDetailView *familyInfoV; ///家族信息

- (void)stopScroll;


@end

NS_ASSUME_NONNULL_END
