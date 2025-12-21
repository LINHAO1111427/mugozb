//
//  VideoConversionCoding.h
//  TCDemo
//
//  Created by admin on 2019/11/5.
//  Copyright © 2019 CH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoConversionCoding : UIView

+ (void)conversion:(NSURL *)movUrl savaPath:(NSURL *)savePath finishBlock:(void (^)(BOOL isSuccess, int errorCode))block;

@end

NS_ASSUME_NONNULL_END
