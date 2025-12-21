//
//  MPUserOwnView.h
//  MPVideoLive
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPUserOwnView : UIView


@property (nonatomic, weak)UIImageView *userImage;

@property (nonatomic, copy)void (^closeLinkMic) (void);

@property (nonatomic, copy)void (^rotateCamera) (void);

@property (nonatomic, weak)UIButton *closeBtn;
@property (nonatomic, weak)UIButton *cameraBtn;


@end

NS_ASSUME_NONNULL_END
