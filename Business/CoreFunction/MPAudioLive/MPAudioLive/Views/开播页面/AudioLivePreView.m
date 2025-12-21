//
//  AudioLivePreView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "AudioLivePreView.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>

#import <LibProjModel/AppLiveChannelModel.h>
#import <LibProjModel/ApiUsersLiveWishModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/MobManager.h>
#import <LibProjBase/LibProjBase.h>

#import <LiveCommon/MPLivePreInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjModel/OpenAuthDataVOModel.h>
#import <LibProjView/AddWishView.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LibProjView/SkyDriveTool.h>

#import <MPCommon/ChangeRoomTypeView.h>
#import <MPCommon/SelectLiveChannel.h>

#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/AppShareConfigModel.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjView/LocationView.h>


@interface AudioLivePreView ()<MPLivePreInterface,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIButton *userLiveCover;  ///用户直播封面
@property (weak, nonatomic) UILabel *selectChannel;  ///选择频道
@property (weak, nonatomic) UILabel *roomType; ///房间模式
@property (weak, nonatomic) UITextField *textF;  //标题输入框
@property (weak, nonatomic) UILabel *cityL;  ///城市定位
@property (weak, nonatomic) UIImageView *wishIcon;  ///心愿单图标
@property (weak, nonatomic) UILabel *wishL;     ///心愿单文字

@property (nonatomic, assign)CGFloat space; ///距左右的距离
@property (nonatomic, assign)CGFloat iconWidth; ///图标的宽度


@property (nonatomic, weak)UIButton *shareSelectBtn; ///选择的btn
@property (nonatomic, copy)NSDictionary *shareInfo;

///数据保存
@property (nonatomic, assign)int roomTypeID; ///房间类型
@property (nonatomic, copy)NSString *roomTypeVal; ///房间类型的值
@property (nonatomic, assign)int64_t roomChannelID;  ///房间频道
@property (nonatomic, assign)int shareInt;


@property (nonatomic, copy)void (^resultBlock)(BOOL);

//位置
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,assign)double lat;
@property (nonatomic,assign)double lng;

@end


@implementation AudioLivePreView

- (void)showInView:(UIView *)superView openResult:(void (^)(BOOL))resultBlock{
    
    AudioLivePreView *LivePreView = nil;
    for (UIView *subV in superView.subviews) {
        if ([subV isKindOfClass:[AudioLivePreView class]]) {
            LivePreView = (AudioLivePreView *)subV;
        }
    }
    if (!LivePreView) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self createUI];
        self.resultBlock = resultBlock;
        LivePreView = self;
        [superView addSubview:self];
    }
}

///设置心愿单
- (void)setWishView:(NSArray<ApiUsersLiveWishModel *> *)items{
    self.wishL.text = items.count>0?@"":kLocalizationMsg(@"设置心愿单");
    if (items.count>0) {
        NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] init];
        for (int i = 0; i<items.count; i++) {
            if (i < 2) {
                ApiUsersLiveWishModel *model = items[i];
                NSString *title = [NSString stringWithFormat:@"%@*%d",model.giftname,model.num];
                UIImage *imgG = [model.gifticon getImageFromURLStr];
                NSAttributedString *subStr = [title attachmentForImage:imgG bounds:CGRectMake(0, -4, 20, 20) before:YES];
                [muStr appendAttributedString:subStr];
                [muStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
            }
        }
        self.wishL.attributedText = muStr;
    }
}


///美颜按钮点击事件
- (void)changeBackgroundImage {
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_ChangeBackground msgDic:nil];
}

///关闭按钮点击事件
- (void)doClosePreView{
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
}

///选择频道
- (void)selectChannelView{
    [self endEditing:YES];
    kWeakSelf(self);
    [SelectLiveChannel showType:2 selectId:_roomChannelID selectBlock:^(AppLiveChannelModel * _Nonnull channelModel) {
        weakself.roomChannelID = channelModel.id_field;
        weakself.selectChannel.text = channelModel.title;
    }];
}

///选择模式 （普通/计时/付费/密码）
- (void)dochangelivetype{
    [self endEditing:YES];
    kWeakSelf(self);
    [ChangeRoomTypeView selectRoomTypeIsModify:NO roomTypeSelect:^(RoomTypeModel * _Nonnull selectRoomType) {
        weakself.roomType.text = selectRoomType.roomTypeStr;
        weakself.roomTypeID = selectRoomType.roomType;
        weakself.roomTypeVal = selectRoomType.roomTypeValue;
    }];
}
///修改房间公告
- (void)modifyRoomNotice{
    [LiveComponentMsgMgr sendMsg:LM_ChangeNotice msgDic:nil];
}

