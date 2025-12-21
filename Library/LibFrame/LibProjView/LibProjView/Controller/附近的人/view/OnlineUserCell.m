//
//  OnlineUserCell.m
//  MessageCenter
//
//  Created by klc_tqd on 2020/6/2.
//  Copyright © 2020 . All rights reserved.
//

#import "OnlineUserCell.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage.h>
#import <LibProjView/YHPhotoBrowser.h>
#import <LibProjView/SWHTapImageView.h>
#import "KlcAvatarView.h"
#import <LibProjModel/ApiUsersLineModel.h>

@interface OnlineUserCell ()

@property(nonatomic,strong)KlcAvatarView *headImageV;//头像
@property(nonatomic,strong)UIImageView *onlineImageV;//在线状态
@property(nonatomic,strong)UILabel *userNameL;//昵称
@property(nonatomic,strong)UILabel *distanceL;//距离
@property(nonatomic,strong)UIView *userInfoView;//用户信息

@property(nonatomic,strong)UIScrollView *scroV;

@property(nonatomic,strong)UIView *linkV;//底线
@property(nonatomic,strong)UIButton *otoCallBtn;//1v1拨电话
@property(nonatomic,strong)UIButton *messageBtn;//私信

@property(nonatomic,strong)UIButton *liveBtn;//跟随

@property(nonatomic,strong)NSArray *avatarArr;//头像
@property(nonatomic,strong)NSMutableArray *avatarMutArr;

@end
@implementation OnlineUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [ProjConfig projBgColor];
        [self creatSubView];
    }
    return self;
}
 
 
- (void)setModel:(ApiUsersLineModel *)model{
    _model = model;

    //头像
    [self.headImageV showUserIconUrl:model.avatar vipBorderUrl:model.nobleAvatarFrame];
     
    //昵称 位置
    [self updateUserNameInfo];
     
    //个人角色等级信息
    [self updateUserInfo];
    
     
    //在线状态 0在线 1忙碌  2离开 3通话中
    if ([ProjConfig getAppType] != 4) {
        self.onlineImageV.hidden = NO;
        if (model.userSetOnlineStatus == 0 && model.onlineStatus == 1) {
            self.onlineImageV.backgroundColor = [UIColor greenColor];
        }else{
            self.onlineImageV.backgroundColor = [UIColor redColor];
        }
    }else{
        self.onlineImageV.hidden = YES;
    }
     
    
    //主播 信息
    if (model.role == 1) {
        if ([model.portrait isKindOfClass:[NSNull class]] || model.portrait == nil || [model.portrait length] < 1 ? YES : NO ) {
            self.scroV.hidden = YES;
        }else{
            self.scroV.hidden = NO;
            [self.scroV removeAllSubViews];
            [self updateUserAvatar];
        }
    }else{
        self.scroV.hidden = YES;
    }
  
     
     
    //是否显示按钮
    self.liveBtn.hidden = YES;
    self.otoCallBtn.hidden = NO;
    if ((model.onlineStatus == 1 && model.roomId > 0) && (model.liveType == 1 || model.liveType == 2)) {
        self.liveBtn.hidden = NO;
        self.otoCallBtn.hidden = YES;
    }
    
    //是否包含一对一
    if (![ProjConfig isContain1v1]) {
        self.otoCallBtn.hidden = YES;
    }
    
    [self setNeedsLayout];
}

