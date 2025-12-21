//
//  AnchorCenterViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import "AnchorCenterViewController.h"
#import "AnchorStateSelectedView.h"
#import "AnchorAuthorityStatusTipView.h"

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/StarPriceDOModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/PayCallOneVsOneVOModel.h>
#import <LibProjModel/HttpApiOOOLive.h>

#import <LibProjBase/LibProjBase.h>

#import <LibProjView/AddWishView.h>
#import <LibProjView/FunctionSelectManager.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/CustomBRPickerView.h>

@interface AnchorScrollview : UIScrollView
 
@end

@implementation AnchorScrollview
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;

}
@end

@interface AnchorCenterViewController ()

@property (nonatomic, strong)UILabel *moneyL;
@property (nonatomic, strong)AnchorScrollview *scrollView;
@property (nonatomic, strong)UIView *featureView;
@property (nonatomic, strong)UILabel *voicePriceL;
@property (nonatomic, strong)UILabel *videoPriceL;
@property (nonatomic, strong)UILabel *o2oStatusL;
@property (nonatomic, strong)UITextView *userNameL;
@property (nonatomic, strong)UIButton *avterBtn;

@property (nonatomic, strong)PayCallOneVsOneVOModel *OVOModel;
@property (nonatomic, assign)BOOL  openState;

@property (nonatomic, copy) NSArray *oneTitlesArray;
@property (nonatomic, copy) NSArray *twoTitlesArray;

@end

@implementation AnchorCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAnchorEarningData:2];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _oneTitlesArray = [[ProjConfig shareInstence].businessConfig getAnchorFuncOneArray];
    _twoTitlesArray = [[ProjConfig shareInstence].businessConfig getAnchorFuncTwoArray];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = kLocalizationMsg(@"主播中心");
    self.view.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    
    [self  createUI];
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
}


- (void)createUI{
    CGFloat scale = 225.0/375;
    UIImageView *headerImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*scale)];
    headerImageV.image = [UIImage imageNamed:@"mineCenter_anchor_header"];
    headerImageV.contentMode = UIViewContentModeScaleAspectFill;
    headerImageV.userInteractionEnabled = YES;
    [self.view addSubview:headerImageV];
 
    // 头像
    UIButton *avterBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 76, 76)];
    avterBtn.layer.cornerRadius = 38.0;
    avterBtn.clipsToBounds = YES;
    avterBtn.layer.borderWidth = 1.0;
    avterBtn.centerY = (kScreenWidth*scale+40)/2.0;
    avterBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    avterBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [avterBtn sd_setImageWithURL:[NSURL URLWithString:[KLCUserInfo getUserInfo].avatar] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    [headerImageV addSubview:avterBtn];
    _avterBtn = avterBtn;
    
    UITextView *userNameL = [[UITextView alloc]initWithFrame:CGRectMake(avterBtn.maxX+10, 0, kScreenWidth-115, 25)];
    userNameL.textColor = [UIColor whiteColor];
    userNameL.scrollEnabled = NO;
    userNameL.editable = NO;
    userNameL.selectable = NO;
    userNameL.backgroundColor = [UIColor clearColor];
    userNameL.centerY = avterBtn.centerY;
    userNameL.textAlignment = NSTextAlignmentLeft;
    userNameL.font = [UIFont boldSystemFontOfSize:18];
    userNameL.centerY = self.avterBtn.centerY;
    userNameL.textContainerInset = UIEdgeInsetsZero;
    NSString *username = [KLCUserInfo getUserInfo].username;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:username];
    if ([KLCUserInfo getUserInfo].anchorGradeImg.length > 0) {
        [attri appendAttributedString:[self parserImgContext:[KLCUserInfo getUserInfo].anchorGradeImg]];
        ///设置行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;// 字体的行间距
        NSDictionary *attributes = @{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
            NSForegroundColorAttributeName:[UIColor whiteColor],
            NSParagraphStyleAttributeName:paragraphStyle
        };
        [attri addAttributes:attributes range:NSMakeRange(0, attri.length)];
        userNameL.attributedText = attri;
    }else{
        userNameL.text = username;
    }
    self.userNameL = userNameL;
    [headerImageV addSubview:userNameL];
    
    
    CGFloat height = 30;
    if (self.oneTitlesArray.count > 0) {
        height += 90;
    }
    if (self.twoTitlesArray.count > 0) {
        height += (self.twoTitlesArray.count*60+10);
    }
    if (height < kScreenHeight+30-kSafeAreaBottom-scale*kScreenWidth) {
        height = kScreenHeight+30-kSafeAreaBottom-scale*kScreenWidth;
    }
    
    self.featureView.frame = CGRectMake(0, kScreenWidth*scale-kNavBarHeight-40, kScreenWidth-30, height);
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.featureView];
    
    [self updateScrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, self.featureView.maxY);
     
}
 
