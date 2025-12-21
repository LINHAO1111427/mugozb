//
//  MultiGestureCollectionView.m
//  LibProjView
//
//  Created by KLC on 2020/6/19.
//  Copyright © 2020 . All rights reserved.
//

#import "MultiGestureCollectionView.h"

@implementation MultiGestureCollectionView

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
