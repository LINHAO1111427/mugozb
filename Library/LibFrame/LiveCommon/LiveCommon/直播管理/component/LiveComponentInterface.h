//
//  LiveComponentInterface.h
//  LiveCommon
//
//  Created by shirley on 2019/9/27.
//  Copyright © 2020 . All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol LiveComponentInterface <NSObject>


@required


- (void)parInitViewController:(UIViewController *)superVC views:(NSArray <UIView *>*)views;


@end

NS_ASSUME_NONNULL_END
