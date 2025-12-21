//
//  FamilyRecommendView.h
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FamilyRecommendView : UIView

@property (nonatomic, copy)void(^selectSessionBlock)(int64_t sessionId);

- (instancetype)initShowInView:(UIView *)superV;


@end

NS_ASSUME_NONNULL_END
