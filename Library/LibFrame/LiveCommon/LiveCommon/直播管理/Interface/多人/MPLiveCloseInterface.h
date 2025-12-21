//
//  MPLiveCloseInterface.h
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApiCloseLiveModel;

NS_ASSUME_NONNULL_BEGIN

@protocol MPLiveCloseInterface <NSObject>


+ (void)showInView:(UIView *)superV isAnchor:(BOOL)isAnchor closeInfo:(ApiCloseLiveModel *)closeModel;


@end

NS_ASSUME_NONNULL_END
