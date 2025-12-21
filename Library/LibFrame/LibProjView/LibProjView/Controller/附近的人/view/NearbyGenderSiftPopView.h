//
//  NearbyenderSelectedPopView.h
//  LibProjView
//
//  Created by ssssssss on 2020/9/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NearbyGenderSiftPopView;
typedef    void(^GenderSiftCallBack)(BOOL selected ,BOOL isInit,int gender,NearbyGenderSiftPopView *showView);
@interface NearbyGenderSiftPopView : UIView
+ (void)showView:(UIView *)superView pointY:(CGFloat)pointY gender:(int)gender callBack:(GenderSiftCallBack)callBack;
- (void)dismiss:(BOOL)selected gender:(int)gender;
@end

NS_ASSUME_NONNULL_END
