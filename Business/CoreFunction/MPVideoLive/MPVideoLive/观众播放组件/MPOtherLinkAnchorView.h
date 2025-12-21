//
//  MPOtherLinkAnchorView.h
//  MPVideoLive
//
//  Created by klc_sl on 2021/8/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/PlayVideoView.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPOtherLinkAnchorView : UIView

- (instancetype)initWithFrame:(CGRect)frame interactionBgView:(UIView *)handleView;

@property (nonatomic, assign) int64_t otherRoomId;

@property (nonatomic, weak) PlayVideoView *playImgV;

@property (nonatomic, weak) UIButton *moreBtn;



@end


NS_ASSUME_NONNULL_END
