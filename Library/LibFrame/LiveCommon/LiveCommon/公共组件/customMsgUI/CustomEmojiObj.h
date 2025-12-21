//
//  CustomEmojiObj.h
//  LiveCommon
//
//  Created by klc_sl on 2020/12/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomEmojiObj : UIView

///获得麦序机的表情包图片
+ (UIImage *)getMicOrderView:(NSString *)numberStr;

///获得老虎机的表情包图片
+ (UIImage *)getSlotMachineView:(NSString *)numberStr;


@end

NS_ASSUME_NONNULL_END
