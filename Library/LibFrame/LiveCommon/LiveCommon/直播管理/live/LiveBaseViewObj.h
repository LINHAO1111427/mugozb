//
//  LiveBaseViewObj.h
//  LiveCommon
//
//  Created by shirley on 2019/7/25.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LiveBaseViewController.h"
#import "LiveLevelView.h"
#import <LibProjView/LiveRoomListReqParam.h>

@class LiveBaseViewObj,LiveLevelView;

NS_ASSUME_NONNULL_BEGIN



@protocol LiveBaseViewObjDelegate  <NSObject>


///已经完整显示当前页面
- (void)LiveBaseView:(LiveBaseViewObj *)baseViewObj liveInfoAtCurrentView:(LiveLevelView *)liveView;



@end


@interface LiveBaseViewObj : NSObject

///直播控制器
@property (nonatomic, strong, readonly) LiveBaseViewController *liveVC;

///当前view
@property (nonatomic, weak, readonly)UIView *managerView;

///当前view
@property (nonatomic, weak)id<LiveBaseViewObjDelegate> delegate;

///页面个数
@property (nonatomic, assign)NSInteger listCount;


///配置显示的ViewController
- (void)showViewInController:(LiveBaseViewController *)vc mpLiveListReqParam:(LiveRoomListReqParam *)param;





@end

NS_ASSUME_NONNULL_END
