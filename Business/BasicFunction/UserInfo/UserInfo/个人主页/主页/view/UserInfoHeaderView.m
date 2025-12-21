//
//  UserInfoHeaderView.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoHeaderView.h"
#import <LibProjBase/ProjConfig.h>
#import <LibProjView/SDPhotoBrowser.h>
#import <LibProjView/FansGroupShowView.h>
#import <LibProjView/NewPagedFlowView.h>
#import <LibProjView/PGIndexBannerSubiew.h>
#import <LibProjView/CheckRoomPermissions.h>
#import <LibProjModel/UserInfoHomeVOModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/OooLiveConfigVOModel.h>
#import <LibProjView/OneLiveCheckContactView.h>
#import <LibProjModel/HttpApiUserController.h>
#import "UserInfoVoicePlayView.h"

@interface UserInfoHeaderView ()<UIScrollViewDelegate,SDPhotoBrowserDelegate,NewPagedFlowViewDataSource,NewPagedFlowViewDelegate>

@property (nonatomic, strong)UIView *gradientView;
@property (nonatomic, strong)UIView *starLevelV;//星级
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSMutableArray *picPathStringsArray;

@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UILabel *usernameL;//昵称
@property (nonatomic, strong)UILabel *genderL; ///性别

@property (nonatomic, strong)UIView *levelBgV;//等级背景view

@property (nonatomic, strong)UIButton *attentBtn;
@property (nonatomic, strong)UILabel *signatureL;// 签名

@property (nonatomic, weak)UILabel *coinLevelL;// 财富值
@property (nonatomic, weak)UIImageView *coinLevelIconV;// 财富等级图标
@property (nonatomic, weak)UILabel *charmL;// 魅力值
@property (nonatomic, weak)UIImageView *charmIconV;// 魅力值图标

@property (nonatomic, strong)UILabel *voiceCallL;
@property (nonatomic, strong)UILabel *videoCallL;
@property (nonatomic, strong)UILabel *locationL;//距离
@property (nonatomic, strong)UIButton *userStatusBtn;//状态
@property (nonatomic, strong)UIView *userStatusPoint;
@property (nonatomic, weak)UIButton *contactBtn; ///私信按钮
@property (nonatomic, weak)UIButton *followBtn; ///跟随按钮

///播放主播设置的声音
@property (nonatomic, weak)UserInfoVoicePlayView *playVoice;

///标签view
@property (nonatomic, weak)UIView *labelBgV;
///财富view
@property (nonatomic, weak)UIView *wealthBgView;
///通话view
@property (nonatomic, weak)UIView *callBgView;
///定位
@property (nonatomic, weak)UIView *addressBgView;
///轮播
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

@end


@implementation UserInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)createUI{
    [self addSubview:self.pageFlowView];
    [self addContentV];
}

