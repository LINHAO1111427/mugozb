//
//  UserInfoListView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
NS_ASSUME_NONNULL_BEGIN

@interface UserInfoListView : UIView

@property (weak, nonatomic) UILabel *numberL;  ///排位

@property (weak, nonatomic) KlcAvatarView *userIcon;  ///用户头像
 
@property (weak, nonatomic) UILabel *titleL;  ///用户名称

@property (weak, nonatomic) SWHTapImageView *sexImgV;  ///用户头像

@property (weak, nonatomic) UIImageView *level2ImgV;  ///用户头像
@property (weak, nonatomic) UIImageView *level1ImgV;  ///用户头像

@property (weak, nonatomic) UILabel *coinL;  ///金币数


- (void)loadUserInfoData;

@end

NS_ASSUME_NONNULL_END
