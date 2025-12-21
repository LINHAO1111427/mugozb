//
//  ApplyUserListCell.m
//  LiveCommon
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "ApplyUserListCell.h"
#import <LibProjBase/ProjConfig.h>
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/AppUserDtoModel.h>

#import <LiveCommon/LiveComponentMsgMgr.h>

@interface ApplyUserListCell()

@property(nonatomic, weak) UIButton *func1Btn;///邀请按钮 等待 其他
@property(nonatomic, weak) UIButton *func2Btn;///开关麦按钮 和 拒绝

@end

@implementation ApplyUserListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    ///用户头像
    KlcAvatarView *avaterImageView = [[KlcAvatarView alloc]init];
    [avaterImageView addTarget:self action:@selector(userInfoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:avaterImageView];
    _avaterImageView = avaterImageView;
    [_avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12);
    }];
    ///用户名称
    UILabel *userNameLb = [[UILabel alloc] init];
    userNameLb.font = [UIFont systemFontOfSize:14];
    userNameLb.textColor = kRGB_COLOR(@"#242424");
    userNameLb.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:userNameLb];
    _userNameLb = userNameLb;
    [_userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avaterImageView.mas_right).offset(10);
        make.top.equalTo(_avaterImageView).offset(1);
    }];
    
    ///性别
    UIImageView *userGenderImgV = [[UIImageView alloc]init];
    userGenderImgV.layer.cornerRadius = 7.5;
    userGenderImgV.layer.masksToBounds = YES;
    userGenderImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:userGenderImgV];
    _userGenderImgV = userGenderImgV;
    [_userGenderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(_userNameLb);
        make.bottom.equalTo(_avaterImageView).offset(-1);
    }];
    
    ///用户等级
    UIImageView *userLevel1ImageV = [[UIImageView alloc]init];
    userLevel1ImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:userLevel1ImageV];
    _level1ImgV = userLevel1ImageV;
    [userLevel1ImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(_userGenderImgV.mas_right).offset(5);
        make.centerY.equalTo(userGenderImgV);
    }];
    
    UIImageView *level2ImgV = [[UIImageView alloc] init];
    level2ImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:level2ImgV];
    _level2ImgV = level2ImgV;
    [level2ImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 15));
        make.left.equalTo(userLevel1ImageV.mas_right).offset(5);
        make.centerY.equalTo(userLevel1ImageV);
    }];
    
    UIView *funcBgView = [[UIView alloc] init];
    [self.contentView addSubview:funcBgView];
    self.funcBgView = funcBgView;
    [funcBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];
}


- (void)showIndex:(NSInteger)index userName:(NSString *)username avatar:(NSString *)avatar iconFrame:(NSString *)frame age:(int)age gender:(int)gender weathLevel:(nonnull NSString *)weathLevel nobleLevel:(nonnull NSString *)nobleLevel{
    [self.avaterImageView showUserIconUrl:avatar vipBorderUrl:frame];
    self.userNameLb.text = username;
    self.userGenderImgV.image = [[ProjConfig shareInstence].baseConfig imageGender:gender age:age role:0];
    if (weathLevel.length) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:weathLevel]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:nobleLevel]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:nobleLevel]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
}