- (void)addContentV{
    [self addSubview:self.contentV];
    [self addSubview:self.gradientView];
    [self.gradientView addSubview:self.starLevelV];
    [self.gradientView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.gradientView).mas_offset(-10);
        make.centerY.equalTo(self.gradientView);
    }];
    
    CGFloat y = 0;
    {//在线状态
        UIView *userStatusView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-12-60,kNavBarHeight+10, 54, 20)];
        userStatusView.backgroundColor =kRGBA_COLOR(@"#000000", 0.3);
        userStatusView.layer.cornerRadius = 10;
        userStatusView.clipsToBounds = YES;
        [self addSubview:userStatusView];
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(6, 0, 6, 6)];
        point.centerY = userStatusView.height/2.0;
        point.layer.cornerRadius = 4;
        point.clipsToBounds = YES;
        self.userStatusPoint = point;
        [userStatusView addSubview:point];
        
        UIButton *userStatusBtn = [[UIButton alloc]initWithFrame:userStatusView.bounds];
        [userStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        userStatusBtn.backgroundColor = [UIColor clearColor];
        userStatusBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        self.userStatusBtn = userStatusBtn;
        [userStatusView addSubview:userStatusBtn];
        [self addSubview:userStatusView];
    }
    
    {
        //主播声音
        if ([[ProjConfig shareInstence].baseConfig showUserVoice]) {
            UserInfoVoicePlayView *playV = [[UserInfoVoicePlayView alloc] initWithFrame:CGRectMake(kScreenWidth-100, (self.height-100)/2.0, 100, 50)];
            playV.hidden = YES;
            [self addSubview:playV];
            self.playVoice = playV;
        }
    }
    
    {//昵称 性别 等级
        UILabel *usernameL = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, kScreenWidth-90, 30)];
        usernameL.textColor = kRGB_COLOR(@"#333333");
        usernameL.textAlignment = NSTextAlignmentLeft;
        usernameL.font = [UIFont boldSystemFontOfSize:22];
        usernameL.layer.cornerRadius = 15;
        usernameL.clipsToBounds = YES;
        self.usernameL = usernameL;
        [self.contentV addSubview:self.usernameL];
        
        UILabel *genderL = [[UILabel alloc]initWithFrame:CGRectMake(self.usernameL.maxX, self.usernameL.maxY-16, 50, 13)];
        genderL.textColor = kRGB_COLOR(@"#999999");
        genderL.font = [UIFont boldSystemFontOfSize:12];
        [self.contentV addSubview:genderL];
        _genderL = genderL;
        
        UIView *levelBgV = [[UIView alloc] initWithFrame:CGRectMake(20, usernameL.maxY+7, 140, 15)];
        [self.contentV addSubview:levelBgV];
        self.levelBgV = levelBgV;
        
        y += 70;
        y += 5;
    }
    
    {//关注 粉丝团 跟随
        
        UIButton *attentBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-70, 5, 60, 60)];
        attentBtn.backgroundColor = [UIColor clearColor];
        [attentBtn setImage:[UIImage imageNamed:@"icon_userinfo_attent_normal"] forState:UIControlStateNormal];
        attentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        attentBtn.hidden = YES;
        if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
            [attentBtn setImage:[UIImage imageNamed:@"icon_userinfo_attent_selected"] forState:UIControlStateSelected];
            [attentBtn setTitle:kLocalizationMsg(@"粉丝团") forState:UIControlStateSelected];
            [attentBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        }else{
            UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 116, 116)];
            textL.text = kLocalizationMsg(@"已关注");
            textL.font = [UIFont systemFontOfSize:25];
            textL.textAlignment = NSTextAlignmentCenter;
            textL.textColor = [UIColor grayColor];
            [attentBtn setImage:[UIImage imageConvertFromView:textL] forState:UIControlStateSelected];
        }
        [attentBtn addTarget:self action:@selector(attentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        attentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [attentBtn setTitleEdgeInsets:UIEdgeInsetsMake(attentBtn.imageView.frame.size.height+5,-attentBtn.imageView.frame.size.width, 0.0,0.0)];
        [attentBtn setImageEdgeInsets:UIEdgeInsetsMake(-attentBtn.titleLabel.bounds.size.height,(attentBtn.frame.size.width-attentBtn.imageView.bounds.size.width)/2.0,5,(attentBtn.frame.size.width-attentBtn.imageView.bounds.size.width)/2.0)];
        self.attentBtn = attentBtn;
        [self.contentV addSubview:attentBtn];
        
        CGFloat leftX = attentBtn.x;
        
        
        if (![KLCAppConfig appConfig].oooLiveConfigVO.homeAnchorContact && [ProjConfig isContain1v1]) {
            
            UIButton *contactBtn = [UIButton buttonWithType:0];
            contactBtn.frame = CGRectMake(leftX-66, attentBtn.y, 66, 53.5);
            contactBtn.centerY = attentBtn.centerY-3;
            [contactBtn setImage:[UIImage imageNamed:@"oto_big_airport"] forState:UIControlStateNormal];
            [self.contentV addSubview:contactBtn];
            contactBtn.hidden = YES;
            self.contactBtn = contactBtn;
            [contactBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            leftX = contactBtn.x;
            
            UILabel *contactTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 53.5, contactBtn.width, 16)];
            contactTitleL.text = kLocalizationMsg(@"联系方式");
            contactTitleL.font = [UIFont systemFontOfSize:13];
            contactTitleL.textColor = [ProjConfig normalColors];
            contactTitleL.textAlignment = NSTextAlignmentCenter;
            [contactBtn addSubview:contactTitleL];
            
        }
        
        ///包含语音和这视频
        if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
            UIButton *followBtn = [UIButton buttonWithType:0];
            followBtn.frame = CGRectMake(leftX-60-5, attentBtn.y, 60, 30);
            followBtn.centerY = attentBtn.centerY-3;
            [followBtn setBackgroundImage:[UIImage imageNamed:@"live_person_follow"] forState:UIControlStateNormal];
            [self.contentV addSubview:followBtn];
            self.followBtn = followBtn;
            followBtn.hidden = YES;
            [followBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    {//签名
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 30)];
        [self.contentV addSubview:bgView];
        self.labelBgV = bgView;
        CGFloat headerH = [self setHeaderHeightForBgView:bgView titleStr:kLocalizationMsg(@"Ta的标签")];
        
        UILabel *signatureL = [[UILabel alloc]initWithFrame:CGRectMake(20, headerH, kScreenWidth-40, 32)];
        signatureL.textAlignment = NSTextAlignmentLeft;
        signatureL.textColor = kRGB_COLOR(@"#999999");
        signatureL.font = [UIFont systemFontOfSize:14];
        signatureL.numberOfLines = 0;
        self.signatureL = signatureL;
        [bgView addSubview:signatureL];
        
        bgView.height = (headerH+signatureL.height);
        y += bgView.height;
    }
    
    {
        ///家族
        FamilyInfoAtUserDetailView *familyInfoV = [[FamilyInfoAtUserDetailView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 0.1)];
        [self.contentV addSubview:familyInfoV];
        self.familyInfoV = familyInfoV;
        
        if ([[ProjConfig shareInstence].baseConfig hasFamilyGroup]) {
            
            kWeakSelf(self);
            familyInfoV.viewHeightBlock = ^(BOOL hasFamily) {
                if (hasFamily) {
                    CGFloat headerH = [self setHeaderHeightForBgView:self.familyInfoV titleStr:kLocalizationMsg(@"Ta的家族")];
                    [weakself.familyInfoV changeViewLayout:headerH];
                }
                
                weakself.wealthBgView.y = weakself.familyInfoV.maxY;
                weakself.callBgView.y = weakself.wealthBgView.maxY;
                weakself.addressBgView.y = weakself.callBgView.maxY;
                weakself.contentV.height = weakself.addressBgView.maxY+10;
                weakself.height = weakself.contentV.maxY;
                [weakself.contentV cornerRadii:CGSizeMake(10,10) byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft)];
                
                if (weakself.reloadHeightBlock) {
                    weakself.reloadHeightBlock();
                }
                
            };
        }
    }
    
    {
        ///财富
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 0.1)];
        bgView.clipsToBounds = YES;
        [self.contentV addSubview:bgView];
        self.wealthBgView = bgView;
        
        if ([KLCAppConfig appConfig].adminLiveConfig.showWealthAndCharm == 0) {
            
            CGFloat headerH = [self setHeaderHeightForBgView:bgView titleStr:kLocalizationMsg(@"Ta的财富")];
            NSMutableArray *itemArr = [[NSMutableArray alloc] initWithCapacity:2];
            [itemArr addObject:@{@"title":kLocalizationMsg(@" 土豪值"), @"type":@(1)}];
            [itemArr addObject:@{@"title":kLocalizationMsg(@" 魅力值"), @"type":@(2)}];
            
            for (int i = 0; i < itemArr.count; i++) {
                NSDictionary *subDic = itemArr[i];
                
                UIView *bgVi = [[UIView alloc] initWithFrame:CGRectMake(20, headerH+i*30, kScreenWidth-40, 30)];
                [bgView addSubview:bgVi];
                
                UIImageView *iconV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 40, 20)];
                iconV.contentMode = UIViewContentModeScaleAspectFit;
                [bgVi addSubview:iconV];
                
                UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(iconV.maxX, 0, 52, 20)];
                titleL.centerY = iconV.centerY;
                titleL.text = subDic[@"title"];
                titleL.font = [UIFont systemFontOfSize:14];
                titleL.textColor = kRGB_COLOR(@"#999999");
                [bgVi addSubview:titleL];
                
                UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(titleL.maxX+10, 0, kScreenWidth-130, 20)];
                coinL.centerY = titleL.centerY;
                coinL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
                coinL.textColor = kRGB_COLOR(@"#666666");
                [bgVi addSubview:coinL];
                
                if ([subDic[@"type"] intValue] == 1) {
                    // 财富值
                    self.coinLevelL = coinL;
                    self.coinLevelIconV = iconV;
                }else{
                    // 魅力值
                    self.charmL = coinL;
                    self.charmIconV = iconV;
                }
            }
            bgView.height = (headerH+itemArr.count*30);
            y += bgView.height;
        }
    }
    
    {//一对一
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 0.1)];
        bgView.clipsToBounds = YES;
        [self.contentV addSubview:bgView];
        self.callBgView = bgView;
        
        if ([ProjConfig isContain1v1] && [KLCAppConfig showOtmCoin]) {
            
            CGFloat headerH = [self setHeaderHeightForBgView:bgView titleStr:kLocalizationMsg(@"和Ta通话")];
            
            NSMutableArray *itemArr = [[NSMutableArray alloc] initWithCapacity:2];
            if ([[ProjConfig shareInstence].baseConfig getOtoType] == 0 || [[ProjConfig shareInstence].baseConfig getOtoType] == 1) {
                [itemArr addObject:@{@"imageStr":@"icon_userinfo_video_call",@"title":kLocalizationMsg(@" 视频通话"), @"type":@(1)}];
            }
            if ([[ProjConfig shareInstence].baseConfig getOtoType] == 0 || [[ProjConfig shareInstence].baseConfig getOtoType] == 2) {
                [itemArr addObject:@{@"imageStr":@"icon_userinfo_voice_call",@"title":kLocalizationMsg(@" 语音通话"), @"type":@(2)}];
            }
            for (int i = 0; i < itemArr.count; i++) {
                NSDictionary *subDic = itemArr[i];
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, headerH+i*30, 80, 30)];
                btn.enabled = NO;
                [btn setImage:[UIImage imageNamed:subDic[@"imageStr"]] forState:UIControlStateNormal];
                [btn setTitle:subDic[@"title"] forState:UIControlStateNormal];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
                [bgView addSubview:btn];
                
                UILabel *callL = [[UILabel alloc]initWithFrame:CGRectMake(btn.maxX+10, 0, kScreenWidth-130, 20)];
                callL.centerY = btn.centerY;
                callL.textAlignment = NSTextAlignmentLeft;
                callL.font = [UIFont systemFontOfSize:14];
                callL.textColor = kRGB_COLOR(@"#999999");
                
                if ([subDic[@"type"] intValue] == 2) {
                    self.voiceCallL = callL;
                }else{
                    self.videoCallL = callL;
                }
                
                [bgView addSubview:callL];
            }
            bgView.height = (headerH+itemArr.count*30);
            y += bgView.height;
        }
    }
    
    {//距离
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, 0.1)];
        [self.contentV addSubview:bgView];
        self.addressBgView = bgView;
        
        if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
            
            UIImageView *locationImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
            locationImageV.image = [UIImage imageNamed:@"icon_userinfo_location_black"];
            locationImageV.contentMode = UIViewContentModeScaleAspectFit;
            [bgView addSubview:locationImageV];
            
            UILabel *locationL = [[UILabel alloc]initWithFrame:CGRectMake(locationImageV.maxX+5, locationImageV.y+1, kScreenWidth-70, 15)];
            locationL.textAlignment = NSTextAlignmentLeft;
            locationL.font = [UIFont systemFontOfSize:13];
            locationL.textColor = kRGB_COLOR(@"#666666");
            self.locationL = locationL;
            [bgView addSubview:locationL];
            
            bgView.height = 40;
            y += bgView.height;
        }
    }
    
    self.contentV.height = y+10;
    self.height = self.contentV.maxY;
    
    [self.contentV cornerRadii:CGSizeMake(10,10) byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft)];
    
}


