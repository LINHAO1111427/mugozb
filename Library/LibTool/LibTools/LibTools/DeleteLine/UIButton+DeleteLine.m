//
//  UIButton+DeleteLine.m
//  MPVideoLive
//
//  Created by klc_sl on 2020/2/21.
//  Copyright © 2020 cat. All rights reserved.
//

#import "UIButton+DeleteLine.h"
#import <objc/runtime.h>

BOOL wel_buttonShapesUnderline(id self, SEL _cmd) {
    return NO;
}



@implementation UIButton (DelectLine)

+ (void)load {

    Method m = class_getInstanceMethod([UILabel class], NSSelectorFromString(@"_shouldShowAccessibilityButtonShapesUnderline"));

    method_setImplementation(m, (IMP)wel_buttonShapesUnderline);

}


@end
