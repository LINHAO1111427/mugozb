//
//  RechangeSuccessNotice.h
//  LiveCommon
//
//  Created by klc_sl on 2020/4/2.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ApiUserInfoModel;

@interface RechangeSuccessNotice : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)playCongratulation:(ApiUserInfoModel *)model coin:(double)coin;

@end

NS_ASSUME_NONNULL_END
