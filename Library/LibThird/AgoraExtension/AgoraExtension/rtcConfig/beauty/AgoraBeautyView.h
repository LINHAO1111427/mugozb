//
//  AgoraBeautyView.h
//  AgoraExtension
//
//  Created by kalacheng on 2020/6/13.
//  Copyright © 2020 kalacheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgoraBeautyView : UIView

- (void)showWithSelectHandle:(void(^)(CGFloat redness,CGFloat smoothness,CGFloat bright))handle complete:(void (^)(void))complete;

@end

NS_ASSUME_NONNULL_END