- (CGFloat)setHeaderHeightForBgView:(UIView *)superBgView titleStr:(NSString *)titleStr{
    UILabel *itemHeightTitleL = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    itemHeightTitleL.textAlignment = NSTextAlignmentLeft;
    itemHeightTitleL.textColor = kRGB_COLOR(@"#666666");
    itemHeightTitleL.font = [UIFont boldSystemFontOfSize:15];
    itemHeightTitleL.text = titleStr;
    [superBgView addSubview:itemHeightTitleL];
    return itemHeightTitleL.height;
}

///获取用户的设置的形象图片
- (void)getUserPortraitInfo{
    kWeakSelf(self);
    [HttpApiUserController getAppUserDataReviewList:self.homeModel.userInfo.userId callback:^(int code, NSString *strMsg, NSArray<AppUserDataReviewVOModel *> *arr) {
        [weakself.picPathStringsArray removeAllObjects];
        if (code == 1 && arr.count > 0) {
            for (AppUserDataReviewVOModel *model in arr) {
                [weakself.picPathStringsArray addObject:model.oldUserContent];
            }
        }else{
            [weakself.picPathStringsArray insertObject:weakself.homeModel.userInfo.avatar atIndex:0];
        }
        [self.pageFlowView reloadData];
    }];
}


- (void)setHomeModel:(UserInfoHomeVOModel *)homeModel {
    _homeModel = homeModel;
    
    ApiUserInfoModel *userInfo = homeModel.userInfo;
    ///获取用户的宣传图
    [self getUserPortraitInfo];
    
    //状态
    //  0离线 1忙碌  2在线 3通话中 4 看直播 5 匹配中 6 直播中 7离开
    switch (homeModel.showStatus) {
        case 0:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"离线") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor grayColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
        case 1:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"忙碌") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor redColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
        case 2:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"在线") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor greenColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
        case 3:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"通话中") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor purpleColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
            break;
        case 4:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"看直播") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor whiteColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
            break;
        case 5:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"匹配中") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor whiteColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
            break;
        case 6:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"直播中") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor whiteColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
            break;
        case 7:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"离开") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor grayColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
        default:
            [self.userStatusBtn setTitle:kLocalizationMsg(@"忙碌") forState:UIControlStateNormal];
            self.userStatusPoint.backgroundColor = [UIColor redColor];
            self.userStatusBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            break;
    }
    
    if (homeModel.oooVoice.length > 0 && [ProjConfig isContain1v1]) {
        self.playVoice.hidden = NO;
        [self.playVoice playUrl:homeModel.oooVoice time:homeModel.oooVoiceTime];
    }
    
    // 财富值
    self.coinLevelL.text = [NSString stringWithFormat:@"%0.0lf",homeModel.userInfo.consumption];
    [self.coinLevelIconV sd_setImageWithURL:[NSURL URLWithString:homeModel.userInfo.wealthGradeImg]];
    // 魅力值
    self.charmL.text = [NSString stringWithFormat:@"%d",homeModel.userInfo.charmPoint];
    [self.charmIconV sd_setImageWithURL:[NSURL URLWithString:homeModel.userInfo.charmGradeImg]];
    
    
    //星级
    [self.starLevelV removeAllSubViews];
    
    ///用户等级图标
    [self showUserLevelInfo:userInfo svipIcon:homeModel.svipIcon];
    
    for (int i = 0; i < homeModel.starGrade; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*20, 7.5, 15, 15)];
        imageV.image = [UIImage imageNamed:@"icon_userinfo_star"];
        [self.starLevelV addSubview:imageV];
    }
    //昵称 性别 年龄 等级
    CGSize nameSize = [userInfo.username sizeWithAttributes:@{NSFontAttributeName:self.usernameL.font}];
    self.usernameL.width = nameSize.width+5;
    self.usernameL.text = userInfo.username;
    
    _genderL.x = self.usernameL.maxX;
    _genderL.attributedText = [[NSString stringWithFormat:@"%d",userInfo.age] attachmentForImage:[ProjConfig getAPPGenderImage:userInfo.sex hasAge:NO] bounds:CGRectMake(2, -3, 14, 14) before:YES];
    
    self.attentBtn.hidden = [ProjConfig userId]==userInfo.userId?YES:NO;
    self.attentBtn.selected = homeModel.isAttentionUser;
    self.contactBtn.hidden = [ProjConfig userId]==userInfo.userId?YES:NO;
    
    //签名
    self.signatureL.text = userInfo.signature.length > 0?userInfo.signature:kLocalizationMsg(@"这个家伙很懒，什么也没说...");
    
    //一对一
    if ([ProjConfig isContain1v1] && [KLCAppConfig showOtmCoin]) {
        self.voiceCallL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.0f%@/分钟"),userInfo.voiceCoin,[KLCAppConfig unitStr]];
        self.videoCallL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.0f%@/分钟"),userInfo.videoCoin,[KLCAppConfig unitStr]];
    }
    //位置信息
    self.locationL.text = userInfo.city.length>0?userInfo.city:kLocalizationMsg(@"暂无");
    
    ///包含语音和这视频
    if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
        if (userInfo.roomId > 0) {
            self.followBtn.hidden = NO;
        }else{
            self.followBtn.hidden = YES;
        }
    }
    [self setNeedsLayout];
}
//显示用户等级图标
- (void)showUserLevelInfo:(ApiUserInfoModel *)userInfo svipIcon:(NSString *)svipIcon{
    
    [self.levelBgV removeAllSubViews];
    
    CGFloat maxX = 0;
    ///用户等级级别
    NSString *gradeImageStr =  userInfo.userGradeImg;
    if (userInfo.anchorGradeImg.length > 0) {
        gradeImageStr = userInfo.anchorGradeImg;
    }

    if ([[ProjConfig shareInstence].baseConfig showUserLevelImage] && gradeImageStr) {
        UIImageView *levelImageV = [[UIImageView alloc]initWithFrame:CGRectMake(maxX, 0, 30, 15)];
        [levelImageV sd_setImageWithURL:[NSURL URLWithString:gradeImageStr] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [self.levelBgV addSubview:levelImageV];
        maxX = levelImageV.maxX + 5;
    }
    
    ///vip等级
    if (userInfo.nobleGradeImg.length) {
        UIImageView *levelImageV = [[UIImageView alloc]initWithFrame:CGRectMake(maxX, 0, 30, 15)];
        [levelImageV sd_setImageWithURL:[NSURL URLWithString:userInfo.nobleGradeImg] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [self.levelBgV addSubview:levelImageV];
        maxX = levelImageV.maxX + 5;
    }
    ///svip等级
    if (svipIcon.length) {
        UIImageView *levelImageV = [[UIImageView alloc]initWithFrame:CGRectMake(maxX, 0, 30, 15)];
        [levelImageV sd_setImageWithURL:[NSURL URLWithString:svipIcon] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [self.levelBgV addSubview:levelImageV];
        maxX = levelImageV.maxX + 5;
    }
}
#pragma mark - 按钮
//关注
- (void)attentBtnClick:(UIButton *)btn{
    if (!btn.selected) {
        if (self.attenUserBtnClick) {
            self.attenUserBtnClick(YES);
        }
    }else{
        if ([[ProjConfig shareInstence].baseConfig isContainFansGroup]) {
            //粉丝团
            kWeakSelf(self);
            ApiUserInfoModel *userInfo = self.homeModel.userInfo;
            [FansGroupShowView showFansWith:userInfo.userId hasBgColor:YES showUserInfo:^(int64_t userId) {
                if (userId > 0) {
                    [RouteManager routeForName:RN_user_userInfoVC currentC:weakself.superVc parameters:@{@"id":@(userId)}];
                }
            }];
        }
    }
}


//图片点击
- (void)imageTapIndex:(NSInteger)index{
    if (self.picPathStringsArray.count > 0 && (index<self.picPathStringsArray.count)) {
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = index;
        browser.tag = 1110+self.pageControl.currentPage;
        browser.sourceImagesContainerView = self.pageFlowView.scrollView;
        browser.imageCount = self.picPathStringsArray.count;
        browser.delegate = self;
        [browser show];
    }
}

//跟随
- (void)followBtnClick:(UIButton *)followBtn{
    if (self.homeModel.userInfo.roomId > 0) {
        [[CheckRoomPermissions share] joinRoom:self.homeModel.userInfo.roomId liveDataType:self.homeModel.userInfo.liveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            LiveRoomListReqParam *req = [[LiveRoomListReqParam alloc] init];
            req.joinPosition = 9;
            [[CheckRoomPermissions share] joinRoomForModel:joinModel currentVC:[ProjConfig currentVC] otherInfo:req];
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [[CheckRoomPermissions share] showDetail:dtoModel currentVC:[ProjConfig currentVC]];
        } fail:nil];
    }
}


//显示用户的联系方式
- (void)contactBtnClick:(UIButton *)contactBtn {
    [OneLiveCheckContactView showContact:self.homeModel.userInfo.userId hasBgColor:YES];
}


 

#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageNo= scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageControl.currentPage = pageNo;
}
#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    if (index < self.picPathStringsArray.count) {
        NSString *urlStr = [self.picPathStringsArray[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSURL URLWithString:urlStr];
    }
    return nil;
}


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    if (index < self.picPathStringsArray.count) {
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.picPathStringsArray[index]]]];
    }
    return nil;
}


