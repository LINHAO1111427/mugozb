//
//  UIScrollView+Preload.h
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Preload)

- (void)preloadHandle:(void (^)(void))handle;

@end

NS_ASSUME_NONNULL_END
