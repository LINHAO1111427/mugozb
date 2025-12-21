//
//  ImExtraInfo.h
//  IMSocket
//
//  Created by wy on 2021/8/13.
//  Copyright © 2021 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImExtraInfo : NSObject

@property (nonatomic, strong) NSDate* extraInfoUpdateTime;//更新时间
@property (nonatomic, strong) NSDictionary* extraInfo;//信息
@end

NS_ASSUME_NONNULL_END
