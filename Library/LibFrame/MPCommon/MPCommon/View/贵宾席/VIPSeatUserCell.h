//
//  VIPSeatUserCell.h
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
NS_ASSUME_NONNULL_BEGIN

@class ApiUserBasicInfoModel;

@interface VIPSeatUserCell : UITableViewCell

@property (nonatomic, weak)UILabel *numL;

@property (nonatomic, weak)KlcAvatarView *userIcon;

@property (nonatomic, weak)UILabel *nameL;

@property (nonatomic, weak)SWHTapImageView *genderImgV;

@property (nonatomic, weak)UIImageView *levelImgV;

@property (nonatomic, weak)UIImageView *vipImgV;

@property (nonatomic, weak)UILabel *coinL;


@property (nonatomic, strong)ApiUserBasicInfoModel *model;

@end

NS_ASSUME_NONNULL_END
