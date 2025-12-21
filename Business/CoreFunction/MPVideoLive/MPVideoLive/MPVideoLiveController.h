//
//  MPVideoLiveController.h
//  OneVideoLive
//
//  Created by admin on 2020/1/2.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LiveCommon/LiveBaseViewController.h>
#import <LiveCommon/MPLiveInterface.h>

@class Home_getHomeDataList;
@class OpenAuthDataVOModel;

NS_ASSUME_NONNULL_BEGIN

@interface MPVideoLiveController : LiveBaseViewController


- (instancetype)initWithIsAnchor:(BOOL)isAnchor;
 
@property (nonatomic, strong)OpenAuthDataVOModel *openData;


@end

NS_ASSUME_NONNULL_END
