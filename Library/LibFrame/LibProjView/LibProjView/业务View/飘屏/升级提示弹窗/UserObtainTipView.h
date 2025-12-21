//
//  UserObtainTipView.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiElasticFrameModel;
@interface UserObtainTipView : UIView

- (instancetype)initContentInfo:(ApiElasticFrameModel *)tipsModel;

@end

NS_ASSUME_NONNULL_END