- (NSMutableAttributedString *)parserImgContext:(NSString *)url{
    NSMutableAttributedString *itemAttrM = [[NSMutableAttributedString alloc] initWithString:@" "];
    __block NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    kWeakSelf(self);
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            attach.image = image;
            NSRange range = [weakself rangeOfAttachment:attach];
            if (range.location < weakself.userNameL.attributedText.length) {
                [weakself.userNameL.layoutManager invalidateLayoutForCharacterRange:range actualCharacterRange:NULL];
            }
        });
    }];
    attach.bounds = CGRectMake(3, -2.5, 32,15);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
           
    //将图片插入到合适的位置
    [itemAttrM insertAttributedString:attachString atIndex:1];
    return itemAttrM;
}
- (NSRange)rangeOfAttachment:(NSTextAttachment *)attachment {
    __block NSRange ret;
    kWeakSelf(self);
    [self.userNameL.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                      inRange:NSMakeRange(0, weakself.userNameL.attributedText.length)
                                                      options:0
                                                   usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (attachment == value) {
            ret = range;
            *stop = YES;
        }
    }];
    return ret;
}
- (void)updateScrollView{
    CGFloat y = 30.0;
    if (self.oneTitlesArray.count > 0) {
        NSInteger num = self.oneTitlesArray.count;
        if (num > 4) {
            num = 4;
        }
        CGFloat width = 1.0*(kScreenWidth-30)/num;
        NSInteger subN = num-1;
        if (subN == 1) {
            subN = 1;
        }
        CGFloat btnW = 1.0*(kScreenWidth-30-(num-1)*20)/subN;
        for (int i= 0; i < num; i++) {
            NSDictionary *dic = self.oneTitlesArray[i];
            UIView *bview = [[UIView alloc]initWithFrame:CGRectMake(i*width, y, width, 70)];
            [self.featureView addSubview:bview];
            NSString *imageName = dic[@"imageName"];
            NSString *title = dic[@"title"];
            NSInteger item_id = [dic[@"item_id"] integerValue];
            if (item_id == 101 ) {// 提现
                UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, btnW, 40)];
                moneyL.textColor = kRGB_COLOR(@"#A33B7F");
                moneyL.font = [UIFont boldSystemFontOfSize:20];
                moneyL.textAlignment = NSTextAlignmentCenter;
                moneyL.centerX = bview.width/2.0;
                moneyL.text = @"0.0";
                self.moneyL = moneyL;
                [bview addSubview:moneyL];
            }else{
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
                imageV.image = [UIImage imageNamed:imageName];
                imageV.centerX = bview.width/2.0;
                [bview addSubview:imageV];
            }
            UILabel *subTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, btnW, 20)];
            subTitleL.textAlignment = NSTextAlignmentCenter;
            subTitleL.text = title;
            subTitleL.textColor = kRGB_COLOR(@"#333333");
            subTitleL.font = [UIFont systemFontOfSize:15];
            subTitleL.centerX = bview.width/2.0;
            [bview addSubview:subTitleL];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnW, 60)];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.centerX = bview.width/2.0;
            btn.tag = item_id;
            [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bview addSubview:btn];
        }
        y += 100;
    }
    self.featureView.height = y;
    //底部
    if (self.twoTitlesArray.count > 0) {
        [self addFeatureGroupTwoView:y];
    }
}
- (void)addFeatureGroupTwoView:(CGFloat)y{
    CGFloat viewHeight = 50;
    for (int i = 0; i < self.twoTitlesArray.count ; i++) {
        NSDictionary *itemDic = self.twoTitlesArray[i];
        NSString *title = itemDic[@"title"];
        NSString *imageName = itemDic[@"imageName"];
        int tag = [itemDic[@"item_id"] intValue];
        
        ///背景view
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, y+i*50, self.featureView.width, viewHeight)];
        [self.featureView addSubview:bgView];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, (viewHeight-20)/2.0, 20, 20)];
        imageV.image = [UIImage imageNamed:imageName];
        [bgView addSubview:imageV];
        
        CGFloat width = 100;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX+10, 0, width, 20)];
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.centerY = imageV.centerY;
        titleLabel.text = title;
        [bgView addSubview:titleLabel];
        
        if (tag == 200) {//开启状态
 
        }else{
            
            UIImageView *moreImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30-10-12, 0, 12, 12)];
            moreImgV.contentMode = UIViewContentModeScaleAspectFit;
            moreImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
            moreImgV.centerY = titleLabel.centerY;
            [bgView addSubview:moreImgV];
            
            if (tag == 201 || tag == 202 || tag == 203 || tag == 211|| tag == 212 ||  tag == 213 ) {
                UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.maxX, 0, kScreenWidth-30-titleLabel.maxX-30, 20)];
                contentL.centerY = titleLabel.centerY;
                contentL.textAlignment = NSTextAlignmentRight;
                contentL.font = [UIFont systemFontOfSize:14];
                contentL.textColor = kRGB_COLOR(@"#AAAAAA");
                [bgView addSubview:contentL];
                if (tag == 201) {
                    self.voicePriceL = contentL;
                }else if(tag == 202){
                    self.videoPriceL = contentL;
                }else if(tag == 203){
                    self.o2oStatusL = contentL;
                }else if(tag == 211){
                    contentL.text = kLocalizationMsg(@"让跟多人关注你");
                }else if(tag == 212){
                    contentL.text = kLocalizationMsg(@"快速获取粉丝");
                }else if(tag == 213){
                    contentL.text = kLocalizationMsg(@"只限至尊贵族用户");
                }
            }
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 60)];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = tag;
            btn.centerY = titleLabel.centerY;
            [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:btn];
        }
    }
    self.featureView.height = viewHeight*self.twoTitlesArray.count+y+20;
}


