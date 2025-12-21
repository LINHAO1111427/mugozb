//
//  SVCoverView.h
//  ShortVideo
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVCoverView : UIView
 

@property (nonatomic, weak) UIVisualEffectView *marskBlur;   ///檬层
@property (nonatomic, weak) UIButton *lockBtn;   ///锁

///点击锁的回调
@property (nonatomic, copy)void(^lockBtnClick)(void);


@end

NS_ASSUME_NONNULL_END