- (void)updateUserNameInfo{
    //用户昵称信息
    NSString *userNameStr = self.model.userName;
    NSString *locationStr;
    if (self.model.hideDistance) {
        locationStr = kLocalizationMsg(@"隐藏位置");
        userNameStr = [NSString stringWithFormat:@"%@ %@",self.model.userName,locationStr];
    }else{
        if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
            locationStr = (self.model.whetherEnablePositioningShow == 0)?[NSString stringWithFormat:@"%@km",self.model.distance]:@"";
            userNameStr = [NSString stringWithFormat:@"%@ %@",self.model.userName,locationStr];
        }
    }
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:userNameStr];
    if (locationStr.length > 0) {
        [att addAttributes:@{NSFontAttributeName:kFont(12),NSForegroundColorAttributeName:kRGB_COLOR(@"#999999")} range:[userNameStr rangeOfString:locationStr]];
    }
    self.userNameL.attributedText = att;
}
- (void)updateUserInfo{
    //性别 年龄 用户/主播等级 财富等级 贵族
    [self.userInfoView removeAllSubViews];
    
    CGFloat x = 0;
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:_model.sex age:_model.age role:self.model.role];
    if (image) {
        CGFloat height = 15;
        CGFloat scale = image.size.width/image.size.height;
        SWHTapImageView *userAgeBgImageV = [[SWHTapImageView alloc]initWithFrame:CGRectMake(x , 2.5, height*scale, height)];
        userAgeBgImageV.layer.cornerRadius = 7.5;
        userAgeBgImageV.clipsToBounds = YES;
        userAgeBgImageV.contentMode = UIViewContentModeScaleAspectFit;
        userAgeBgImageV.image = image;
        userAgeBgImageV.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:self.model.role];
        };
        [self.userInfoView addSubview:userAgeBgImageV];
        x += height*scale+3;
        
    }
    
     

    ///财富等级
    if ([[ProjConfig shareInstence].baseConfig showWeathLevelImage] && self.model.wealthGradeImg.length > 0) {
        UIImageView *wealthImgV = [[UIImageView alloc]initWithFrame:CGRectMake(x, 3, 30, 15)];
        [wealthImgV sd_setImageWithURL:[NSURL URLWithString:self.model.wealthGradeImg]];
        [self.userInfoView addSubview:wealthImgV];
        x += 30 + 3;
    }

    if (self.model.nobleGradeImg.length > 0) {
        UIImageView *nobelImgV = [[UIImageView alloc]initWithFrame:CGRectMake(x, 3, 30, 15)];
        [nobelImgV sd_setImageWithURL:[NSURL URLWithString:self.model.nobleGradeImg]];
        [self.userInfoView addSubview:nobelImgV];
    }
}



- (void)updateUserAvatar{
    NSArray *allImgArr = [self.model.portrait componentsSeparatedByString:@","];
    if (allImgArr.count > 0) {
        NSMutableArray *imgMutArr = [NSMutableArray arrayWithArray:allImgArr];
        NSString *imgStr = [NSString stringWithFormat:@"%@", allImgArr.lastObject];
        if (imgStr.length == 0) {
            [imgMutArr removeLastObject];
        }
        allImgArr = [NSArray arrayWithArray:imgMutArr];
    }
    self.avatarArr = allImgArr;
    CGFloat width = (kScreenWidth - 72 -15 -20)/3;
    CGFloat magin = 10;
    self.avatarMutArr = [NSMutableArray array];
    for (int i = 0; i< self.avatarArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*(width+magin), 0, width, width)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.avatarArr[i]] placeholderImage: PlaholderImage];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 300+i;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)]];
        [self.scroV addSubview:imageView];
        if (i>2) {
            imageView.hidden = YES;
        }
        [self.avatarMutArr addObject:imageView];
    }
}


#pragma mark - 按钮 手势
-(void)btnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(clickBtnTag: andModel:)]) {
        [self.delegate clickBtnTag:sender.tag - 200 andModel:self.model];
    }
}


-(void)clickHeadImageV{
    if ([self.delegate respondsToSelector:@selector(clickHeaderImageModel:)]) {
        [self.delegate clickHeaderImageModel:self.model];
    }
}


-(void)imageViewTap:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageV = (UIImageView *)tap.view;
    
    NSMutableArray *images = [NSMutableArray array];
    
    for (NSInteger i = 0; i<self.avatarArr.count; i++) {
        
        //创建 YHPhoto 对象
        YHPhoto *photo = [[YHPhoto alloc] init];
        NSURL *url = [NSURL URLWithString:self.avatarArr[i]];
        
        //大图的url
        photo.url = url;
        //起始的imageView数组
        photo.srcImageView = self.avatarMutArr[i];
        [images addObject:photo];
    }
    
    //设置图片浏览器
    YHPhotoBrowser *browser = [[YHPhotoBrowser alloc] init];
    
    browser.photos = images;
    //当前点击的imageView的索引,即第几个imageView
    browser.currentIndex = imageV.tag - 300;
    
    //弹出browser
    [browser showWithPresentingVc:self.selfVc];
}