#pragma mark - 按钮 及其 操作
- (void)itemBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    switch (btn.tag) {
        case 100://收益明细
        case 101:{//提现
            if ([KLCAppConfig appConfig].incomeCashAuth) {
                [self getAnchorAuthority:^(BOOL success) {
                    if (success) {
                        [weakself pushEarningView];
                    }
                }];
            }else{
                [self pushEarningView];
            }
        }
            break;
        case 102:{//心愿单
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [weakself  showWishListViewTOcurren];
                }
            }];
        }
            break;
        case 201:{//语音接听收费
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [weakself  priceSettingType:2];
                }
            }];
        }
            break;
        case 202:{//视频通话收费
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [weakself  priceSettingType:1];
                }
            }];
        }
            break;
        case 203:{//状态设置
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [AnchorStateSelectedView showAnchorStateSelectedViewWith:self.OVOModel.liveState CallBack:^(BOOL close, int state) {
                        if (!close) {
                            self.OVOModel.liveState = state;
                            [weakself statusSettingNow];
                        }
                    }];
                }
            }];
        }
            break;
        case 204:{//封面设置
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_OBOCallSettingAC  currentC:weakself];
                }
            }];
        }
            break; 
        case 205:{//直播数据
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_LiveBroadcastDataAC  currentC:weakself parameters:@{@"id":@([ProjConfig userId]),@"title":kLocalizationMsg(@"直播数据")}];
                }
            }];
        }
            break;
        case 206:{//粉丝团
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_fansGroupAC currentC:weakself parameters:@{@"id":@([ProjConfig userId]),@"title":kLocalizationMsg(@"粉丝团")}];
                }
            }];
        }
            break;
        case 207:{//个人贡献榜
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_fansContributionAC  currentC:weakself parameters:@{@"id":@([ProjConfig userId]),@"title":kLocalizationMsg(@"贡献榜")}];
                }
            }];
        }
            break;
        case 208:{//我的公会
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    NSString *strUrl = @"/api/guild/toGuildList";
                    [RouteManager routeForName:RN_general_webView currentC:weakself parameters:@{@"url":strUrl}];
                }
            }];
        }
            break;
        case 209:{//付费设置
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_PaymentSetAC currentC:weakself parameters:@{@"id":@([ProjConfig userId])}];
                }
            }];
        }
            break;
        case 210:{//通话记录
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [RouteManager routeForName:RN_activity_otoCallRecord currentC:weakself parameters:@{@"id":@([ProjConfig userId])}];
                }
            }];
        }
            break;
        case 211:{//发布动态
            [FunctionSelectManager pushViewControllerForType:MainFunctionForDynamic];
        }
            break;
        case 212:{//发布短视频
            [FunctionSelectManager pushViewControllerForType:MainFunctionForShortVideo];
        }
            break;
        case 213:{//视频直播
            [FunctionSelectManager pushViewControllerForType:MainFunctionForMPVideo];
        }
            break;
        default:
            break;
    }
   
}