///设置心愿单
- (void)showWishListViewTOcurren {
    [self endEditing:YES];
    kWeakSelf(self);
    [AddWishView addMineWishAndRoomId:-1 touid:-1 hasCover:NO Block:^(NSArray<ApiUsersLiveWishModel *> * _Nonnull wishList) {
        [weakself setWishView:wishList];
    }];
}

///定位选择
- (void)startLocation {
    [self endEditing:YES];
    LocationView *locationView = [[LocationView alloc]init];
    [LiveComponentMsgMgr sendMsg:LM_PreviewStatus msgDic:@{@"status":@(0)}];
    kWeakSelf(self);
    [locationView showInView:self callBack:^(BOOL cancel, NSString * _Nonnull city, double lat, double lng, NSString * _Nonnull address) {
        [LiveComponentMsgMgr sendMsg:LM_PreviewStatus msgDic:@{@"status":@(1)}];
        weakself.address = address;
        weakself.lat = lat;
        weakself.lng = lng;
        weakself.city = city;
        
        ApiUserInfoModel *userInfo = KLCUserInfo.getUserInfo;
        userInfo.city = city;
        userInfo.address = address;
        [KLCUserInfo setUserInfo:userInfo];
        
        NSString *addressStr = kLocalizationMsg(@"未知");
        if (city.length > 0) {
            addressStr = city;
        }
        if (address.length>0) {
            addressStr = [addressStr stringByAppendingFormat:@"·%@",address];
        }
        weakself.cityL.text = addressStr;
    }];
}

///开始直播按钮
- (void)doMakeLive {
    if (_roomChannelID<1) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择频道类型")];
        return;
    }
    if ([_textF.text stringByTrimmingWhitespace].length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写直播标题")];
        return;
    }
    
    self.userInteractionEnabled = NO;
    
    kWeakSelf(self);
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"加载中")];
    ApiUserInfoModel *userInfo = [KLCUserInfo getUserInfo];
    HttpVoice_openVoiceLive *openVoice = [[HttpVoice_openVoiceLive alloc]init];
    {
        openVoice.city = self.city.length>0?self.city:@"";
        openVoice.addr = self.address.length > 0?self.address:@"";
        openVoice.lat = self.lat>0?self.lat:userInfo.lat;
        openVoice.lng = self.lng>0?self.lng:userInfo.lng;
        openVoice.title = _textF.text.length>0?_textF.text:@"";
        openVoice.roomType = _roomTypeID?_roomTypeID:0;
        openVoice.roomTypeVal = _roomTypeVal.length>0?_roomTypeVal:@"";
        openVoice.channelId = (int)_roomChannelID;
        openVoice.upStatus = 1;
        openVoice.pull = @"";
    }
     
    [HttpApiHttpVoice openVoiceLive:openVoice callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
        weakself.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        switch (code) {
            case 1:
            {
                [weakself removeFromSuperview];
                [LiveManager liveInfo].roomRole = RoomRoleForAudience;
                [LiveManager liveInfo].roomModel = model;
                [weakself share:model.share];
            }
                break;
            default:
                [SVProgressHUD showInfoWithStatus:strMsg];
                break;
        }
        if (weakself.resultBlock) {
            weakself.resultBlock((code == 1)?YES:NO);
        }
    }];
    
}



///分享
- (void)share:(AppShareConfigModel *)configModel{
    if (_shareInfo.count) {
        SSDKPlatformType shareType = [_shareInfo[@"shareType"] intValue];
        [MobManager shareType:shareType title:configModel.shareTitle content:configModel.shareDes image:[ProjConfig getAppIcon] url:configModel.ipaEwm shareResult:^(BOOL success) {
            
        }];
    }
}


#pragma mark - 更换封面 -

///相册选择
- (void)doUploadPicture{
    [self endEditing:YES];
    kWeakSelf(self);
    BOOL isVideo = NO;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:isVideo?1:9 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.allowPickingVideo = isVideo;
    imagePickerVc.allowPickingImage = !isVideo;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.cropRect = CGRectMake(10, (kScreenHeight- kScreenWidth-20)/2.0, kScreenWidth-20, kScreenWidth-20);
    
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [weakself uploadUserIcon:photos.firstObject];
    }];
    
    [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
    
    
}

