//
//  GroupMemberCell.m
//  Message
//
//  Created by klc_tqd on 2020/5/25.
//  Copyright © 2020 . All rights reserved.
//

#import "GroupMemberCell.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppHomeFamilyUserVOModel.h>
#import  <SDWebImage/SDWebImage.h>
#import <LibProjModel/FansInfoModel.h>

@implementation GroupMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)creatSubView{
    
    self.headerImgV = [[KlcAvatarView alloc] init];
    [self.contentView addSubview:self.headerImgV];
    [self.headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, kScreenWidth - 80, 50)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImgV).offset(5);
        make.left.equalTo(self.headerImgV.mas_right).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
    }];
    
    self.genderImgV = [[SWHTapImageView alloc] init];
    self.genderImgV.layer.masksToBounds = YES;
    self.genderImgV.layer.cornerRadius = 7.5;
    [self.contentView addSubview:self.genderImgV];
    [self.genderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.headerImgV).offset(-5);
    }];

    self.level1ImgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.level1ImgV];
    [self.level1ImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(self.genderImgV.mas_right).offset(5);
        make.bottom.equalTo(self.headerImgV).offset(-5);
    }];
    
    self.level2ImgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.level2ImgV];
    [self.level2ImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.level1ImgV.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.centerY.equalTo(self.level1ImgV);
    }];
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 50-0.3, kScreenWidth, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#CDCDCD");
    [self.contentView addSubview:linkView];
    [linkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView).offset(-1);
    }];
}


- (UIView *)teamLab{
    if (!_teamLab) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        [btn setTitle:kLocalizationMsg(@"团长") forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 12.5;
        btn.layer.borderColor = [ProjConfig normalColors].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.hidden = YES;
        [self.contentView addSubview:btn];
        _teamLab = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 25));
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _teamLab;
}


- (void)setUserModel:(AppHomeFamilyUserVOModel *)userModel{
    _userModel = userModel;
    
    [self.headerImgV showUserIconUrl:userModel.userAvatar vipBorderUrl:userModel.nobleAvatarFrame];
    self.nameLabel.text = userModel.userName;
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:userModel.sex age:userModel.age role:0];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
    };
    if (userModel.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:userModel.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
}

- (void)showFansUserInfo:(FansInfoModel *)fansModel anchorId:(int64_t)anchorId {

    [self.headerImgV showUserIconUrl:fansModel.avatar vipBorderUrl:fansModel.nobleAvatarFrame];
    self.nameLabel.text = fansModel.username;
    self.teamLab.hidden = (fansModel.userId == anchorId)?NO:YES;

    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:fansModel.sex age:fansModel.age role:fansModel.role];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:fansModel.role];
    };
    if (fansModel.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:fansModel.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:fansModel.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:fansModel.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
}

@end
