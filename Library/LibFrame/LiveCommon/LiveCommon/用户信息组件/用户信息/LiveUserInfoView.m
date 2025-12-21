//
//  LiveUserInfoView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/26.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveUserInfoView.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/GiftWallDtoModel.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/UserInfoLiveVOModel.h>
#import <LibProjModel/KLCUserInfo.h>

#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import "LiveCommonRes.h"

#import <LiveCommon/LiveComponentMsgListener.h>


#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/EmptyView.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjView/SWHTapImageView.h>
@interface LiveUserInfoGiftCell : UICollectionViewCell

@property (nonatomic, weak)UIImageView *giftIcon;
@property (nonatomic, weak)UILabel *giftNumL; ///礼物数

@end

@implementation LiveUserInfoGiftCell

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UIImageView *)giftIcon{
    if (!_giftIcon) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 22.5;
        [self addSubview:icon];
        _giftIcon = icon;
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.center.equalTo(self);
        }];
    }
    return _giftIcon;
}

- (UILabel *)giftNumL{
    if (!_giftNumL) {
        UIView *giftNumBgV = [[UIView alloc] init];
        giftNumBgV.layer.masksToBounds = YES;
        giftNumBgV.layer.cornerRadius = 9;
        giftNumBgV.backgroundColor = [ProjConfig normalColors];
        [self addSubview:giftNumBgV];
        [giftNumBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.giftIcon).mas_offset(3);
            make.top.equalTo(self.giftIcon).mas_offset(-3);
            make.height.mas_equalTo(18);
            make.width.mas_greaterThanOrEqualTo(18);
        }];
        
        UILabel *giftNumL = [[UILabel alloc] init];
        giftNumL.font = [UIFont systemFontOfSize:8];
        giftNumL.textColor = [UIColor whiteColor];
        giftNumL.textAlignment = NSTextAlignmentCenter;
        [giftNumBgV addSubview:giftNumL];
        _giftNumL = giftNumL;
        [giftNumL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(giftNumBgV);
            make.left.equalTo(giftNumBgV).offset(2);
            make.right.equalTo(giftNumBgV).offset(-2);
        }];
    }
    return _giftNumL;
}


@end


@interface LiveUserInfoView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet KlcAvatarView *avatarV; ///用户图标
@property (weak, nonatomic) IBOutlet UILabel *userName;   ///用户明+性别
@property (weak, nonatomic) IBOutlet UILabel *idStr;   ///id数据
@property (weak, nonatomic) IBOutlet UILabel *addressL; ///定位
@property (weak, nonatomic) IBOutlet SWHTapImageView *sexImgV; ///用户性别

///用户等级
@property (weak, nonatomic) IBOutlet UILabel *userLevelTitleL;  ///用户等级标题
@property (weak, nonatomic) IBOutlet UILabel *userLevel;    ///用户等级
@property (weak, nonatomic) IBOutlet UIImageView *userLevelIcon;  ///用户等级图标

///财富等级
@property (weak, nonatomic) IBOutlet UILabel *coinLevel;  ///财富等级
@property (weak, nonatomic) IBOutlet UIImageView *coinLevelIcon;  ///财富等级图标

///贵族等级
@property (weak, nonatomic) IBOutlet UIImageView *vipLevelIcon;  ///贵族等级图标
@property (weak, nonatomic) IBOutlet UILabel *vipLevel;   //vip等级
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;   ///礼物墙
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;  ///右侧功能按钮

@property (weak, nonatomic) IBOutlet UIView *funBgView;  ///功能按钮背景视图

@property (weak, nonatomic) IBOutlet UILabel *fansNumL; ///粉丝数量
@property (weak, nonatomic) IBOutlet UILabel *attentionNumL;  ///关注数
@property (weak, nonatomic) IBOutlet UILabel *buyNumL;  ///消费数
@property (weak, nonatomic) IBOutlet UILabel *earningsNumL;  ///收益数

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftViewHeight;  ///礼物墙的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *functionViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *upMicBtn;  ///上麦按钮

@property (nonatomic, copy)NSArray *giftItems;///礼物墙

@property (nonatomic, assign)int userStatus;    ///用户状态

