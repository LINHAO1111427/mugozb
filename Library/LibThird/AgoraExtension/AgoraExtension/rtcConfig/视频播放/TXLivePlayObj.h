//
//  TXLivePlayObj.h
//  AgoraExtension
//
//  Created by klc_sl on 2021/1/11.
//  Copyright © 2021 XTY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXLivePlayObj : NSObject

@property (nonatomic, weak) UIImageView *playVideoView;   ///播放视图的view
@property (nonatomic, copy) NSString *anchorPullUrl;        //主播拉流url

///优先设置播放封面
@property (nonatomic, copy)NSString *thumb;   ///封面图

@property (nonatomic, assign)BOOL mute; ///设置是否静音

@property (nonatomic, assign)BOOL videoPause; //是否暂停播放


- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initShowInView:(UIView *)superView;


///开始播放视频
- (void)startVideoPlay;
///停止播放视频
- (void)stopVideoPlay;
///重新开始播放
- (void)reStartVideoPlay;





@end

NS_ASSUME_NONNULL_END
