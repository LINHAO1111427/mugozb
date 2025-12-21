//
//  UserInfoVoicePlayView.h
//  UserInfo
//
//  Created by shirley on 2021/12/22.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoVoicePlayView : UIView


@property (nonatomic, weak)UIImageView *voiceImg;
@property (nonatomic, weak)UILabel *secondL;

- (void)stopPlay;

- (void)playUrl:(NSString *)playUrl time:(int64_t)time;


@end

NS_ASSUME_NONNULL_END
