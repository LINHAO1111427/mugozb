//
//  UserAttentionLiveVC.h
//  HomePage
//
//  Created by klc on 2020/6/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAttentionLiveVC : UIViewController<JXCategoryListContentViewDelegate>

//直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
@property (nonatomic, assign) int liveType;

@end

NS_ASSUME_NONNULL_END
