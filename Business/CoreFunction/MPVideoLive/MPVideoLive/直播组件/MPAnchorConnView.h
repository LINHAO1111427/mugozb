//
//  MPAnchorConnView.h
//  MPVideoLive
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPAnchorConnView : UIView

- (instancetype)initWithFrame:(CGRect)frame btnSuperView:(UIView *)superView;

@property (nonatomic, weak)UIImageView *userCoverImgV;

@property (nonatomic, weak)UIImageView *userImageV;

@property (nonatomic, copy)void (^closeLinkMic) (void);

@property (nonatomic, weak)UIButton *closeBtn;

@property (nonatomic, assign)int64_t userId;

@property (nonatomic, assign)int64_t roomId;

@end

NS_ASSUME_NONNULL_END
