//
//  PrivilegeGiftShowObj.h
//  LiveCommon
//
//  Created by ssssssss on 2020/8/29.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiGiftSenderModel;
@interface PrivilegeGiftShowObj : NSObject
- (instancetype)initWithSuperView:(UIView *)superView;
- (void)ShowPrivilegeGiftAnimation:(ApiGiftSenderModel *)userModel;
@end

NS_ASSUME_NONNULL_END
