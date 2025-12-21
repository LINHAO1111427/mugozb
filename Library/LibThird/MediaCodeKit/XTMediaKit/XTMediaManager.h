//
//  XTMediaManager.h
//  XTMediaKit
//
//  Created by shirley on 2019/7/27.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTMediaConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTMediaManager : NSObject


+ (void)setConfig:(Class<XTMediaConfig>)config;


+ (instancetype)share;


@property (nonatomic, copy, readonly)Class<XTMediaConfig> config;


@end

NS_ASSUME_NONNULL_END
