//
//  DYCommentListView.h
//  ShortVideo
//
//  Created by ssssssss on 2020/6/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUserVideoModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface DYCommentListView : UIView

///返回的评论数
@property (nonatomic, copy)void(^commentSuccess)(int commentNum);

///显示用户详情
@property (nonatomic, copy)void(^showUserInfo)(int64_t toUserId);

///初始化
- (instancetype)initWithCommentModel:(ApiUserVideoModel *)model;


///显示在keywindow上 （自带动画效果）
- (void)show;


@end

NS_ASSUME_NONNULL_END