///显示用户连麦样式
- (void)showUserLinkList:(int)mikePrivilege{
    if (!self.func1Btn) {
        UIButton *accessBtn = [[UIButton alloc]init];
        accessBtn.userInteractionEnabled = NO;
        [accessBtn setTitle:kLocalizationMsg(@"等待接入") forState:UIControlStateNormal];
        [accessBtn setTitleColor:kRGBA_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
        accessBtn.layer.cornerRadius = 15;
        accessBtn.layer.masksToBounds = YES;
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.funcBgView addSubview:accessBtn];
        self.func1Btn = accessBtn;
        [self.func1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.funcBgView);
        }];
    }
    if (mikePrivilege) {
        self.contentView.backgroundColor = kRGB_COLOR(@"#FFFAEF");
        [self.func1Btn setTitleColor:kRGB_COLOR(@"#FFB619") forState:UIControlStateNormal];
    }else{
        [self.func1Btn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

///显示在线用户的样式
- (void)showOnlineMicStatus:(int)isInAssistant inviteBlock:(void (^)(void))invite {
    if (!self.func1Btn) {
        UIButton *accessBtn = [[UIButton alloc] init];
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [accessBtn setTitle:kLocalizationMsg(@"邀请连麦") forState:UIControlStateNormal];
        [accessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        accessBtn.backgroundColor = kRGB_COLOR(@"#4BC9FF");
        accessBtn.layer.cornerRadius = 15;
        accessBtn.layer.masksToBounds = YES;
        accessBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [accessBtn klc_whenTapped:^{
            invite?invite():nil;
        }];
        [self.funcBgView addSubview:accessBtn];
        self.func1Btn = accessBtn;
        [self.func1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.funcBgView);
        }];
    }
    
    switch (isInAssistant) {
        case 1:
        {
            /// 已在麦位上
            self.func1Btn.hidden = YES;
        }
                break;
        case 0:
        {
            self.func1Btn.hidden = NO;
        }
                break;
        default:
            break;
    }
}



///显示上麦申请样式
- (void)showApplyUser:(int)mikePrivilege handle:(void (^)(BOOL))handle {
    
    if (!self.func1Btn) {
        UIButton *accessBtn = [[UIButton alloc] init];
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [accessBtn setTitle:kLocalizationMsg(@"接入") forState:UIControlStateNormal];
        accessBtn.backgroundColor = kRGB_COLOR(@"#FFB619");
        [accessBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        accessBtn.layer.cornerRadius = 15;
        accessBtn.layer.masksToBounds = YES;
        accessBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [accessBtn klc_whenTapped:^{
            handle?handle(YES):nil;
        }];
        [self.funcBgView addSubview:accessBtn];
        self.func1Btn = accessBtn;
        [accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.funcBgView);
            make.width.mas_equalTo(60);
        }];
        
        UIButton *rejectBtn = [[UIButton alloc] init];
        [rejectBtn setImage:[UIImage imageNamed:@"live_audio_connect_reject_white"] forState:UIControlStateNormal];
        [rejectBtn klc_whenTapped:^{
            handle?handle(NO):nil;
        }];
        [self.funcBgView addSubview:rejectBtn];
        self.func2Btn = rejectBtn;
        [rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.funcBgView);
            make.width.equalTo(self.func2Btn.mas_height);
            make.left.equalTo(accessBtn.mas_right).offset(10);
        }];
    }
    
    if (mikePrivilege) {
        self.contentView.backgroundColor = kRGB_COLOR(@"#FFFAEF");
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}


///显示连麦管理的样式
- (void)showLinkUserMicStatus:(int)micStatus micHandle:(void (^)(void))micHandle below:(void (^)(void))belowHandle {
    
    if (!self.func1Btn) {
        UIButton *accessBtn = [[UIButton alloc] init];
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [accessBtn setTitle:kLocalizationMsg(@"挂断") forState:UIControlStateNormal];
        [accessBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        accessBtn.layer.cornerRadius = 15;
        accessBtn.layer.masksToBounds = YES;
        accessBtn.layer.borderColor = [UIColor redColor].CGColor;
        accessBtn.layer.borderWidth = 1.0;
        accessBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [accessBtn klc_whenTapped:^{
            belowHandle?belowHandle():nil;
        }];
        [self.funcBgView addSubview:accessBtn];
        self.func1Btn = accessBtn;
        [accessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.funcBgView);
            make.width.mas_equalTo(60);
        }];
        
        UIButton *micBtn = [[UIButton alloc] init];
        [micBtn setImage:[UIImage imageNamed:@"live_jingyin_open"] forState:UIControlStateNormal];
        [micBtn klc_whenTapped:^{
            micHandle?micHandle():nil;
        }];
        [self.funcBgView addSubview:micBtn];
        self.func2Btn = micBtn;
        [micBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self.funcBgView);
            make.width.equalTo(self.func2Btn.mas_height);
            make.right.equalTo(accessBtn.mas_left).offset(-10);
        }];
    }
    
    /// micStatus 1:是 0:否 默认0
    [self.func2Btn setImage:[UIImage imageNamed:micStatus?@"live_jingyin_close":@"live_jingyin_open"] forState:UIControlStateNormal];
}


- (void)userInfoClick{
    if (self.userId > 0) {
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(self.userId)}];
    }
}

@end