///跳转到收益中心
- (void)pushEarningView{
    NSString *param = [NSString stringWithFormat:@"%@/pub/h5page/index.html#/userRevenue?_token_=%@&_uid_=%lld",[ProjConfig baseUrl],[ProjConfig userToken],[ProjConfig userId]];
    if ([[ProjConfig shareInstence].baseConfig externalWithdrawal]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:param]];
    }else{
        [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":param}];
    }
}

- (void)getAnchorAuthority:(void(^)(BOOL success))callBack{
    if ([KLCUserInfo getRole] == 1) {
        callBack(YES);
    }else{
        [HttpApiUserController getMyAnchor:^(int code, NSString *strMsg, MyAnchorVOModel *model) {
            if (code == 1) {
                if (model.anchorAuditStatus == 0 && model.role > 0) {
                    callBack(YES);
                }else{
                    [self authorityTipShow:model callBack:^(BOOL success) {
                        callBack(success);
                    }];
                }
            }else{
                callBack(NO);
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}


- (BOOL)authUserGenderForPass{
    if ([KLCAppConfig appConfig].adminLiveConfig.authIsSex == 0 && [KLCUserInfo getGender] != 2) {//只允许女性
        //弹框
        CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"温馨提示") message:kLocalizationMsg(@"暂时只支持小姐姐认证哦~") liveType:LiveTypeForCommon];
        customAlert.clickCancelBlock = ^{
        };
        customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:customAlert animated:YES completion:nil];
        });
        return NO;
    }else{
        return YES;
    }
}