@property(nonatomic, copy)NSArray *functionArr; ///功能数组

@property (nonatomic, weak)EmptyView* emptyView;

@property (nonatomic, strong)UserInfoLiveVOModel *dtoModel;  ///用户信息

@property (nonatomic, assign)int64_t userId;

@property (nonatomic, assign)BOOL outLiveRoom;

@end

@implementation LiveUserInfoView

- (void)dealloc
{
    _dtoModel = nil;
}

+ (void)showUserInfo:(int64_t)userId outLiveRoom:(BOOL)outLiveRoom{
    [self loadUserInfo:userId resultBlock:^(BOOL success, NSString * _Nullable strMsg, UserInfoLiveVOModel * _Nullable model) {
        NSString *nibName= [LiveCommonRes getNibFullName:@"LiveUserInfoView"];
        //@"Frameworks/LiveCommon.framework/LiveUserInfoView"
        LiveUserInfoView *info = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil].lastObject;
        info.userId = userId;
        info.outLiveRoom = outLiveRoom;
        if (success) {
            [info showUserInfoForData:model];
        }else{
            [info showEmptyView:strMsg];
        }
    }];
}

+ (void)showOtherRoomUserInfo:(int64_t)uid roomId:(int64_t)roomId showId:(NSString *)showId{
    
}

- (EmptyView *)emptyView{
    if (!_emptyView) {
        EmptyView *emptyV = [[EmptyView alloc] init];
        emptyV.frame = self.bounds;
        emptyV.hidden = YES;
        emptyV.detailL.text = kLocalizationMsg(@"我已经尽力～");
        [self addSubview:emptyV];
        _emptyView = emptyV;
    }
    return _emptyView;
}

+ (void)loadUserInfo:(int64_t)uid resultBlock:(void(^)(BOOL success,NSString *_Nullable strMsg,UserInfoLiveVOModel * _Nullable model))block{
    [HttpApiUserController getUserInfoLive:[LiveManager liveInfo].roomId toUserId:uid type:[LiveManager liveInfo].serviceLiveType callback:^(int code, NSString *strMsg, UserInfoLiveVOModel *model) {
        if (block) {
            block((code == 1)?YES:NO, strMsg, model);
        }
    }];
}


- (void)showEmptyView:(NSString *)errorMsg{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.frame = CGRectMake(0, 0,kScreenWidth , 415);
    self.emptyView.hidden = NO;
    self.emptyView.titleL.text = errorMsg;
    [FunctionSheetBaseView showView:self cover:YES];
}


