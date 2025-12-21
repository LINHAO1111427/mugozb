//
//  AnchorAudioLinkManagerView.h
//  MPAudioLive
//
//  Created by klc_sl on 2021/8/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnchorAudioLinkManagerView : UIView


+ (AnchorAudioLinkManagerView *)showMangerView;


- (void)reloadLinkUser;

@end

NS_ASSUME_NONNULL_END
