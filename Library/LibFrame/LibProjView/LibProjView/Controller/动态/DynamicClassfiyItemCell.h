//
//  DynamicClassfiyItemCell.h
//  boboO2O
//
//  Created by klc_03 on 2021/1/15.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
NS_ASSUME_NONNULL_BEGIN

@class ApiUserVideoModel;
@class DynamicClassfiyItemCell;

@protocol DynamicClassfiyItemCellDelegate  <NSObject>

///点赞
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell zanBtnClick:(ApiUserVideoModel *)videoModel;

///更多分享
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell moreBtnClick:(ApiUserVideoModel *)videoModel;

///显示用户信息
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell showUserInfo:(ApiUserVideoModel *)videoModel;

///显示动态详情
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell showDynamicDetail:(ApiUserVideoModel *)videoModel;

///动态标签
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell dynamicLabClick:(ApiUserVideoModel *)videoModel;

///评论
- (void)dynamicClassfiyItemCell:(DynamicClassfiyItemCell *)cell commitBtnClick:(ApiUserVideoModel *)videoModel;

@end

@interface DynamicClassfiyItemCell : UITableViewCell

@property (nonatomic, assign)CGFloat contentW; ///内容宽度

@property (weak, nonatomic) IBOutlet KlcAvatarView *avaterV;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;
@property (weak, nonatomic) IBOutlet SWHTapImageView *sexAgeImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexImageWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *videoLabBtn;
@property (weak, nonatomic) IBOutlet UILabel *textL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLTop;
@property (weak, nonatomic) IBOutlet UIView *contentBgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgVTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgVHeight;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomVTop; ///底部View距离内容view的top值
@property (weak, nonatomic) IBOutlet UIView *levelBgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelLeftConstraint;



@property (nonatomic, weak)id <DynamicClassfiyItemCellDelegate> delegate;

@property (nonatomic, strong) ApiUserVideoModel* videoModel;




@end

NS_ASSUME_NONNULL_END
