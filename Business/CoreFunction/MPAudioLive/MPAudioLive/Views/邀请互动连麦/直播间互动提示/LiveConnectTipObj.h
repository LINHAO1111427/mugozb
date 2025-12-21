//
//  LiveConnectTipObj.h
//  LiveCommon
//
//  Created by yww on 2020/9/1.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveConnectTipObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)updatePointRightSpace:(CGFloat)rightSpace;

- (void)updateLiveConnectNumber:(int)number;///申请连麦人数更新


@end

NS_ASSUME_NONNULL_END
