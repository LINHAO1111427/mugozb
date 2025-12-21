//
//  UIView+SafeLayout.h
//  LibTools
//
//  Created by klc on 2020/8/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#define isOS_11(returnOptionA,returnOptionB) \
if (@available(iOS 11.0, *)) { \
    return returnOptionA; \
} else {    \
    return returnOptionB;\
}

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SafeLayout)

-(MASViewAttribute*)zh_safe_top;

-(MASViewAttribute*)zh_safe_bottom;

-(id)zh_safe_edges;

@end

NS_ASSUME_NONNULL_END
