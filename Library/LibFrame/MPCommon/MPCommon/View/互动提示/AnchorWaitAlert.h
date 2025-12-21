//
//  AnchorWaitAlert.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnchorWaitAlert : NSObject


- (instancetype)initWithUserName:(NSString *)uname avatar:(NSString *)avatar content:(NSString *)content timeCount:(int)timeCount;;

/// type : 1 - 同意 2 - 不同意
@property(nonatomic,copy) void(^selectIndexHandle)(NSInteger type);

/// 倒计时时间到，没响应回调
@property(nonatomic,copy) void(^timeIsEndHandle)(void);


- (void)dismiss;


@end

NS_ASSUME_NONNULL_END