- (void)showUserInfoForData:(UserInfoLiveVOModel *)model{
    
    _dtoModel = model;
    ///上麦按钮隐藏
    _upMicBtn.hidden = YES;
    ApiUserInfoModel *userInfo = model.userInfo;
    
    ///头像
    [_avatarV showUserIconUrl:userInfo.avatar vipBorderUrl:userInfo.nobleAvatarFrame];
    
    _userName.text = userInfo.username;
    
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:userInfo.sex age:userInfo.age role:userInfo.role];
    if (image) {
        _sexImgV.image = image;
    }else{
        [_sexImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    _sexImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:userInfo.role];
    };
     
    
    if (userInfo.goodnum.length>0) { ///有靓号
        _idStr.textColor = kRGB_COLOR(@"#FF5E0D");
        _idStr.attributedText = [userInfo.goodnum attachmentForImage:[UIImage imageNamed:@"live_userinfo_lianghao"] bounds:CGRectMake(0, -2, 24, 13) before:YES];
    }else{
        NSString *showIDStr = [NSString stringWithFormat:@"ID: %lld",userInfo.userId];
        _idStr.text = showIDStr;
        _idStr.textColor = kRGB_COLOR(@"#BBBBBB");
    }

    ///是否显示距离
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
        _addressL.hidden = NO;
        
        NSString *addressStr = userInfo.city.length>0?userInfo.city:kLocalizationMsg(@"暂无");
        _addressL.attributedText = [addressStr attachmentForImage:[UIImage imageNamed:@"live_userinfo_dingwei"] bounds:CGRectMake(0, -2, 14, 14) before:YES];
        
    }else{
        _addressL.hidden = YES;
    }
    
    _fansNumL.text = [NSString stringWithFormat:@"%d",model.fansNum];
    _attentionNumL.text = [NSString stringWithFormat:@"%d",model.followNum];
    _buyNumL.text = model.totalConsumeCoinStr;
    _earningsNumL.text = model.totalIncomeVotesStr;
    
    ///是否显示礼物墙
    _giftViewHeight.constant = 0;
    if ([[ProjConfig shareInstence].baseConfig showUserGiftWall]) {
        _giftViewHeight.constant = 115;
    }
    
    _userLevelTitleL.text = userInfo.role>0?kLocalizationMsg(@"主播等级"):kLocalizationMsg(@"用户等级");
    _userLevel.text = [NSString stringWithFormat:@"%d",userInfo.role>0?userInfo.anchorGrade:userInfo.userGrade];
    _coinLevel.text = [NSString stringWithFormat:@"%d",userInfo.wealthGrade];
    
    if (userInfo.nobleName.length > 0) {
        NSMutableString *muStr = [[NSMutableString alloc] initWithString: userInfo.nobleName];
        if (muStr.length >2 && [muStr hasSuffix:kLocalizationMsg(@"贵族")]) {
            [muStr deleteCharactersInRange:NSMakeRange(muStr.length-2, 2)];
        }
        _vipLevel.text = muStr;
    }else{
        _vipLevel.text =kLocalizationMsg(@"暂无");
    }
    
    //    [_userLevelIcon sd_setImageWithURL:[NSURL URLWithString:model.userGradeImg]];
    //    [_coinLevelIcon sd_setImageWithURL:[NSURL URLWithString:model.wealthGradeImg]];
    //    [_vipLevelIcon sd_setImageWithURL:[NSURL URLWithString:model.nobleGradeImg]];
    
    _userLevelIcon.image = [UIImage imageNamed:@"live_userinfo_dengjilogo"];
    _coinLevelIcon.image = [UIImage imageNamed:@"live_userinfo_caifulogo"];
    _vipLevelIcon.image = [UIImage imageNamed:@"live_userinfo_guizulogo"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[LiveUserInfoGiftCell class] forCellWithReuseIdentifier:@"LiveUserInfoGiftCellIdentifier"];
    _giftItems = model.giftWall;
    [_collectionView reloadData];
    
    if (_giftItems.count == 0) {
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:_collectionView.bounds];
        titleL.width = kScreenWidth-(_collectionView.x*2.0);
        titleL.textColor = [UIColor blackColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.text = kLocalizationMsg(@"TA还没收到礼物哦");
        [_collectionView addSubview:titleL];
        
    }
    
    [self createFunctionView];
    [self setRoleFunctionBtn];
    
    
    CGFloat viewH = 270 + _giftViewHeight.constant + _functionViewHeight.constant;
    self.frame = CGRectMake(0, 0,kScreenWidth , viewH);
    
    [FunctionSheetBaseView showView:self cover:NO];
    
}



/**
 ////用户的功能
 1  举报
 2. 踢出房间
 3. 禁言 //取消禁言
 4. 设置管理员/取消管理员
 */
