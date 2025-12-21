//
//  KlcAvatarView.h
//  LibProjView
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KlcAvatarView : UIControl

@property (nonatomic, weak, readonly)UIImageView *userIcon;

@property (nonatomic, weak, readonly)UIImageView *vipBorder;


- (void)showUserIconUrl:(NSString *_Nullable)url vipBorderUrl:(NSString *_Nullable)vipBorderUrl;


@end

NS_ASSUME_NONNULL_END
