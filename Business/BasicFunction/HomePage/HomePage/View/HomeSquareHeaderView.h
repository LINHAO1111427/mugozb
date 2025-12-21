//
//  HomeSquareHeaderView.h
//  MPVideoLive
//
//  Created by ssssssss on 2020/1/10.
//  Copyright © 2020 Orely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/AppAdsModel.h>

@class HomeDtoModel;
@class AppLiveChannelModel;
@class AppHotSortModel;
@class AppHomeHallDTOModel;
@class AppAdsModel;


NS_ASSUME_NONNULL_BEGIN

@class AppAdsModel;
@class AppHotSortModel;

@protocol HomeSquareHeaderViewDelegate <NSObject>
@optional

///视图高度
- (void)changeHeaderViewHeight:(CGFloat)height;

///选择某一个频道
- (void)LiveMainHeaderSelectType:(int64_t)channelId;

///点击第几个广告
- (void)clickAdvertising:(NSString *)adverUrl;

///直播分类
- (void)hotSortSelectedIndex:(NSInteger)index hotSortModel:(AppHotSortModel *)model;

@end


@interface HomeSquareHeaderView : UICollectionReusableView

///1:视频直播。  2:语音直播
@property(nonatomic,assign)int liveType;

@property (nonatomic, strong)HomeDtoModel *dtoModel;

@property (nonatomic, weak)id<HomeSquareHeaderViewDelegate> delegate;


- (void)reloadAdData;

- (void)startTimer;

- (void)stopTimer;


@end
NS_ASSUME_NONNULL_END
