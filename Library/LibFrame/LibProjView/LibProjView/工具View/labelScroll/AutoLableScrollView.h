//
//  AutoLableScrollView.h
//  LibProjView
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoLableScrollView : UIView

///值越大速度越快
@property (nonatomic, assign)float scrollSpeed;

@property(nonatomic, copy) UIColor *textColor;

@property(nonatomic, copy) UIFont *font;

- (void)startScroll:(NSString *)text;

- (void)pauseScroll;

- (void)resumeScroll;

- (void)stopScroll;

@end

NS_ASSUME_NONNULL_END