- (void)setRoleFunctionBtn{
    
    [_rightBtn setImage:[UIImage imageNamed:@"live_userinfo_setIcon"] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"" forState:UIControlStateNormal];
    _rightBtn.hidden = NO;
    BOOL showUpMicBtn = NO;///在语音间是否显示抱麦按钮
    
    if ([ProjConfig userId] == _dtoModel.userInfo.userId) { ///自己信息
        _rightBtn.hidden = YES;
    }else{///其他人
        int userInfoRelation = _dtoModel.toRelation;  ///当前查看用户的身份  1是当前直播间主播 2管理员 3普通用户
        switch (_dtoModel.relation) { ///我自己的身份
            case 1:{ //我就是主播
                if (userInfoRelation ==1) { //主播自己查看自己
                    _rightBtn.hidden = YES;
                }else{ //主播查看管理员 或者用户
                    _functionArr = @[
                        @{@"funcId":@(3),@"title":_dtoModel.isShutUp?kLocalizationMsg(@"解除禁言"):kLocalizationMsg(@"禁言")},
                        @{@"funcId":@(2),@"title":kLocalizationMsg(@"踢出房间")},
                        @{@"funcId":@(4),@"title":(userInfoRelation==2)?kLocalizationMsg(@"删除管理员"):kLocalizationMsg(@"设置管理员")},
                        @{@"funcId":@(11),@"title":kLocalizationMsg(@"举报")},
                        @{@"funcId":@(12),@"title":_dtoModel.isPullBlack?kLocalizationMsg(@"解除拉黑"):kLocalizationMsg(@"拉黑")},
                    ];
                    showUpMicBtn = YES;
                }
            }
                break;
            case 2:{ //我是管理员
                
                if (userInfoRelation == 1) {//我(管理员)查看主播
                    _functionArr = @[
                        @{@"funcId":@(11),@"title":kLocalizationMsg(@"举报")},
                        @{@"funcId":@(12),@"title":_dtoModel.isPullBlack?kLocalizationMsg(@"解除拉黑"):kLocalizationMsg(@"拉黑")},
                    ];
                }else if (userInfoRelation == 2){//我(管理员)查看某个管理员
                    _functionArr = @[
                        @{@"funcId":@(11),@"title":kLocalizationMsg(@"举报")},
                        @{@"funcId":@(12),@"title":_dtoModel.isPullBlack?kLocalizationMsg(@"解除拉黑"):kLocalizationMsg(@"拉黑")},
                    ];
                    showUpMicBtn = YES;
                }else{ //我(管理员)查看某个用户
                    _functionArr = @[
                        @{@"funcId":@(3),@"title":_dtoModel.isShutUp?kLocalizationMsg(@"解除禁言"):kLocalizationMsg(@"禁言")},
                        @{@"funcId":@(2),@"title":kLocalizationMsg(@"踢出房间")},
                        @{@"funcId":@(11),@"title":kLocalizationMsg(@"举报")},
                        @{@"funcId":@(12),@"title":_dtoModel.isPullBlack?kLocalizationMsg(@"解除拉黑"):kLocalizationMsg(@"拉黑")},
                    ];
                    showUpMicBtn = YES;
                }
            }
                break;
            case 3:{//我是普通用户
                _functionArr = @[
                    @{@"funcId":@(11),@"title":kLocalizationMsg(@"举报")},
                    @{@"funcId":@(12),@"title":_dtoModel.isPullBlack?kLocalizationMsg(@"解除拉黑"):kLocalizationMsg(@"拉黑")},
                ];
            }
                break;
            default:
            {
                _rightBtn.hidden = YES;
            }
                break;
        }
    }
    if ([LiveManager liveInfo].liveType == LiveTypeForMPAudioLive && showUpMicBtn == YES) {
        _upMicBtn.hidden = NO;
        ///是否在麦位上（主持位或普通麦位） 0：不在麦位上 1：在麦位上
        NSString *micBtnShowStr = self.dtoModel.inAssistant?kLocalizationMsg(@"让TA下麦"):kLocalizationMsg(@"抱TA上麦");
        [_upMicBtn setTitle:micBtnShowStr forState:UIControlStateNormal];
        _upMicBtn.tag = 88750 + self.dtoModel.inAssistant;
    }
}


