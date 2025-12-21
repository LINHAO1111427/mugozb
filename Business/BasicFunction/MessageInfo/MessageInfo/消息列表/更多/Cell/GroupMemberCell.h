//
//  GroupMemberCell.h
//  Message
//
//  Created by klc_tqd on 2020/5/25.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>

@class AppHomeFamilyUserVOModel;
@class FansInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface GroupMemberCell : UITableViewCell

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)KlcAvatarView *headerImgV;
@property (nonatomic,strong)SWHTapImageView *genderImgV;
@property (nonatomic,strong)UIImageView *level1ImgV;
@property (nonatomic,strong)UIImageView *level2ImgV;


@property (nonatomic, weak)UIView *teamLab;

@property (nonatomic, strong)AppHomeFamilyUserVOModel *userModel;


///显示粉丝团
- (void)showFansUserInfo:(FansInfoModel *)fansModel anchorId:(int64_t)anchorId ;


@end

NS_ASSUME_NONNULL_END
