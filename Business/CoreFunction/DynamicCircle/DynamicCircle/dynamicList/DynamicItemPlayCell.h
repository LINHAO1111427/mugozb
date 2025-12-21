//
//  DynamicPlayCell.h
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjModel/ApiUserVideoModel.h>

NS_ASSUME_NONNULL_BEGIN
@class DynamicItemPlayCell;
@protocol DynamicItemPlayCellDelegate <NSObject>
@optional
- (void)dynamicItemPlayCellAvaterBtnClick:(DynamicItemPlayCell *)cell model:(ApiUserVideoModel *)model;
- (void)dynamicItemPlayCellReportBtnClick:(DynamicItemPlayCell *)cell model:(ApiUserVideoModel *)model;
- (void)dynamicItemPlayCellCommentAvaterBtnClick:(DynamicItemPlayCell *)cell user_id:(int64_t)userId;

- (void)dynamicItemPlayCell:(DynamicItemPlayCell *)cell didSelectDynamicImage:(ApiUserVideoModel *)model;

@end

@interface DynamicItemPlayCell : UICollectionViewCell
@property (nonatomic, assign)BOOL isPausePlay;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong)ApiUserVideoModel *model;
@property(nonatomic,weak) id<DynamicItemPlayCellDelegate> delegate;
- (void)startPlayVideo;//继续
- (void)stopPlayVideo;//停止
- (void)changePlayStaus;
- (void)pauseVideo;//暂停
- (void)resumeVideo;//继续
@end

NS_ASSUME_NONNULL_END
 
