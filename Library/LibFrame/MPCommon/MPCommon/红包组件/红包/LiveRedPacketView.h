//
//  LiveRedPacketView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveRedPacketView : UIControl
 
@property (nonatomic, weak)UIImageView *redPacket;  ///红包图片

@property (nonatomic, weak)UIButton *packetNumBtn;  //红包数量


- (void)showPacketInfo:(int)packetNum;


@end

NS_ASSUME_NONNULL_END