- (void)uploadUserIcon:(UIImage *)image{
    ///上传
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:1 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself setLiveThumb:image imagePath:imageUrl success:success];
            });
        }
    }];
}


- (void)setLiveThumb:(UIImage *)image imagePath:(NSString *)imagePath success:(BOOL)success{
    
    if (success && imagePath.length>0) {
        UserController_userUpdate *update = [[UserController_userUpdate alloc]init];
        update.liveThumb = imagePath;
        kWeakSelf(self);
        [KLCUserInfo setServiceUserInfo:update complete:^(BOOL success, NSString * _Nonnull msg) {
            [SVProgressHUD dismiss];
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.userLiveCover sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:image];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:msg];
            }
        }];
        
    }else{
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
        
    }
}

- (void)touchView:(UIGestureRecognizer *)tap{
    [self endEditing:YES];
}

#pragma mark - 创建视图 -

- (void)createUI{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    _space = 15;
    _iconWidth = 34;
    
    [self createHeaderView];
    [self createLiveInfoView];
    [self openLiveView];
    
    kWeakSelf(self);
    [AddWishView getMineWishBlock:^(NSArray<ApiUsersLiveWishModel *> * _Nullable wishList) {
        [weakself setWishView:wishList];
    }];
    
    ///基础数据显示
    OpenAuthDataVOModel *openModel =  [LiveManager liveInfo].openData;
    ///开播基本信息
    [_userLiveCover sd_setImageWithURL:[NSURL URLWithString:openModel.thumb] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"live_add_image"]];
    _selectChannel.text = openModel.channelName.length?openModel.channelName:kLocalizationMsg(@"直播频道");
    _roomChannelID = openModel.channelId;
    _textF.text = openModel.title;

    ///房间类型名字
    _roomType.text = openModel.roomTypeName.length?openModel.roomTypeName:kLocalizationMsg(@"房间模式");
    _roomTypeID = openModel.roomType;
    _roomTypeVal = openModel.roomTypeVal;
    
    ///定位
    self.lat = openModel.lat;
    self.lng = openModel.lng;
    self.city = openModel.city;
    self.address = openModel.address;

    if ([self.address isEmpty] && [self.city isEmpty]) {
        ApiUserInfoModel *userInfo = [KLCUserInfo getUserInfo];
        self.lat = userInfo.lat;
        self.lng = userInfo.lng;
        self.address = userInfo.address;
        self.city = userInfo.city;
    }
    
    NSString *addressStr = kLocalizationMsg(@"未知");
    if (self.city.length > 0) {
        addressStr = self.city;
    }
    if (self.address.length>0) {
        addressStr = [addressStr stringByAppendingFormat:@"·%@",self.address];
    }
    _cityL.text = addressStr;
    
}

