//
//  FamilyRoomItemCell.m
//  OTMLive
//
//  Created by klc_sl on 2020/12/18.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyRoomItemCell.h"
#import <Masonry/Masonry.h>
#import <LibProjModel/LiveRoomInfoVOModel.h>
#import <SDWebImage/SDWebImage.h>
#import <LibTools/LibTools.h>

@implementation FamilyRoomItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIImageView *)userThumb {
    if (!_userThumb) {
        ///主播封面
        UIImageView *userThumb = [[UIImageView alloc] init];
        userThumb.layer.masksToBounds = YES;
        userThumb.layer.cornerRadius = 5;
        userThumb.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:userThumb];
        _userThumb = userThumb;
        [userThumb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];

        ///底色
        UIImageView *bottomColorImgV = [[UIImageView alloc] init];
        bottomColorImgV.image = [UIImage imageNamed:@"live_img_shadow"];
        [self.contentView addSubview:bottomColorImgV];
        [bottomColorImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.right.bottom.equalTo(self.contentView).mas_offset(0);
        }];
        
        ///房间人数
        UILabel *roomNumL = [[UILabel alloc] init];
        roomNumL.textColor = [UIColor whiteColor];
        roomNumL.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        roomNumL.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:roomNumL];
        _roomNumL = roomNumL;
        [roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(30);
            make.bottom.equalTo(self.contentView).mas_offset(-5);
            make.right.equalTo(self.contentView).mas_offset(-5);
        }];
        ///主播名称
        UILabel *titleL = [[UILabel alloc] init];
        titleL.textColor = [UIColor whiteColor];
        titleL.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.contentView addSubview:titleL];
        _userNameL = titleL;
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(5);
            make.centerY.equalTo(roomNumL);
            make.right.equalTo(roomNumL.mas_left).mas_offset(0);
        }];
        
        ///房间标示
        UIImageView *selectImgV = [[UIImageView alloc] init];
        selectImgV.image = [UIImage imageNamed:@"live_family_recommond"];
        [self.contentView addSubview:selectImgV];
        _selectImgV = selectImgV;
        [selectImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.top.equalTo(self.contentView).mas_offset(5);
            make.right.equalTo(self.contentView).mas_offset(-5);
        }];

        ///房间分类
        UIButton *roomTypeBtn = [UIButton buttonWithType:0];
        roomTypeBtn.userInteractionEnabled = NO;
        roomTypeBtn.backgroundColor = kRGBA_COLOR(@"#000000", 0.3);
        roomTypeBtn.layer.masksToBounds = YES;
        roomTypeBtn.layer.cornerRadius = 7.5;
        roomTypeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        roomTypeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        roomTypeBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:roomTypeBtn];
        _roomTypeBtn = roomTypeBtn;
        [roomTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.equalTo(self.contentView).mas_offset(5);
            make.centerY.equalTo(selectImgV);
        }];
    }
    return _userThumb;
}

- (void)selectOneItem:(BOOL)selected{
    _selectImgV.image = [UIImage imageNamed:selected?@"svip_user_select":@"svip_user_unselect"];
}


- (void)setVoModel:(LiveRoomInfoVOModel *)voModel {
    _voModel = voModel;
    [self.userThumb sd_setImageWithURL:[NSURL URLWithString:voModel.thumb]];
    self.roomNumL.text  = kStringFormat(@"%d",voModel.nums);
    self.userNameL.text = voModel.username;
    [self.roomTypeBtn setTitle:voModel.channelName forState:UIControlStateNormal];
    if (voModel.liveType == 2) {///语音
        self.selectImgV.hidden = NO;
    }else{
        self.selectImgV.hidden = YES;
    }
    
}

@end