- (void)createFunctionView{
    
    BOOL isSelf = NO;
    if (_dtoModel.userInfo.userId == [ProjConfig userId]) {
        isSelf = YES;
    }
    
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    [muArr addObject:@{@"typeId":@(101),@"title":kLocalizationMsg(@"关注")}];
    if (!self.outLiveRoom) {
        [muArr addObject:@{@"typeId":@(102),@"title":@"@TA"}];
        [muArr addObject:@{@"typeId":@(105),@"title":kLocalizationMsg(@"送TA")}];
    }
    [muArr addObject:@{@"typeId":@(103),@"title":kLocalizationMsg(@"私信")}];
    [muArr addObject:@{@"typeId":@(104),@"title":kLocalizationMsg(@"主页")}];
                         
    CGFloat btnH = 45;
    CGFloat btnW = kScreenWidth/(muArr.count*1.0);
    
    _functionViewHeight.constant = btnH;
    
    [_funBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i<muArr.count; i++) {
        NSDictionary *subDic = muArr[i];
        UIButton *funcBtn = [UIButton buttonWithType:0];
        funcBtn.frame = CGRectMake(i*btnW, 1, btnW, btnH);
        funcBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [funcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [funcBtn setTitle:subDic[@"title"] forState:UIControlStateNormal];
        [funcBtn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_funBgView addSubview:funcBtn];
        if ([subDic[@"typeId"] intValue] == 101) {  ///关注
            if (isSelf) {
                [funcBtn setImage:nil forState:UIControlStateNormal];
                [funcBtn setTitle:kLocalizationMsg(@"关注") forState:UIControlStateNormal];
                [funcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                if (_dtoModel.isAttentionUser == 0) {
                    [funcBtn setImage:[UIImage imageNamed:@"live_userinfo_guanzhu"] forState:UIControlStateNormal];
                    [funcBtn setTitle:kLocalizationMsg(@" 关注") forState:UIControlStateNormal];
                    [funcBtn setTitleColor:kRGB_COLOR(@"#A570FE") forState:UIControlStateNormal];
                }else{
                    [funcBtn setImage:nil forState:UIControlStateNormal];
                    [funcBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateNormal];
                    [funcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }else{   ///其他
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-0.4, (btnH - 20)/2.0, 0.8, 20)];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [funcBtn addSubview:line];
        }
        funcBtn.tag = 7756+[subDic[@"typeId"] intValue];
        
        if (isSelf) {
            funcBtn.userInteractionEnabled = NO;
            [funcBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , 0.8)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_funBgView addSubview:line];
}

- (void)funcBtnClick:(UIButton *)btn{
    switch (btn.tag - 7756) {
        case 101:  ///关注
            [self attentionBtnClick:btn];
            break;
        case 102:  ///@TA
            [self atUserBtnClick];
            break;
        case 103:///私信
            [self sixinBtnClick];
            break;
        case 104:///主页
            [self userInfoViewClick];
            break;
        case 105: ///送礼
            [self sendGift];
            break;
        default:
            break;
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _giftItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftWallDtoModel *dtoModel = _giftItems[indexPath.item];
    LiveUserInfoGiftCell *giftCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveUserInfoGiftCellIdentifier" forIndexPath:indexPath];
    [giftCell.giftIcon sd_setImageWithURL:[NSURL URLWithString:dtoModel.gifticon]];
    giftCell.giftNumL.text = [NSString stringWithFormat:@"%d",dtoModel.totalNum];
    giftCell.hidden = dtoModel.totalNum>0?NO:YES;
    return giftCell;
}


///关注按钮
- (void)attentionBtnClick:(UIButton *)btn {
    kWeakSelf(self);
    if (self.dtoModel.isAttentionUser == 1) {
        return;
    }
    [HttpApiUserController setAtten:1 touid:_dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.dtoModel.isAttentionUser = 1;
            [btn setImage:nil forState:UIControlStateNormal];
            [btn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (weakself.dtoModel.toRelation==1){
                [LiveComponentMsgMgr sendMsg:LM_AttentionAnchor msgDic:nil];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///送礼
- (void)sendGift{
    ApiUserInfoModel *userInfo = _dtoModel.userInfo;
    GiftUserModel *model = [[GiftUserModel alloc] init];
    model.userId = userInfo.userId;
    model.userName = userInfo.username;
    model.userIcon = userInfo.avatar;
    model.isAnchor = (_dtoModel.userInfo.userId == [LiveManager liveInfo].anchorId)?YES:NO;
    model.roomId = [LiveManager liveInfo].roomId;
    model.showId = [LiveManager liveInfo].serviceShowId;
    model.anchorId = [LiveManager liveInfo].anchorId;
    [ChoiceGiftView showGift:[LiveManager liveInfo].serviceLiveType users:@[model] hasContinue:YES sendSuccess:nil];
    
    [FunctionSheetBaseView deletePopView:self];
}

///私信按钮
- (void)sixinBtnClick {
   // NSLog(@"过滤文字--------------------私信功能----------------------"));
    kWeakSelf(self);
    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:[ProjConfig currentVC] parameters:@{@"chatType":@"0",@"msgSendId":@(_dtoModel.userInfo.userId)}];
    [FunctionSheetBaseView deletePopView:weakself];
}

///@user 按钮
- (void)atUserBtnClick{
    [LiveComponentMsgMgr sendMsg:LM_SendMessage msgDic:@{@"msg":[NSString stringWithFormat:@"@%@",_dtoModel.userInfo.username]}];
    [FunctionSheetBaseView deletePopView:self];
}

///用户主页按钮
- (void)userInfoViewClick{
    if (_dtoModel.userInfo.userId>0) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:[LiveManager getCurrentVC] parameters:@{@"id":@(_dtoModel.userInfo.userId)}];
        [FunctionSheetBaseView deletePopView:self];
    }
}


///点击抱TA上麦
- (IBAction)upMicBtnClick:(UIButton *)sender {
    kWeakSelf(self);
    if (self.upMicBtn.tag-88750) { ///让他下麦
        [HttpApiHttpVoice kickOutAssistan:[LiveManager liveInfo].roomId userId:_dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
            if (code == 1) {
                [FunctionSheetBaseView deletePopView:weakself];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{ ///抱他上麦
        [HttpApiHttpVoice letUserUpAssitant:_dtoModel.userInfo.userId roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [FunctionSheetBaseView deletePopView:weakself];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}


///设置按钮
- (IBAction)userSetBtnClick:(UIButton *)sender {
    
    if ([_rightBtn.titleLabel.text isEqualToString:kLocalizationMsg(@"举报")] && _functionArr.count < 2 ) {
        [self reportUser];
    }else{
        ///手动更新功能按钮的显示文字
        [self setRoleFunctionBtn];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        for (NSDictionary *subDic in _functionArr) {
            [alertVC addAction:[UIAlertAction actionWithTitle:subDic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                switch ([subDic[@"funcId"] intValue]) {
                        /**
                         11  举报
                         2. 踢出房间
                         3. 禁言 //取消禁言
                         4. 设置管理员/取消管理员
                         */
                    case 11:   ///举报
                    {
                        [self reportUser];
                    }
                        break;
                    case 12:   ///拉黑
                    {
                        [self blackUser];
                    }
                        break;
                    case 2:   //踢出房间
                    {
                        [self kickUser];
                    }
                        break;
                    case 3:    //取消禁言/禁言
                    {
                        [self enableMsg];
                    }
                        break;
                    case 4:  //设置管理员/取消管理员
                    {
                        [self updateAdmin];
                    }
                        break;
                    default:
                        break;
                }
            }]];
        }
        [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];
    }
}



///举报
- (void)reportUser{
    [RouteManager routeForName:RN_base_userReportVC currentC:[LiveManager getCurrentVC] parameters:@{@"id":@(_dtoModel.userInfo.userId)}];
    [FunctionSheetBaseView deletePopView:self];
}

///拉黑
- (void)blackUser{
    kWeakSelf(self);
    [HttpApiUserController usersBlack:_dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.dtoModel.isPullBlack = (weakself.dtoModel.isPullBlack?0:1);
        }
        [SVProgressHUD showInfoWithStatus:strMsg];
    }];
}

///踢人
- (void)kickUser{
    kWeakSelf(self);
    [HttpApiPublicLive addKick:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId touid:self.dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [FunctionSheetBaseView deletePopView:weakself];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///发言//禁言
- (void)enableMsg{
    kWeakSelf(self);
    [HttpApiPublicLive addShutup:[LiveManager liveInfo].anchorId liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId touid:self.dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.dtoModel.isShutUp = (weakself.dtoModel.isShutUp ==1?0:1);
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///取消管理员 ///设置管理员
- (void)updateAdmin{
    kWeakSelf(self);
    if (self.dtoModel.toRelation == 2) {  ///用户身份是管理员就取消管理
        [HttpApiPublicLive cancelLivemanager:[LiveManager liveInfo].serviceLiveType touid:self.dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.dtoModel.toRelation = 3;
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }else{//////用户身份是其他就设置管理
        [HttpApiPublicLive addLivemanager:[LiveManager liveInfo].serviceLiveType userId:self.dtoModel.userInfo.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                weakself.dtoModel.toRelation = 2;
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}



@end