/// 头部视图
- (void)createHeaderView{
    
    CGFloat btnY = 34+kStatusBarHeight;
    //关播
    UIButton *preCloseBtn = [UIButton buttonWithType:0];
    preCloseBtn.frame = CGRectMake(kScreenWidth-_space-_iconWidth, btnY, _iconWidth, _iconWidth);
    [preCloseBtn setImage:[UIImage imageNamed:@"live_guanbi_white_mini"] forState:0];
    [preCloseBtn.imageView setContentMode:UIViewContentModeCenter];
    [preCloseBtn addTarget:self action:@selector(doClosePreView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preCloseBtn];
    
    //更换背景
    UIButton *changeBgImageBtn = [UIButton buttonWithType:0];
    changeBgImageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [changeBgImageBtn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
    [changeBgImageBtn setTitle:kLocalizationMsg(@"更换背景") forState:UIControlStateNormal];
    [changeBgImageBtn addTarget:self action:@selector(changeBackgroundImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:changeBgImageBtn];
    [changeBgImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_equalTo(_space);
        make.centerY.equalTo(preCloseBtn);
        make.height.mas_equalTo(_iconWidth);
    }];
}

///直播信息view
- (void)createLiveInfoView{
    
    //直播封面图标和文字
    UIButton *preThumbBtn = [UIButton buttonWithType:0];
    preThumbBtn.frame =CGRectMake(_space, 100 + kStatusBarHeight, 80, 80);
    [preThumbBtn addTarget:self action:@selector(doUploadPicture) forControlEvents:UIControlEventTouchUpInside];
    preThumbBtn.layer.masksToBounds = YES;
    preThumbBtn.layer.cornerRadius = 4.0;
    [self addSubview:preThumbBtn];
    _userLiveCover = preThumbBtn;
    
    ///直播标题
    UITextField *liveTitleTextF = [[UITextField alloc]initWithFrame:CGRectMake(preThumbBtn.maxX+10, preThumbBtn.y + 5, kScreenWidth-(_space*2.0) - (preThumbBtn.maxX+15), 20)];
    liveTitleTextF.font = [UIFont systemFontOfSize:16];
    liveTitleTextF.textColor = [UIColor whiteColor];
    liveTitleTextF.backgroundColor = [UIColor clearColor];
    NSAttributedString *placeHolderStr = [[NSAttributedString alloc] initWithString:kLocalizationMsg(@"更高的人气来自一个好的标题呦") attributes:@{NSForegroundColorAttributeName:kRGBA_COLOR(@"#FFFFFF", 0.5)}];
    [liveTitleTextF setAttributedPlaceholder:placeHolderStr];
    [self addSubview:liveTitleTextF];
    liveTitleTextF.returnKeyType = UIReturnKeyDone;
    liveTitleTextF.delegate = self;
    _textF = liveTitleTextF;
    
    ///心愿单
    UIView *wishBgView = [[UIView alloc] initWithFrame:CGRectMake(liveTitleTextF.x, preThumbBtn.maxY-24, liveTitleTextF.width, 24)];
    [self addSubview:wishBgView];
    [self showWishView:wishBgView];
    
    
    ///选择房间类型和房间模式和公告
    UIView *liveTypeBgView = [[UIView alloc] initWithFrame:CGRectMake(_space, preThumbBtn.maxY + 16,  kScreenWidth - (_space*2), 28)];
    [self addSubview:liveTypeBgView];
    [self roomTypeView:liveTypeBgView];
    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
        ///定位
        UIButton *localBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        localBgBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        localBgBtn.layer.cornerRadius = 4;
        localBgBtn.layer.masksToBounds = YES;
        [localBgBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:localBgBtn];
        
        ///定位图标
        UIButton *LocationImageV = [UIButton buttonWithType:UIButtonTypeCustom];
        LocationImageV.frame = CGRectMake(0, 0, _iconWidth, _iconWidth);
        [LocationImageV setImage:[UIImage imageNamed:@"live_audio_addreee"] forState:UIControlStateNormal];
        [LocationImageV setImageEdgeInsets:UIEdgeInsetsMake((_iconWidth-12)/2.0, (_iconWidth-12)/2.0, (_iconWidth-12)/2.0, (_iconWidth-12)/2.0)];
        LocationImageV.userInteractionEnabled = NO;
        [localBgBtn addSubview:LocationImageV];
        
        ///位置
        UILabel *locationLab = [[UILabel alloc]init];
        locationLab.font = [UIFont systemFontOfSize:12];
        locationLab.textColor = [UIColor whiteColor];
        locationLab.text = @" ";
        [localBgBtn addSubview:locationLab];
        _cityL = locationLab;
        
        [localBgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(liveTypeBgView.mas_bottom).mas_offset(16);
            make.left.equalTo(liveTypeBgView.mas_left);
            make.height.mas_equalTo(@(24));
        }];
        
        [locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LocationImageV.mas_right).mas_offset(0.5);
            make.centerY.equalTo(localBgBtn);
            make.right.equalTo(localBgBtn).mas_offset(-14);
        }];
        [localBgBtn layoutIfNeeded];
        LocationImageV.centerY = localBgBtn.height/2.0;
    }

}

