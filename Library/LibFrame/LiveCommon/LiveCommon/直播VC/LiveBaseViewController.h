//
//  LiveBaseViewController.h
//  LiveCommon
//
//  Created by CH on 2019/12/16.
//  Copyright © 2019 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import "LiveComponentProtocol.h"
#import <LibProjView/LiveRoomListReqParam.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBaseViewController : UIViewController


@property (nonatomic, strong)Class<LiveComponentProtocol> compClass;
@property (nonatomic, strong)LiveRoomListReqParam *mpliveReqParam;


///离开房间
- (void)leaveRoom:(BOOL)animated;


@property (nonatomic, strong) AppJoinRoomVOModel *roomModel;


@end

NS_ASSUME_NONNULL_END
