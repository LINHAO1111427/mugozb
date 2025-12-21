//
//  AVHttpSessionObj.h
//  XTMedisKit
//
//  Created by shirley on 2019/9/9.
//  Copyright © 2019 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVHttpSessionObj : NSObject


+ (void)uploadInfoWithScene:(int)scene successBlock:(void(^)(BOOL success, NSString *token, NSDictionary *dic))block;


@end

NS_ASSUME_NONNULL_END
