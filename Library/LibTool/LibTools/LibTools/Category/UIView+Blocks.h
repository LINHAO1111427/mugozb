//
//  UIView+Blocks.h
//  TCDemo
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Blocks)

- (void)klc_whenTapped:(void(^ __nullable)(void))tap;

@end

NS_ASSUME_NONNULL_END
