//
//  PresentedGoodNumber.h
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PresentedGoodNumber : UIView


+ (void)presentNumber:(int64_t)uid userName:(NSString *)name userIcon:(NSString *)icon;


@end

NS_ASSUME_NONNULL_END