#pragma mark -NewPagedFlowViewDataSource,NewPagedFlowViewDelegate-

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    return self.picPathStringsArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
    }
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.picPathStringsArray[index]] placeholderImage:[UIImage imageNamed:@"icon_userinfo_no_pic"]];
    bannerView.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    bannerView.mainImageView.clipsToBounds = YES;
    return bannerView;
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(flowView.width, flowView.height);
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex{
    [self imageTapIndex:subIndex];
}
#pragma mark - lazy load
- (NewPagedFlowView *)pageFlowView{
    if (!_pageFlowView) {
        _pageFlowView= [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.isFillet = NO;
        _pageFlowView.leftRightMargin = 0;
        _pageFlowView.topBottomMargin = 0;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.backgroundColor = [UIColor clearColor];
    }
    return _pageFlowView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor=[ProjConfig normalColors];
        _pageControl.pageIndicatorTintColor=[UIColor whiteColor];
        self.pageFlowView.pageControl = self.pageControl;
    }
    return _pageControl;
}

- (NSMutableArray *)picPathStringsArray{
    if (!_picPathStringsArray) {
        _picPathStringsArray = [NSMutableArray array];
    }
    return _picPathStringsArray;
}
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth-65, kScreenWidth, self.height-kScreenWidth+65)];
        _contentV.backgroundColor = [UIColor whiteColor];
        _headerInfoPointY = _contentV.y;
    }
    return _contentV;
}
- (UIView *)gradientView{
    if (!_gradientView) {
        _gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth-65-40, kScreenWidth, 40)];
        _gradientView.backgroundColor = [UIColor clearColor];
    }
    return _gradientView;
}

- (UIView *)starLevelV{
    if (!_starLevelV) {
        _starLevelV = [[UIView alloc]initWithFrame:CGRectMake(20, 5, 100, 30)];
        _starLevelV.backgroundColor = [UIColor clearColor];
    }
    return _starLevelV;
}
#pragma mark - 其他
- (void)stopScroll{
    [_pageFlowView stopTimer];
    [_playVoice stopPlay];
}

- (void)startScroll{
    [_pageFlowView startTimer];
}
- (void)dealloc
{
    [_playVoice removeFromSuperview];
    [_pageFlowView stopTimer];
    [_pageFlowView removeFromSuperview];
    _pageFlowView = nil;
}

@end

