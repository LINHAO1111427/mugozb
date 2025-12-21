//
//  PresenterSeatView.h
//  OTMLive
//
//  Created by klc_sl on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjView/KlcAvatarView.h>


NS_ASSUME_NONNULL_BEGIN

@class AppStrickerVOModel;
@class ApiUsersVoiceAssistanModel;

@interface PresenterSeatView : UIView

@property (nonatomic, strong)ApiUsersVoiceAssistanModel *seatModel;

@property (nonatomic, copy)void(^userIconClick)(void);


- (void)reloadShowInfo;
- (void)playEmoj;
@end

NS_ASSUME_NONNULL_END
