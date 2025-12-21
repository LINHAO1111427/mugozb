//
//  UIView+AdjustFrame.h
//
//
//  Created by apple on 14-12-7.
//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AdjustFrame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat maxX;
@property (assign, nonatomic) CGFloat maxY;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
-(void)removeAllSubViews;
@end
