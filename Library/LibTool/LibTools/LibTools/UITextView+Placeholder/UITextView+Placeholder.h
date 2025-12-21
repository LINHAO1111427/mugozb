//
//  UITextView+Placeholder.h
//  Pods
//
//  Created by shaolei on 17/4/6.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)
    
@property (nonatomic, copy, nullable) NSString *placeholder;  //   in set placeholder at before set font and frame

@property (nonatomic, strong, nullable) UIColor *placeholderColor;    //default light gray

@end
