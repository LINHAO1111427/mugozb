//
//  DynamicListViewController.h
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiUserVideoModel;

///动态视频播放列表
@interface DynamicPlayListViewController : UIViewController


@property (nonatomic, copy)NSNumber *index;//点击所在位置
@property (nonatomic, copy)NSNumber *type;//类型0全部1推荐2关注
@property (nonatomic, copy)NSNumber *touId;//评论查看或某个人的短视频
@property (nonatomic, copy)NSNumber *hotId;//动态标签

@property (nonatomic, copy)NSNumber *hasLoading; ///是否有加载更多

@property(nonatomic,strong)NSArray<ApiUserVideoModel *> *models;//动态列表


@end

NS_ASSUME_NONNULL_END