- (void)authorityTipShow:(MyAnchorVOModel *)model callBack:(void(^)(BOOL success))callBack{
    
    NSMutableArray *contentArr = [NSMutableArray array];
    NSString *imageStr = @"icon_authority_applay";
    switch(model.anchorAuditStatus) {
        case 0://已经成为主播（通过）
            if (model.role <= 0) {
                NSString *tipStr;
                if ([ProjConfig getAppType] == 4) {
                    tipStr = kLocalizationMsg(@"您当前还没有认证哦～");
                }else{
                    tipStr = kLocalizationMsg(@"您当前还不是主播哦～");
                }
                [contentArr addObject:@{@"text":tipStr,@"type":@1}];
                [contentArr addObject:@{@"text":kLocalizationMsg(@"去认证"),@"type":@2}];
            }else{
                callBack(YES);
            }
            break;
        case 1://审核中
            imageStr = @"icon_authority_review";
            [contentArr addObject:@{@"text":kLocalizationMsg(@"审核中"),@"type":@0}];
            [contentArr addObject:@{@"text":kLocalizationMsg(@"预计1个工作日内审核完成～"),@"type":@1}];
            break;
        case 2://审核失败
            imageStr = @"icon_authority_rejected";
            [contentArr addObject:@{@"text":kLocalizationMsg(@"您的审核未通过"),@"type":@0}];
            [contentArr addObject:@{@"text":model.anchorAuditReason.length>0?model.anchorAuditReason:@"",@"type":@1}];
            [contentArr addObject:@{@"text":kLocalizationMsg(@"重新认证"),@"type":@2}];
            break;
        case -1:{//未申请过主播认证
            NSString *tipStr;
            if ([ProjConfig getAppType] == 4) {
                tipStr = kLocalizationMsg(@"您当前还没有认证哦～");
            }else{
                tipStr = kLocalizationMsg(@"您当前还不是主播哦～");
            }
            [contentArr addObject:@{@"text":tipStr,@"type":@1}];
            [contentArr addObject:@{@"text":kLocalizationMsg(@"去认证"),@"type":@2}];
        }
            break;
        default:
            break;
    }
    kWeakSelf(self);
    if (contentArr.count > 0) {
        [AnchorAuthorityStatusTipView showAnchorAuthStatusTipViewWith:contentArr imageStr:imageStr callBack:^(BOOL isBtnClick,AnchorAuthorityStatusTipView *tipView) {
            if (isBtnClick && [self authUserGenderForPass]) {
                [RouteManager routeForName:RN_center_anchorAuthAC currentC:weakself];
            }
            if (tipView) {
                [tipView removeFromSuperview];
                tipView = nil;
            }
        }];
    }
}

- (void)backBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置心愿单
- (void)showWishListViewTOcurren {
    [AddWishView addMineWishAndRoomId:-1 touid:-1 hasCover:NO Block:^(NSArray<ApiUsersLiveWishModel *> * _Nonnull wishList) {
       // NSLog(@"过滤文字设置心愿单接口"));
    }];
}

