//
//  MPVideoPreView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "MPVideoPreView.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLoginSwitchModel.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>

#import <LibProjModel/HttpApiUserController.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/MobManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/MPLivePreInterface.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <TZImagePickerController/TZImagePickerController.h>

#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>
#import <LibProjView/SkyDriveTool.h>
#import <LibProjView/LocationView.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/AppShareConfigModel.h>
#import <LiveCommon/LiveManager.h>
#import <MPCommon/ChangeRoomTypeView.h>
#import <LiveCommon/MPLiveInterface.h>
#import <LibProjModel/OpenAuthDataVOModel.h>

#import "MPVideoPreInfoView.h"
#import <AgoraExtension/AgoraExtManager.h>

@interface MPVideoPreView ()<MPLivePreInterface, UITextViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign)CGFloat space; ///距左右的距离
@property (nonatomic, assign)CGFloat iconWidth; ///图标的宽度


@property (nonatomic, weak)UIButton *shareSelectBtn; ///选择的btn
@property (nonatomic, copy)NSDictionary *shareInfo;

@property (nonatomic, weak)UIScrollView *contentV; ///内容视图
///数据保存
@property (nonatomic, assign)int isOpenLiveShopping;///是否开启直播购物
@property (nonatomic, assign)int shareInt;

@property (nonatomic, copy)void (^resultBlock)(BOOL);

///多人视频info
@property (nonatomic, weak)MPVideoPreInfoView *mpInfo;


//位置
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,assign)double lat;
@property (nonatomic,assign)double lng;


@end


@implementation MPVideoPreView

- (void)showInView:(UIView *)superView openResult:(void (^)(BOOL))resultBlock{
    
    MPVideoPreView *LivePreView = nil;
    for (UIView *subV in superView.subviews) {
        if ([subV isKindOfClass:[MPVideoPreView class]]) {
            LivePreView = (MPVideoPreView *)subV;
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


///美颜按钮点击事件
- (void)changeBackgroundImage {
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_ChangeBackground msgDic:nil];
}


///美颜按钮点击事件
- (void)showFitterView {
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_BeautyShow msgDic:nil];
}

///旋转摄像头
- (void)rotateCamera {
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_RotateCamera msgDic:nil];
}

///关闭按钮点击事件
- (void)doClosePreView{
    [self endEditing:YES];
    [LiveComponentMsgMgr sendMsg:LM_ExitRoom msgDic:nil];
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
        
        NSString *addressStr = kLocalizationMsg(@"未知");
        if (city.length > 0) {
            addressStr = city;
        }
        if (address.length>0) {
            addressStr = [addressStr stringByAppendingFormat:@"·%@",address];
        }
        weakself.mpInfo.cityL.text = addressStr;
    }];
}

///开始直播按钮
- (void)doMakeLive {

    NSString *titleStr = self.mpInfo.textV.text; ///直播标题
    int channelId  = (int)self.mpInfo.roomChannelID; /// ///房间频道ID
    int roomTypeID = self.mpInfo.roomTypeID;  //////房间类型Id
    NSString *roomTypeVal = self.mpInfo.roomTypeVal;  ///房间类型值
    NSString *shopRoomLabel = @"";  ///房间标签(直播购用其他不用传)

    if (channelId == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择频道类型")];
        return;
    }

    if ([titleStr stringByTrimmingWhitespace].length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写直播标题")];
        return;
    }

    self.userInteractionEnabled = NO;
    
    kWeakSelf(self);
    // 房间类型
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"加载中")];
    
    NSString *city = self.city.length>0?self.city:@"";
    double lat = self.lat;
    double lng = self.lng;
    NSString *address = self.address.length > 0?self.address:@"";
    NSString *province = @"";
    titleStr = titleStr.length>0?titleStr:@"";
    roomTypeID = roomTypeID?roomTypeID:0;
    roomTypeVal = roomTypeVal.length>0?roomTypeVal:@"";
    NSString *pull = [AgoraExtManager mpVideo].pullStr;

    [HttpApiHttpLive openLive:address channelId:channelId city:city lat:lat liveFunction:self.isOpenLiveShopping lng:lng province:province pull:pull roomType:roomTypeID roomTypeVal:roomTypeVal shopRoomLabel:shopRoomLabel title:titleStr callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
        weakself.userInteractionEnabled = YES;
        [SVProgressHUD dismiss];
        switch (code) {
            case 1:
            {                
                [weakself removeFromSuperview];
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
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    
    imagePickerVc.cropRect = CGRectMake(10, (kScreenHeight- kScreenWidth-20)/2.0, kScreenWidth-20, kScreenWidth-20);
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakself uploadUserIcon:photos.firstObject];
    }];
    [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)uploadUserIcon:(UIImage *)image{
    ///上传
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
   __block UIImage *uploadImage = [UIImage imageWithData:[image compressWithMaxLength:200*1024]];
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:1 image:uploadImage complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself setLiveThumb:uploadImage imagePath:imageUrl success:success];
            });
        }else{
            [SVProgressHUD dismiss];
        }
    }];
}


