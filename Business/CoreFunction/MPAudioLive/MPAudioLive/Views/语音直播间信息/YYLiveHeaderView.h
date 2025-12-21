//
//  YYLiveHeaderView.h
//  LiveCommon
//
//  Created by klc on 2020/5/22.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYLiveHeaderView : UIView

@property (nonatomic, weak) UIButton *iconBtn;  /// 头像

@property (nonatomic, weak) UILabel *nameL;    /// 名称

@property (nonatomic, weak) UILabel *roomID;    /// 房间ID


///主播自己是否显示头像
- (void)anchorSelfShowFollowBtn:(BOOL)isShow;

///是否已经关注主播
- (void)attentionAnchor:(BOOL)isAtten;

@end

NS_ASSUME_NONNULL_END
