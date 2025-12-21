//
//  CloudConfig.h
//  youMengLive
//
//  Created by klc_sl on 2020/7/22.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XTMediaKit/XTMediaConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloudConfig : NSObject <XTMediaConfig>

///配置
+ (void)mediaConfig;

@end

NS_ASSUME_NONNULL_END
