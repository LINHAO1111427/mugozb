//
//  UIView+Blocks.m
//  TCDemo
//
//  Created by admin on 2019/11/28.
//  Copyright © 2019 CH. All rights reserved.
//

#import "UIView+Blocks.h"
#import <objc/runtime.h>

@implementation UIView (Blocks)

- (void)klc_whenTapped:(void (^)(void))tap{
    __weak typeof(UIView *) weakSelf = self;
    int isTap = ([self isKindOfClass:[UIControl class]]?1:0);
    objc_setAssociatedObject(weakSelf, @"controlViewWhenTapKey", tap, OBJC_ASSOCIATION_COPY_NONATOMIC);
    switch (isTap) {
        case 1:
        {
            UIControl *control = (UIControl *)self;
            [control addTarget:weakSelf action:@selector(viewWhenTapBlock) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
        {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(viewWhenTapBlock)];
            tap.numberOfTapsRequired = 1;
            [self addGestureRecognizer:tap];
        }
            break;
    }
}

- (void)viewWhenTapBlock{
    __weak typeof(UIView *) weakSelf = self;
    void (^controlClick)(void) = objc_getAssociatedObject(weakSelf, @"controlViewWhenTapKey");
    if (controlClick) {
        controlClick();
    }
}

@end