- (void)setLiveThumb:(UIImage *)image imagePath:(NSString *)imagePath success:(BOOL)success{
    
    if (success && imagePath.length>0) {
        kWeakSelf(self);
        UserController_userUpdate *update = [[UserController_userUpdate alloc] init];
        update.liveThumb = imagePath;
        [KLCUserInfo setServiceUserInfo:update complete:^(BOOL success, NSString * _Nonnull msg) {
            [SVProgressHUD dismiss];
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.mpInfo.userLiveCover sd_setImageWithURL:[NSURL URLWithString:imagePath] forState:UIControlStateNormal placeholderImage:image];
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
    
    _space = 12;
    _iconWidth = 34;
    
    [self createHeaderView];
    [self createLiveInfoView];
    [self openLiveView];
    
    ///基础数据显示
    OpenAuthDataVOModel *openModel =  [LiveManager liveInfo].openData;
    ///开播基本信息
    [self.mpInfo.userLiveCover sd_setImageWithURL:[NSURL URLWithString:openModel.thumb] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"live_add_image"]];
    self.mpInfo.selectChannel.text = openModel.channelName.length?openModel.channelName:kLocalizationMsg(@"直播频道");
    self.mpInfo.roomChannelID = openModel.channelId;
    self.mpInfo.textV.text = openModel.title;
    
    ///房间类型名字
    self.mpInfo.roomType.text = openModel.roomTypeName.length?openModel.roomTypeName:kLocalizationMsg(@"房间模式");
    self.mpInfo.roomTypeID = openModel.roomType;
    self.mpInfo.roomTypeVal = openModel.roomTypeVal;
    
    ///定位
    self.lat = openModel.lat;
    self.lng = openModel.lng;
    self.address = openModel.address;
    self.city = openModel.city;
    
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
    self.mpInfo.cityL.text = addressStr;
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
    
    //美颜
    UIButton *preFitterBtn = [UIButton buttonWithType:0];
    preFitterBtn.frame = CGRectMake(_space, btnY, preCloseBtn.width, preCloseBtn.width);
    [preFitterBtn setImage:[UIImage imageNamed:@"live_pre_fitter"] forState:0];
    preFitterBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [preFitterBtn addTarget:self action:@selector(showFitterView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:preFitterBtn];
    
    //翻转转镜头
    UIButton *switchBtn = [UIButton buttonWithType:0];
    switchBtn.frame = CGRectMake(preFitterBtn.maxX+20, preFitterBtn.y , preCloseBtn.height,  preCloseBtn.height);
    [switchBtn setImage:[UIImage imageNamed:@"live_pre_fanzhuanjingtou"] forState:0];
    [switchBtn addTarget:self action:@selector(rotateCamera) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:switchBtn];
    
}


///直播信息view
//直播封面图标和文字
- (void)createLiveInfoView{
    
    ///具体内容
    UIScrollView *contentScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(_space, 135+kStatusBarHeight, kScreenWidth-(_space*2), 300)];
    contentScroll.contentSize = CGSizeMake(contentScroll.width*1.0, 0);
    contentScroll.pagingEnabled = YES;
    contentScroll.scrollEnabled = NO;
    contentScroll.bounces = NO;
    [self addSubview:contentScroll];
    _contentV = contentScroll;
    
    ///视频直播
    kWeakSelf(self);
    MPVideoPreInfoView *mpInfo = [[MPVideoPreInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-(_space*2), contentScroll.height)];
    [contentScroll addSubview:mpInfo];
    [mpInfo clickActionBlock:^(int type) {
        switch (type) {
            case 1: ///定位
            {
                [weakself startLocation];
            }
                break;
            case 2:  ///上传封面
            {
                [weakself doUploadPicture];
            }
                break;
            default:
                break;
        }
    }];
    [mpInfo shoppingBtnSelectedBlock:^(BOOL selected) {
        weakself.isOpenLiveShopping = selected ? 1:0;
    }];
    _mpInfo = mpInfo;
}



///开播按钮和心愿单和三方分享
- (void)openLiveView{
    
    //开播按钮
    UIButton *startLiveBtn = [UIButton buttonWithType:0];
    [startLiveBtn setBackgroundImage:[UIImage imageNamed:@"live_btn_purple"] forState:UIControlStateNormal];
    startLiveBtn.frame = CGRectMake((kScreenWidth-300.0)/2.0, self.height-40-70-kSafeAreaBottom, 300.0, 40);
    startLiveBtn.layer.cornerRadius = 20.0;
    startLiveBtn.layer.masksToBounds = YES;
    [startLiveBtn addTarget:self action:@selector(doMakeLive) forControlEvents:UIControlEventTouchUpInside];
    [startLiveBtn setTitle:kLocalizationMsg(@"开始直播") forState:0];
    [startLiveBtn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateNormal];
    startLiveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:startLiveBtn];
    
    ///主播协议
    NSString *purpuleStr = kLocalizationMsg(@"《主播协议》");
    NSString *showText = [NSString stringWithFormat:kLocalizationMsg(@"开播默认已阅读并同意%@"),purpuleStr];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showText];
    NSRange range = [showText rangeOfString:purpuleStr];
    [muStr addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors]} range:range];
    UILabel *agreementL = [[UILabel alloc] init];
    agreementL.font = [UIFont systemFontOfSize:10];
    agreementL.textColor = [UIColor whiteColor];
    [self addSubview:agreementL];
    [agreementL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startLiveBtn.mas_bottom).mas_offset(10);
        make.centerX.equalTo(startLiveBtn);
    }];
    agreementL.attributedText = muStr;
    [agreementL yb_addAttributeTapActionWithStrings:@[purpuleStr,] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        [RouteManager routeForName:RN_center_setting_anchorProtocol currentC:[LiveManager getCurrentVC]];
    }];
    
    ///三方分享
    UIView *thirdBgView = [[UIView alloc] initWithFrame:CGRectMake(0, startLiveBtn.y-_iconWidth-20, 1, _iconWidth)];
    [self addSubview:thirdBgView];
    [self getShareThird:thirdBgView];
    
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

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[self class]] || [touch.view isKindOfClass:[UIScrollView class]]) {
        return YES;
    }else{
        return NO;
    }
}


@end
