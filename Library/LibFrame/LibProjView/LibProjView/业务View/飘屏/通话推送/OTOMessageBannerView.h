//
//  OTOMessageBannerView.h
//  LibProjView
//
//  Created by klc_sl on 2020/7/17.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiPushChatModel;

@interface OTOMessageBannerView : UIView


+ (void)showInView:(UIView *)superView userInfo:(ApiPushChatModel *)model;


@end

NS_ASSUME_NONNULL_END
