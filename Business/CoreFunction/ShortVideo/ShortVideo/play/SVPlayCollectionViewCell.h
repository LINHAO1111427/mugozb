//
//  SVPlayCollectionViewCell.h
//  ShortVideo
//
//  Created by KLC on 2020/6/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjView/PlayVideoView.h>


NS_ASSUME_NONNULL_BEGIN


@class SVPlayCollectionViewCell;

@protocol SVPlayCollectionViewCellDelegate <NSObject>

///显示用户信息
- (void)playCell:(SVPlayCollectionViewCell *)playCell showUserInfo:(int64_t)userId;

///点击短视频标签
- (void)playCell:(SVPlayCollectionViewCell *)playCell shortVideoTagId:(NSInteger)tagId tagLabel:(NSString *)tagLabel;

///展示直播购商品
- (void)playCell:(SVPlayCollectionViewCell *)playCell showGoods:(int64_t)goodsId;

///一对一打电话
- (void)playCell:(SVPlayCollectionViewCell *)playCell otoVideoCall:(ApiShortVideoDtoModel *)model;

///广告展示
- (void)playCell:(SVPlayCollectionViewCell *)playCell adsUrl:(NSString *)adsUrl;

///删除当前视频
- (void)playCell:(SVPlayCollectionViewCell *)playCell removeVideoId:(int64_t)videoId;

@end


@interface SVPlayCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign)BOOL isPausePlay;//暂停中
@property (nonatomic, strong)PlayVideoView *playVideoView;
@property (nonatomic, weak)UIViewController *superVc;
@property (nonatomic, assign)int dataType;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)ApiShortVideoDtoModel *model;

@property(nonatomic,weak) id<SVPlayCollectionViewCellDelegate> delegate;

- (void)startPlayVideo;//继续
- (void)stopPlayVideo;//停止
- (void)pauseVideo;//暂停
- (void)resumeVideo;//恢复
- (void)changePlayStaus;

 
@end

NS_ASSUME_NONNULL_END
 
