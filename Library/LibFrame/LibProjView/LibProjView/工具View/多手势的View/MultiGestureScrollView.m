//
//  MultiGestureScrollView.m
//  LibProjView
//
//  Created by klc on 2020/5/26.
//  Copyright © 2020 . All rights reserved.
//

#import "MultiGestureScrollView.h"

@implementation MultiGestureScrollView

/**
 同时识别多个手势

 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
