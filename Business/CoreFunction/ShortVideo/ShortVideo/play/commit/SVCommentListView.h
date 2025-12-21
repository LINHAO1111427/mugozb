//
//  SVCommentListView.h
//  ShortVideo
//
//  Created by ssssssss on 2020/6/22.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface SVCommentListView : UIView

///返回的评论数
@property (nonatomic, copy)void(^commentSuccess)(NSInteger commentNum);

///显示用户详情
@property (nonatomic, copy)void(^showUserInfo)(int64_t toUserId);

///初始化
- (instancetype)initWithCommentModel:(ApiShortVideoDtoModel *)model;


///显示在keywindow上 （自带动画效果）
- (void)show;

///显示在某个视图上（自带动画效果）
- (void)showInView:(UIView *)superView;


///评论动态 type1评论2回复
+ (void)commentWithToId:(int64_t)toId replay:(BOOL)isReplay msg:(NSString *)msg videoId:(int64_t)videoId callback:(void(^)(BOOL success))callback;

+ (void)getCommentNum:(int64_t)videoId callback:(void(^)(NSInteger commentNum))callback;

@end

NS_ASSUME_NONNULL_END
