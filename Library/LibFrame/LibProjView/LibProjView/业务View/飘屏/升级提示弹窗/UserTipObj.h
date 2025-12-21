//
//  UserTipObj.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@class ApiElasticFrameModel;
NS_ASSUME_NONNULL_BEGIN

@interface UserTipObj : NSObject

- (instancetype)initWithSuperView:(UIView *)superView;

- (void)showTipView:(ApiElasticFrameModel *)tipsModel;



@end

NS_ASSUME_NONNULL_END