///开播按钮和心愿单和三方分享
- (void)openLiveView{
    
    //开播按钮
    UIButton *startLiveBtn = [UIButton buttonWithType:0];
    startLiveBtn.frame = CGRectMake((kScreenWidth-300.0)/2.0, self.height-40-70-kSafeAreaBottom, 300.0, 40);
    startLiveBtn.layer.cornerRadius = 20.0;
    startLiveBtn.layer.masksToBounds = YES;
    [startLiveBtn setBackgroundColor:[kRGB_COLOR(@"#FFFFFF") colorWithAlphaComponent:0.2]];
    startLiveBtn.layer.borderColor = kRGB_COLOR(@"#FFFFFF").CGColor;
    startLiveBtn.layer.borderWidth = 1.0;
    [startLiveBtn addTarget:self action:@selector(doMakeLive) forControlEvents:UIControlEventTouchUpInside];
    [startLiveBtn setTitle:kLocalizationMsg(@"开始直播") forState:0];
    [startLiveBtn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
    startLiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:startLiveBtn];
    
    ///主播协议
    NSString *showText = kLocalizationMsg(@"开播默认已阅读并同意《主播协议》");
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSRange range = [showText rangeOfString:@"《"];
    [muStr addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]}  range:NSMakeRange(range.location, showText.length-range.location)];
    UILabel *agreementL = [[UILabel alloc] init];
    agreementL.font = [UIFont systemFontOfSize:10];
    agreementL.textColor = [UIColor whiteColor];
    [self addSubview:agreementL];
    [agreementL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startLiveBtn.mas_bottom).mas_offset(10);
        make.centerX.equalTo(startLiveBtn);
    }];
    agreementL.attributedText = muStr;
    [agreementL yb_addAttributeTapActionWithStrings:@[kLocalizationMsg(@"《主播协议》"),] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        [RouteManager routeForName:RN_center_setting_anchorProtocol currentC:[LiveManager getCurrentVC]];
    }];
    
    ///三方分享
    UIView *thirdBgView = [[UIView alloc] initWithFrame:CGRectMake(0, startLiveBtn.y-_iconWidth-30, 1, _iconWidth)];
    [self addSubview:thirdBgView];
    [self getShareThird:thirdBgView];
    
}


- (void)showWishView:(UIView *)superView{
    ///心愿单
    UIButton *wishBgView = [UIButton buttonWithType:0];
    wishBgView.layer.masksToBounds = YES;
    wishBgView.layer.cornerRadius = 4.0;
    [wishBgView addTarget:self action:@selector(showWishListViewTOcurren) forControlEvents:UIControlEventTouchUpInside];
    wishBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [superView addSubview:wishBgView];
    ///icon-文字
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"add_wish_xinyuandan"];
    [wishBgView addSubview:iconImg];
    _wishIcon = iconImg;
    ///心愿单-文字
    UILabel *wishL = [[UILabel alloc] init];
    wishL.text =kLocalizationMsg(@"添加心愿单");
    wishL.textColor = [UIColor whiteColor];
    wishL.font = [UIFont systemFontOfSize:12];
    [wishBgView addSubview:wishL];
    _wishL = wishL;
    
    [wishBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.top.equalTo(superView);
    }];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.equalTo(wishBgView);
        make.right.equalTo(wishL.mas_left).mas_offset(-4);
        make.left.equalTo(wishBgView).mas_offset(8);
    }];
    [wishL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconImg);
        make.right.equalTo(wishBgView).mas_offset(-10);
    }];
}



