//
//  UIScrollView+Preload.m
//  TCDemo
//
//  Created by admin on 2019/9/20.
//  Copyright © 2019 CH. All rights reserved.
//

#import "UIScrollView+Preload.h"
#import <objc/runtime.h>

@implementation UIScrollView (Preload)

- (void)dealloc
{
    [self removeObservers];
}

- (void)preloadHandle:(void (^)(void))handle{
    [self removeObservers];
    objc_setAssociatedObject(self, @"preloadHandleKey", handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addObservers];
}


#pragma mark - KVO监听
- (void)addObservers
{
    if (![self isKindOfClass:[UIScrollView class]]) {
        return;
    }
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew;
    [self.panGestureRecognizer addObserver:self forKeyPath:@"state" options:options context:nil];
}

- (void)removeObservers
{
    void (^preload)(void) = objc_getAssociatedObject(self, @"preloadHandleKey");
    if (preload && (self.panGestureRecognizer.observationInfo)) {
        [self.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([change[@"new"] intValue] != UIGestureRecognizerStateBegan) {
        return;
    }
    
    //1. 先判断横向还是竖向
    int vertical = (self.contentSize.height>=self.contentSize.width)?0:1;   //是否竖向滑动 0:竖向 1:横向
    switch (vertical) {
        case 1:  //横向
        {
            if (self.contentSize.width > 2*self.frame.size.width) {
                if (((self.contentSize.width - self.contentOffset.x ) < 2*self.frame.size.width) && (self.contentSize.width - self.contentOffset.x ) >self.frame.size.width) {
                    [self notifyPreLoad];
                }
            }else if (self.contentSize.width > self.frame.size.width){
                if (((self.contentSize.width - self.contentOffset.x) < self.frame.size.width) && ((self.contentSize.width - self.contentOffset.x) > 0)) {
                    [self notifyPreLoad];
                }
            }else{
                
            }
        }
            break;
        default: //竖向
        {
            if (self.contentSize.height > 2*self.frame.size.height) {
                if (((self.contentSize.height - self.contentOffset.y ) < 2*self.frame.size.height) && ((self.contentSize.height - self.contentOffset.y ) > self.frame.size.height)) {
                    [self notifyPreLoad];
                }
            }else if (self.contentSize.height > self.frame.size.height){
                if (((self.contentSize.height - self.contentOffset.y) < self.frame.size.height) && ((self.contentSize.height - self.contentOffset.y) > 0)) {
                    [self notifyPreLoad];
                }
            }else{
                
            }
        }
            break;
    }
    
}

- (void)notifyPreLoad{
    void (^preload)(void) = objc_getAssociatedObject(self, @"preloadHandleKey");
    if (preload) {
        preload();
    }
}


@end
