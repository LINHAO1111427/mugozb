//
//  AudioPkWinView.h
//  MPVoiceLive
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPkWinView : UIView


+ (void)showWinData:(NSString *)userIcon username:(NSString *)name;


+ (void)showRoomResult:(BOOL)blueWin;


@end

NS_ASSUME_NONNULL_END