#pragma mark - 创建UI
-(void)creatSubView{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(50);
    }];
    
    //头像
    [backView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
    }];
    
    //在线状态
    [backView addSubview:self.onlineImageV];
    [self.onlineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(52);
        make.top.mas_equalTo(40);
        make.width.height.mas_equalTo(10);
    }];
     
    
    //短信 连线 跟随
    CGFloat rithtX = kScreenWidth - 40 - 12;
    [backView addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rithtX);
        make.top.mas_equalTo(5);
        make.width.height.mas_equalTo(40);
    }];
    
    if ([ProjConfig getAppType] != 4) {
        //连线
        [backView addSubview:self.otoCallBtn];
        [self.otoCallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rithtX-40-12);
            make.centerY.equalTo(self.messageBtn);
            make.width.height.mas_equalTo(40);
        }];
        
        //跟随
        [backView addSubview:self.liveBtn];
        [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rithtX-60-12);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.centerY.equalTo(self.messageBtn);
        }];
        
        rithtX = rithtX-60-12;
    }
    
    //昵称
    [backView addSubview:self.userNameL];
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageV.mas_right).offset(10);
        make.top.mas_equalTo(3);
        if ([ProjConfig getAppType] != 4) {
            make.right.equalTo(self.liveBtn.mas_left);
        }else{
            make.right.equalTo(self.messageBtn.mas_left);
        }
        make.height.mas_equalTo(20);
    }];
    
    
    //用户信息
    [backView addSubview:self.userInfoView];
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameL);
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(kScreenWidth-rithtX);
        make.height.mas_equalTo(20);
    }];
    
    //底部线条
    [self.contentView addSubview: self.linkV];
    [self.linkV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(0.3);
    }];
    
    //主播视图
    [self.contentView addSubview:self.scroV];
    [self.scroV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(72);
        make.top.mas_equalTo(75);
        make.width.mas_equalTo(kScreenWidth - 72 -15);
        make.height.mas_equalTo((kScreenWidth - 72 -15 -20)/3);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGFloat)getOnlineUserCellHeight:(ApiUsersLineModel *)model{
    if (model.role == 1) {
        if ([model.portrait isKindOfClass:[NSNull class]] || model.portrait == nil || [model.portrait length] < 1 ? YES : NO ) {
            return 80;
        }
        return 75 + (kScreenWidth - 74 -15-20)/3  + 15;
    }
    
    return 80;
}


#pragma mark - 懒加载
- (KlcAvatarView *)headImageV{
    if (!_headImageV) {
        _headImageV = [[KlcAvatarView alloc]init];
        [_headImageV addTarget:self action:@selector(clickHeadImageV) forControlEvents:UIControlEventTouchUpInside];
        _headImageV.userInteractionEnabled = YES;
    }
    return _headImageV;
}
- (UIImageView *)onlineImageV{
    if (!_onlineImageV) {
        _onlineImageV = [[UIImageView alloc]init];
        _onlineImageV.backgroundColor = [UIColor greenColor];
        _onlineImageV.layer.cornerRadius = 5;
        _onlineImageV.layer.masksToBounds = YES;
        _onlineImageV.hidden = YES;
    }
    return _onlineImageV;
}
- (UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.tag = 200;
        [_messageBtn setImage:[UIImage imageNamed:@"messageCenter_faxiaoxi"] forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (UIButton *)otoCallBtn{
    if (!_otoCallBtn) {
        _otoCallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _otoCallBtn.tag = 200 + 1;
        _otoCallBtn.hidden = YES;
        [_otoCallBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *imageName;
        switch ([[ProjConfig shareInstence].baseConfig getOtoType]) {
            case 1:
            { imageName = @"icon_oto_videoCall"; } break;
            case 2:
            { imageName = @""; } break;
            default:
            { imageName = @"icon_1v1_call"; }
                break;
        }
        [_otoCallBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    return _otoCallBtn;
}
- (UIButton *)liveBtn{
    if (!_liveBtn) {
        _liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveBtn setImage:[UIImage imageNamed:@"live_person_follow"] forState:UIControlStateNormal];
        _liveBtn.tag = 200 + 3;
        _liveBtn.hidden = YES;
        [_liveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _liveBtn;
}
- (UILabel *)userNameL{
    if (!_userNameL) {
        _userNameL = [[UILabel alloc]init];
        _userNameL.textAlignment = NSTextAlignmentLeft;
        _userNameL.textColor = kRGB_COLOR(@"#242424");
        _userNameL.font = [UIFont systemFontOfSize:14];
    }
    return _userNameL;
}
 
- (UIView *)userInfoView{
    if (!_userInfoView) {
        _userInfoView = [[UIView alloc]init];
        _userInfoView.backgroundColor = [UIColor clearColor];
    }
    return _userInfoView;
}
- (UIView *)linkV{
    if (!_linkV) {
        _linkV = [[UIView alloc]init];
        _linkV.backgroundColor = kRGB_COLOR(@"#EEEEEE");
    }
    return _linkV;
}
- (UIScrollView *)scroV{
    if (!_scroV) {
        _scroV = [[UIScrollView alloc]init];
        _scroV.hidden = YES;
    }
    return _scroV;
}
@end
