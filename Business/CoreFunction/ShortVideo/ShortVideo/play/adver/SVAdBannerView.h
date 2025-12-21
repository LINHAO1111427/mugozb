//
//  SVAdBannerView.h
//  ShortVideo
//
//  Created by klc_sl on 2021/5/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShortVideoAdsVOModel;

NS_ASSUME_NONNULL_BEGIN

@interface SVAdBannerView : UIView

@property (nonatomic, copy)NSArray<ShortVideoAdsVOModel *> *adList;


@property (nonatomic, copy)void(^adItemClick)(NSString *url);

///停止广告滑动
- (void)stopScroll;

@end

NS_ASSUME_NONNULL_END