//状态设置
- (void)statusSettingNow{
    kWeakSelf(self);
    [HttpApiOOOLive setPayCallOneVsOneStatus:self.OVOModel.liveState callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"修改成功")];
            [weakself getPayCallOneVsOneCfgData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//价格设置
- (void)priceSettingType:(int)type{
    NSMutableArray *stringArr = [NSMutableArray array];
    NSInteger selectedIndex = 0;
    __block NSArray *modelArr = [NSArray array];
    if (type == 1) {
        modelArr = self.OVOModel.videoPriceList;
    }else{
        modelArr = self.OVOModel.voicePriceList;
    }
    for (int i = 0 ; i <  modelArr.count; i++) {
        StarPriceDOModel *model = modelArr[i];
        if (type == 1) {
            if (model.price == self.OVOModel.videoCoin) {
                selectedIndex = i;
            }
        }else{
            if (model.price == self.OVOModel.voiceCoin) {
                selectedIndex = i;
            }
        }
        NSString *nodeStr = [NSString stringWithFormat:kLocalizationMsg(@"%.0f%@/分钟(%.2f元/分钟)"),model.price,[KLCAppConfig unitStr],model.money];
        [stringArr addObject:nodeStr];
    }
     
    CustomStringPickerView *stringPicker = [[CustomStringPickerView alloc] init];
    stringPicker.showTitle = kLocalizationMsg(@"选择价格");
    [stringPicker showStringPicker:@(selectedIndex) stringArr:stringArr];
    stringPicker.doneBlock = ^(BRResultModel * _Nonnull resultModel) {
        if (resultModel.index < modelArr.count) {
            StarPriceDOModel *model = modelArr[resultModel.index];
            if (type == 1) {
                self.OVOModel.videoCoin = model.price;
            }else{
                self.OVOModel.voiceCoin =  model.price;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self priceSettingNow:type selectedPrice:model];
            });
        }
    };
}

 
//open 时单独修改
-(void)priceSettingNow:(int)type selectedPrice:(StarPriceDOModel *)priceModel{
    kWeakSelf(self);
    [SVProgressHUD show];
    [HttpApiOOOLive setPayCallOneVsOnePrice:priceModel.id_field type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"修改成功")];
            [weakself getPayCallOneVsOneCfgData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
- (void)O2OChangeUI{
    self.voicePriceL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.1f%@/分钟"),self.OVOModel.voiceCoin,[KLCAppConfig unitStr]];
    self.videoPriceL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.1f%@/分钟"),self.OVOModel.videoCoin,[KLCAppConfig unitStr]];
    //状态
    UIColor *color ;
    NSString *statusStr;
    if (self.OVOModel.liveState == 0) {//在线
        color = [UIColor greenColor];
        statusStr = kLocalizationMsg(@"● 在线");
    }else if(self.OVOModel.liveState == 1){//忙碌
        color = [UIColor redColor];
        statusStr = kLocalizationMsg(@"● 忙碌");
    }else {//离开
        color = [UIColor grayColor];
        statusStr = kLocalizationMsg(@"● 离开");
    }
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:statusStr];
    [attriStr addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, 1)];
    self.o2oStatusL.attributedText = attriStr;
}

#pragma mark - 获取数据
//获取一对一付费通话设置
-(void)getPayCallOneVsOneCfgData{
    kWeakSelf(self);
    [HttpApiOOOLive getPayCallOneVsOneCfg:^(int code, NSString *strMsg, PayCallOneVsOneVOModel *model) {
        if (code == 1) {
            weakself.OVOModel = model;
            [weakself O2OChangeUI];
        }
    }];
    
}
 
- (void)getAnchorEarningData:(int)type{
    kWeakSelf(self);
    [HttpApiAPPFinance anchorVotes:^(int code, NSString *strMsg, AnchorVotesDTOModel *model) {
        weakself.moneyL.text = [NSString stringWithFormat:@"%.2f",model.anchorVotes];
        if ([ProjConfig isContain1v1]) {
            [weakself getPayCallOneVsOneCfgData];
        }
    }];
}

#pragma mark - 懒加载
- (AnchorScrollview *)scrollView{
    if (!_scrollView) {
        AnchorScrollview * scrollView = [[AnchorScrollview alloc]initWithFrame:CGRectMake(15, kNavBarHeight, kScreenWidth-30, kScreenHeight-30-kSafeAreaBottom-kNavBarHeight)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsVerticalScrollIndicator = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (UIView *)featureView{
    if (!_featureView) {
        CGFloat scale = 225.0/375;
        _featureView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth*scale-30, kScreenWidth-30, 0.1)];
        _featureView.backgroundColor = [UIColor whiteColor];
        _featureView.layer.cornerRadius = 12;
        _featureView.layer.shadowColor = [[ProjConfig normalColors] colorWithAlphaComponent:0.1].CGColor;
        _featureView.layer.shadowOffset = CGSizeMake(2, 2);
        _featureView.layer.shadowOpacity = 0.8;
        _featureView.layer.shadowRadius = 12;
    }
    return _featureView;
}

@end
