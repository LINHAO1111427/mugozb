//
//  Dynamic08ClassfiyItemCell.h
//  klcLive
//
//  Created by SWH05 on 2022/2/14.
//  Copyright © 2022 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
NS_ASSUME_NONNULL_BEGIN
@class ApiUserVideoModel;
@class Dynamic02ClassfiyItemCell;

@protocol Dynamic02ClassfiyItemCellDelegate  <NSObject>

///点赞
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell zanBtnClick:(ApiUserVideoModel *)videoModel;

///更多分享
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell shareBtnClick:(ApiUserVideoModel *)videoModel;

///显示用户信息
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell moreBtnClick:(ApiUserVideoModel *)videoModel;

///显示动态详情
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell showDynamicDetail:(ApiUserVideoModel *)videoModel;

///动态标签
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell dynamicLabClick:(ApiUserVideoModel *)videoModel;

///评论
- (void)dynamicClassfiyItemCell:(Dynamic02ClassfiyItemCell *)cell commitBtnClick:(ApiUserVideoModel *)videoModel;
 


@end


@interface Dynamic02ClassfiyItemCell : UITableViewCell

@property (nonatomic, assign)CGFloat contentW; ///内容宽度

@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *monthL;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
 
@property (weak, nonatomic) IBOutlet UIButton *videoLabBtn;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labH;
@property (weak, nonatomic) IBOutlet UIView *contentBgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgVTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgVHeight;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVTop; ///底部View距离内容view的top值
 



@property (nonatomic, weak)id <Dynamic02ClassfiyItemCellDelegate> delegate;

@property (nonatomic, strong) ApiUserVideoModel* videoModel;

@end

NS_ASSUME_NONNULL_END