///设置房间类型和频道类型
- (void)roomTypeView:(UIView *)superView{
    ///选择频道
    UIButton *channelBgView = [UIButton buttonWithType:0];
    channelBgView.layer.masksToBounds = YES;
    channelBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [channelBgView addTarget:self action:@selector(selectChannelView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:channelBgView];
    ///选择频道-文字
    UILabel *channelL = [[UILabel alloc] init];
    channelL.text =kLocalizationMsg(@"直播频道");
    channelL.textColor = [UIColor whiteColor];
    channelL.font = [UIFont systemFontOfSize:12];
    [channelBgView addSubview:channelL];
    _selectChannel = channelL;
    ///选择频道-箭头
    UIImageView *channelArrowImg = [[UIImageView alloc] init];
    channelArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    channelArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [channelBgView addSubview:channelArrowImg];
    
    ///房间模式
    UIButton *liveTypeBgView = [UIButton buttonWithType:0];
    liveTypeBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    liveTypeBgView.layer.masksToBounds = YES;
    [liveTypeBgView addTarget:self action:@selector(dochangelivetype) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:liveTypeBgView];
    ///房间模式-文字
    UILabel *typeL = [[UILabel alloc] init];
    typeL.text =kLocalizationMsg(@"房间模式");
    typeL.textColor = [UIColor whiteColor];
    typeL.font = [UIFont systemFontOfSize:12];
    [liveTypeBgView addSubview:typeL];
    _roomType = typeL;
    ///房间模式-箭头
    UIImageView *typeArrowImg = [[UIImageView alloc] init];
    typeArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    typeArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [liveTypeBgView addSubview:typeArrowImg];
    
    
    ///公告
    UIButton *noticeBgView = [UIButton buttonWithType:0];
    noticeBgView.layer.masksToBounds = YES;
    noticeBgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [noticeBgView addTarget:self action:@selector(modifyRoomNotice) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:noticeBgView];
    ///房间模式-文字
    UILabel *noticeL = [[UILabel alloc] init];
    noticeL.text =kLocalizationMsg(@"公告");
    noticeL.textColor = [UIColor whiteColor];
    noticeL.font = [UIFont systemFontOfSize:12];
    [noticeBgView addSubview:noticeL];
    
    ///房间模式-箭头
    UIImageView *noticeArrowImg = [[UIImageView alloc] init];
    noticeArrowImg.image = [UIImage imageNamed:@"right_jiantou_white"];
    noticeArrowImg.contentMode = UIViewContentModeScaleAspectFit;
    [noticeBgView addSubview:noticeArrowImg];
    
    ///频道
    [channelBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(superView);
        make.right.equalTo(liveTypeBgView.mas_left).mas_offset(-12);
    }];
    [channelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(channelBgView);
        make.left.equalTo(channelBgView).mas_offset(9);
        make.right.equalTo(channelArrowImg.mas_left).mas_offset(-5);
    }];
    [channelArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(channelBgView).mas_offset(-9);
        make.centerY.equalTo(channelL);
    }];
    
    ///房间模式
    [liveTypeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(superView);
        make.right.equalTo(noticeBgView.mas_left).mas_offset(-12);
    }];
    [typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(liveTypeBgView);
        make.left.equalTo(liveTypeBgView).mas_offset(9);
        make.right.equalTo(typeArrowImg.mas_left).mas_offset(-5);
    }];
    [typeArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(liveTypeBgView).mas_offset(-9);
        make.centerY.equalTo(typeL);
    }];
    
    ///公告
    [noticeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(superView);
    }];
    [noticeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(noticeBgView);
        make.left.equalTo(noticeBgView).mas_offset(9);
        make.right.equalTo(noticeArrowImg.mas_left).mas_offset(-5);
    }];
    [noticeArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.right.equalTo(noticeBgView).mas_offset(-9);
        make.centerY.equalTo(noticeL);
    }];
    
    
    [channelBgView layoutIfNeeded];
    channelBgView.layer.cornerRadius = channelBgView.height/2.0;
    
    [liveTypeBgView layoutIfNeeded];
    liveTypeBgView.layer.cornerRadius = liveTypeBgView.height/2.0;
    
    [noticeBgView layoutIfNeeded];
    noticeBgView.layer.cornerRadius = noticeBgView.height/2.0;
}



//获取三方分享方式
-(void)getShareThird:(UIView *)superView{
    
    NSArray *platformsarray = [KLCAppConfig shareArray];
    superView.hidden = platformsarray.count?NO:YES;
    if (platformsarray.count == 0) {
        return;
    }
    [superView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //注意：此处涉及到精密计算，请勿随意改动
    CGFloat w = _iconWidth;
    CGFloat space = 20;
    
    CGRect rc = superView.frame;
    rc.size.width = w*platformsarray.count+space*(platformsarray.count-1);
    rc.origin.x = (self.frame.size.width-rc.size.width)/2.0;
    superView.frame = rc;
    
    //1QQ2qq空间3微信4微信朋友圈
    for (int i=0; i<platformsarray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake((w+space)*i,0,w,w);
        NSDictionary *sharePlatform = platformsarray[i];
        switch ([sharePlatform[@"id"] intValue]) {
            case 1:
            {
                [btn setImage:[UIImage imageNamed:@"live_sharenol_qq"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"live_sharesel_qq"] forState:UIControlStateSelected];
            }
                break;
            case 2:
            {
                [btn setImage:[UIImage imageNamed:@"live_sharenol_kongjian"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"live_sharesel_kongjian"] forState:UIControlStateSelected];
            }
                break;
            case 3:
            {
                [btn setImage:[UIImage imageNamed:@"live_sharenol_weixin"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"live_sharesel_weixin"] forState:UIControlStateSelected];
            }
                break;
            case 4:
            {
                [btn setImage:[UIImage imageNamed:@"live_sharenol_pengyouquan"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"live_sharesel_pengyouquan"] forState:UIControlStateSelected];
            }
                break;
            default:
                break;
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:0];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
        kWeakSelf(self);
        [btn klc_whenTapped:^{
            weakself.shareSelectBtn.selected = NO;
            weakself.shareSelectBtn = btn;
            weakself.shareSelectBtn.selected = YES;
            weakself.shareInfo = sharePlatform;
        }];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [superView addSubview:btn];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}
#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isMemberOfClass:[UIButton class]]) {
        return NO;
    }else if ([NSStringFromClass([touch.view class]) isEqual:@"UITableViewCellContentView"]){
        return NO;
    }else{
        return YES;
    }
    
}
@end
