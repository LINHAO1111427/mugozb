//
//  MineCenterViewController.m
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import "MineCenterViewController.h"
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjView/SignToastView.h>
#import "LibProjView/ForceAlertController.h"
#import <LibProjView/MineHeaderView.h>
#import <LibProjView/MineCneterMiddleView.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjView/LookeMeTipView.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ApiUserInfoMyHeadModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/ShopOrderNumDTOModel.h>
#import <LibProjModel/CustomerServiceSettingModel.h>

@interface HistBackImageView : UIImageView

@end
@implementation HistBackImageView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

@end

@interface MineCenterViewController ()<MineHeaderViewDelegate>

@property(nonatomic,strong)ApiUserInfoMyHeadModel *mineCenterModel;

@property(nonatomic,strong)MineHeaderView *headerView;
@property(nonatomic,strong)MineCneterMiddleView *groupOneV;
@property(nonatomic,strong)UIView *groupTwoV;

@property(nonatomic,strong)UIView *signView;
@property(nonatomic,strong)UIView *redSignPoint; //连续7天签到

@property (nonatomic, strong)UILabel *shopRedL;//购物订单未完成数目
@property (nonatomic, strong)UILabel *storeRedL;//官方小店未发货数目
@property (nonatomic, strong)UILabel *youthLab; //青少年模式是否开启
@property (nonatomic, strong)UILabel *svipL;//svip

@property(nonatomic,strong)HistBackImageView *pubulishV;//发布
@property(nonatomic, copy)NSArray *oneTitleArray;//按钮群1
@property(nonatomic, copy)NSArray *twoTitleArray;//按钮群2

@property(nonatomic,strong)UIScrollView *bgScrollV;
@property(nonatomic,strong)UISwitch *notDisturbSwitch;//免打扰开关

@end

@implementation MineCenterViewController
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc] init];
}
#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _youthLab.hidden = (KLCUserInfo.getUserInfo.isYouthModel == 1)?NO:YES;
    
    [self loadData:YES];
    
    if ([ProjConfig isContainShopping]) {//包含购物订单
        [self getOrderNum];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _oneTitleArray = [[ProjConfig shareInstence].businessConfig getMineCenterFuncOneArray];
    _twoTitleArray = [[ProjConfig shareInstence].businessConfig getMineCenterFuncTwoArray];
    
    [self createUI];
}
#pragma mark - 获取数据
- (void)getSignData{
    kWeakSelf(self);
    [SignToastView getUserIsSign:^(BOOL isSignIn) {
        weakself.redSignPoint.hidden = isSignIn;
    }];
}

- (void)loadData:(BOOL)isRefresh{
    kWeakSelf(self);
    [HttpApiUserController getMyHeadInfo:^(int code, NSString *strMsg, ApiUserInfoMyHeadModel *model) {
        if (code  == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.mineCenterModel = model;
                weakself.notDisturbSwitch.on = model.userInfo.isNotDisturb;
                weakself.headerView.userModel = model;
                [KLCUserInfo setUserInfo:model.userInfo];
                [weakself getLookRedData];//谁看过我红点数据
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakself.svipL.hidden = model.svipExpireDay > 0?NO:YES;
                    NSString *days = [NSString stringWithFormat:kLocalizationMsg(@"%d天"),model.svipExpireDay];
                    NSString *str = [NSString stringWithFormat:kLocalizationMsg(@"剩余%@到期"),days];
                    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
                    [attr addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#DC1478")} range:[str rangeOfString:days]];
                    weakself.svipL.attributedText = attr;
                });
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

//获取订单数据
- (void)getOrderNum{
    kWeakSelf(self);
    [HttpApiShopOrder getOrderNum:1 callback:^(int code, NSString *strMsg, ShopOrderNumDTOModel *model) {
        if (code == 1) {
            if (model.toBePayNum > 0 || model.toBeDeliveredNum > 0 || model.toBeReceivedNum > 0|| model.cancelGoodsNum >0) {
                NSString *str = [NSString stringWithFormat:@"%d",model.toBePayNum + model.toBeDeliveredNum + model.toBeReceivedNum+model.cancelGoodsNum];
                CGSize size = [str boundingRectWithSize:CGSizeMake(60, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
                CGFloat width = 20;
                if (size.width+10 > 20) {
                    width = size.width+10;
                }
                weakself.shopRedL.text = str;
                weakself.shopRedL.width = width;
                weakself.shopRedL.x = kScreenWidth-24-30-10-width;
            }
            [weakself getBussinessOrderNum];//获取未发货商品数目
            weakself.shopRedL.hidden = !(model.toBePayNum + model.toBeDeliveredNum + model.toBeReceivedNum+model.cancelGoodsNum);
        }else{
            weakself.shopRedL.hidden = YES;
        }
    }];
}

- (void)getBussinessOrderNum{
    kWeakSelf(self);
    [HttpApiShopOrder getOrderNum:2 callback:^(int code, NSString *strMsg, ShopOrderNumDTOModel *model) {
        if (code == 1) {
            NSString *str = [NSString stringWithFormat:@"%d",model.toBeDeliveredNum+model.cancelGoodsNum];
            CGSize size = [str boundingRectWithSize:CGSizeMake(60, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
            CGFloat width = 20;
            if (size.width+10 > 20) {
                width = size.width+10;
            }
            weakself.storeRedL.text = str;
            weakself.storeRedL.width = width;
            weakself.storeRedL.x = kScreenWidth-24-30-10-width;
            weakself.storeRedL.hidden = !(model.toBeDeliveredNum+model.cancelGoodsNum);
        }else{
            weakself.storeRedL.hidden = YES;
        }
    }];
    
}


- (void)getLookRedData{
    if ([ProjConfig isUserLogin]) {
        [HttpApiUserController isVisit:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                self.headerView.show_lookRedPoint = model.no_use;
            }
        }];
    }
}

#pragma mark - 按钮
- (void)minePublishBtnClick:(UIButton *)btn{
    [ProjConfig showSuspenPublish];
}
- (void)disturbSwitch:(UISwitch *)mySwitch{
    kWeakSelf(self);
    [HttpApiUserController isNotDisturb:mySwitch.on callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (code == 1) {
                weakself.notDisturbSwitch.on = mySwitch.on;
                if (mySwitch.on) {
                    CustomPopUpAlert *customAlert = [CustomPopUpAlert alertTitle:kLocalizationMsg(@"你已经开启免打扰模式") message:kLocalizationMsg(@"将暂时收不到通话提醒哦~") liveType:LiveTypeForCommon];
                    customAlert.clickCancelBlock = ^{
                        
                    };
                    customAlert.clickSureBlock = ^(NSString * _Nonnull passwordStr) {
                        
                    };
                    [self presentViewController:customAlert animated:YES completion:nil];
                }
            }else{
                weakself.notDisturbSwitch.on = !mySwitch.on;
            }
        });
    }];
}

- (void)signBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [SignToastView showSignViewWithComplition:^(BOOL isSignIn) {
        if (isSignIn) weakself.redSignPoint.hidden = isSignIn;
    }];
}


- (void)itemBtnClick:(UIButton *)btn{
    NSString *title = btn.titleLabel.text;
    if (!title) {
        title = @"";
    }
    [self showFunction:title type:btn.tag];
}

- (void)showFunction:(NSString *)title type:(NSInteger)type{
    kWeakSelf(self);
    switch (type) {
            ///up
        case 1001://邀请码
            [RouteManager routeForName:RN_center_inviteCode currentC:self parameters:@{@"title":title}];
            break;
        case 1002:{//装扮中心
            [RouteManager routeForName:RN_center_marketAC currentC:self parameters:@{@"title":title}];
        }
            break;
        case 1003:{//等级特权
            [RouteManager routeForName:RN_center_privilegeLevel currentC:self parameters:@{@"title":title}];
        }
            break;
        case 1004://充值中心
            [RouteManager routeForName:RN_center_myAccountAC currentC:self];
            break;
        case 1005://贵族中心
            [RouteManager routeForName:RN_User_buyVIP currentC:self parameters:@{@"title":title}];
            break;
        case 1006:{//排行榜
            [RouteManager routeForName:RN_center_Ranking currentC:self parameters:@{@"title":title}];
        }
            break;
        case 1007:{//任务中心
            [RouteManager routeForName:RN_center_taskCenter currentC:self];
        }
            break;
        case 1008://收益中心
            //主播认证(是否是主播)
            if ([KLCAppConfig appConfig].incomeCashAuth) {
                [self getAnchorAuthority:^(BOOL success) {
                    if (success) {
                        [weakself pushEarningView];
                    }
                }];
            }else{
                [self pushEarningView];
            }
            break;
        case 1009:{//守护中心
            [RouteManager routeForName:RN_center_myGuardAC currentC:self parameters:@{@"type":@1,@"userId":@([ProjConfig userId])}];
        }
            break;
        case 2000:{
            //特权设置
            [RouteManager routeForName:RN_activity_privilegeSetting  currentC:self];
        }
            break;
        case 2007:{//官方小店
            kWeakSelf(self);
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    [weakself shopCheckIn];
                }
            }];
        }
            break;
        case 2008://免打扰
           // NSLog(@"过滤文字免打扰"));
            break;
            
        case 2009:{//svip
            [RouteManager routeForName:RN_center_svip  currentC:weakself parameters:@{@"title":title}];
        }
            break;
        case 2010://购物订单
            [RouteManager routeForName:RN_Shopping_Order_ListVC currentC:self parameters:@{@"title":title,@"type":@(0),@"status":@(0)}];
            break;
        case 2011:{//我的时间轴
            [RouteManager routeForName:RN_center_timeActivity currentC:self parameters:@{@"model":self.mineCenterModel.userInfo}];
        }
            break;
        case 2012://美颜设置
            [RouteManager routeForName:RN_activity_setUpBeautyAC  currentC:self parameters:@{@"id":@(self.mineCenterModel.userInfo.userId),@"title":title}];
            break;
        case 2013:{//青少年模式
            [RouteManager routeForName:RN_center_youthMethod currentC:self];
            break;
        }
        case 2014://客服
        {
            [self customerSeverCall];
            break;
        }
            break;
        case 2015://365客服热线
           // NSLog(@"过滤文字365客服热线"));
            break;
            
        case 2016://设置
            [RouteManager routeForName:RN_center_settingAC  currentC:self parameters:@{@"id":@(self.mineCenterModel.userInfo.userId),@"title":title}];
            break;
        case 2017:{//主播中心
            [RouteManager routeForName:RN_center_hostCenter currentC:self parameters:@{@"title":title}];
        }
            break;
        case 2021:{//在线客服
            [RouteManager routeForName:RN_center_setting_onLineService currentC:self];
        }
            break;
        case 2019:{//我的公会
            [self getAnchorAuthority:^(BOOL success) {
                if (success) {
                    NSString *strUrl = @"/api/guild/toGuildList";
                    [RouteManager routeForName:RN_general_webView currentC:weakself parameters:@{@"url":strUrl}];
                }
            }];
            
        }
            break;
        case 2022:{//家族
            
            [RouteManager routeForName:RN_Family_CommentListVC currentC:self];
        }
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
                    [self authorityTipShow:model];
                }
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}


- (void)authorityTipShow:(MyAnchorVOModel *)model{
    NSString *tipStr;
    NSString *sureStr = kLocalizationMsg(@"确定");
    switch(model.anchorAuditStatus) {
        case 0://已经成为主播（通过）
            if (model.role <= 0) {
                tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
                sureStr = kLocalizationMsg(@"去认证");
            }else{
                tipStr = kLocalizationMsg(@"认证已通过");
            }
            break;
        case 1://审核中
            tipStr= kLocalizationMsg(@"你的认证正在审核中...");
            break;
        case 2://审核失败
            tipStr = kLocalizationMsg(@"审核未通过,快去重新认证吧！");
            sureStr = kLocalizationMsg(@"去认证");
            break;
        case -1://未申请过主播认证
            tipStr = [[ProjConfig shareInstence].baseConfig getAnchorTipsStr];
            sureStr = kLocalizationMsg(@"去认证");
            break;
        default:
            break;
    }
    kWeakSelf(self);
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"提示") message:tipStr];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:sureStr textColor:ForceAlert_NormalColor clickHandle:^{
        if (model.anchorAuditStatus == -1 && model.role <= 0) {
            if ([weakself authUserGenderForPass]) {
                [RouteManager routeForName:RN_center_anchorAuthAC currentC:weakself];
            }
        }else if (model.anchorAuditStatus == 1 && model.role <= 0){
           // NSLog(@"过滤文字主播审核等待"));
        }else{
            [RouteManager routeForName:RN_center_anchorAuthAC  currentC:weakself];
        }
    }];
    [self presentViewController:alert animated:YES completion:nil];
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

- (void)customerSeverCall{
    [RouteManager routeForName:RN_center_setting_contactService currentC:self];
}

- (void)shopCheckIn{
    kWeakSelf(self);
    [HttpApiShopBusiness settleIn:^(int code, NSString *strMsg, AppMerchantAgreementDTOModel *model) {
        if (code == 1) {
            // 状态 0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.店铺被冻结
            if (model.status>0) {
                [RouteManager routeForName:RN_Shopping_ShopContentVC currentC:weakself parameters:@{@"status":@(model.status),@"remake":model.remake}];
            }else{
                [RouteManager routeForName:RN_Shopping_OfficialShopVC currentC:weakself
                                parameters:@{ @"id":@(weakself.mineCenterModel.userInfo.userId),@"postExcerpt":model.postExcerpt,@"postTitle":model.postTitle}];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

#pragma mark - UI
- (void)createUI{
    [self.view addSubview:self.bgScrollV];
    
    [self.bgScrollV addSubview:self.headerView];//头部
    [self addFeatureGroupOneView];//功能群1
    [self addFeatureGroupTwoView];//功能群2
    self.bgScrollV.contentSize = CGSizeMake(0,self.headerView.maxY+ self.groupTwoV.height+self.groupOneV.height+50+kSafeAreaBottom+20);
    
    if (self.hasPublishBtn) {
        [self.view addSubview:self.pubulishV];
        [self.view bringSubviewToFront:self.pubulishV];
    }
}
 
- (void)addFeatureGroupOneView{
    if (self.oneTitleArray.count == 0) {
        return;
    }
    MineCneterMiddleView *middleView = [[MineCneterMiddleView alloc] initWithFrame:CGRectMake(0, self.headerView.maxY, kScreenWidth, 0.1)];
    [self.bgScrollV addSubview:middleView];
    
    kWeakSelf(self);
    self.groupOneV = middleView;
    [self.groupOneV createFunctionView:self.oneTitleArray];
    self.groupOneV.clickBtnBlock = ^(NSString * _Nonnull title, NSInteger indexType) {
        [weakself showFunction:title type:indexType];
    };
     
}


- (void)addFeatureGroupTwoView{
    if (self.twoTitleArray.count == 0) {
        return;
    }
    
    CGFloat itemViewH = 50;
    CGFloat height  = self.twoTitleArray.count*itemViewH;
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(15, (self.groupOneV?self.groupOneV.maxY:self.headerView.maxY)+20, kScreenWidth-30, height)];
    //    shadowView.layer.shadowColor = kRGBA_COLOR(@"#666666", 0.2).CGColor;
    //    shadowView.layer.shadowOffset = CGSizeMake(0,0);
    //    shadowView.layer.shadowOpacity = 0.5;
    //    shadowView.layer.shadowRadius = 8;
    [self.bgScrollV addSubview:shadowView];
    
    UIView *groupTwoV = [[UIView alloc]initWithFrame:shadowView.bounds];
    groupTwoV.layer.cornerRadius = 8;
    groupTwoV.clipsToBounds = YES;
    groupTwoV.backgroundColor = [UIColor whiteColor];
    self.groupTwoV = groupTwoV;
    [shadowView addSubview:self.groupTwoV];
    
    for (int i = 0; i < self.twoTitleArray.count; i ++) {
        NSDictionary *itemDic = self.twoTitleArray[i];
        NSString *title = itemDic[@"title"];
        NSString *imageName = itemDic[@"imageName"];
        int tag = [itemDic[@"item_id"] intValue];
        
        ///单位背景view
        UIView *itemBgV = [[UIView alloc] initWithFrame:CGRectMake(0, itemViewH*i, groupTwoV.width, itemViewH)];
        [groupTwoV addSubview:itemBgV];
        ///图片
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageV.centerY = itemBgV.height/2.0;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:imageName];
        [itemBgV addSubview:imageV];
        ///标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX+10, 0, itemBgV.width/2.0-imageV.maxX-10, 20)];
        titleLabel.centerY = imageV.centerY;
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.text = title;
        [itemBgV addSubview:titleLabel];
        
        if (tag == 2010 || tag == 2007) {
            UILabel *redL = [[UILabel alloc]initWithFrame:CGRectMake(itemBgV.width-30-10-40,0, 40, 20)];
            redL.centerY = imageV.centerY;
            redL.layer.cornerRadius = 10;
            redL.clipsToBounds = YES;
            redL.backgroundColor = [UIColor redColor];
            redL.textColor = [UIColor whiteColor];
            redL.font = [UIFont systemFontOfSize:10];
            redL.textAlignment = NSTextAlignmentCenter;
            redL.hidden = YES;
            if (tag == 2010) {
                self.shopRedL = redL;
            }else{
                self.storeRedL = redL;
            }
            [itemBgV addSubview:redL];
        }
        
        if (tag == 2008) {
            UISwitch *disturbSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(itemBgV.width-51, 0, 51, 30)];
            disturbSwitch.centerY = imageV.centerY;
            [disturbSwitch setOnTintColor:[ProjConfig normalColors]];
            disturbSwitch.centerY = titleLabel.centerY;
            disturbSwitch.on = NO;
            [disturbSwitch addTarget:self action:@selector(disturbSwitch:) forControlEvents:UIControlEventValueChanged];
            self.notDisturbSwitch = disturbSwitch;
            [itemBgV addSubview:disturbSwitch];
        }else{
            UIImageView *moreImgV = [[UIImageView alloc]initWithFrame:CGRectMake(itemBgV.width-7, 0, 7, 13)];
            moreImgV.centerY = imageV.centerY;
            moreImgV.contentMode = UIViewContentModeScaleAspectFill;
            moreImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
            moreImgV.centerY = titleLabel.centerY;
            [itemBgV addSubview:moreImgV];
            
            if (tag == 2013 || tag == 2009) {//青少年模式与svip
                UILabel *titleL = [[UILabel alloc] init];
                titleL.font = [UIFont systemFontOfSize:14];
                titleL.textColor = kRGB_COLOR(@"#AAAAAA");
                [itemBgV addSubview:titleL];
                [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(moreImgV);
                    make.right.equalTo(moreImgV.mas_left).offset(-10);
                }];
                if (tag == 2013) {
                    _youthLab = titleL;
                    titleL.text = kLocalizationMsg(@"已开启");
                    titleL.hidden = (KLCUserInfo.getUserInfo.isYouthModel == 1)?NO:YES;
                }else{
                    self.svipL = titleL;
                }
            }
        }
        if (tag != 2008) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, itemBgV.width, itemBgV.height)];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = tag;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [itemBgV addSubview:btn];
        }
    }
}
#pragma mark - MineHeaderViewDelegate
- (void)MineHeaderView:(MineHeaderView *)headerView userModel:(ApiUserInfoModel *)model{
    [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(model.userId)}];
}

- (void)MineHeaderView:(MineHeaderView *)headerView funcType:(NSInteger)funcType userModel:(ApiUserInfoModel *)model {
    switch (funcType) {
        case 1: ///关注
            [RouteManager routeForName:RN_User_UserRelationList currentC:self parameters:@{@"navTitle":kLocalizationMsg(@"我的关注"), @"type":@(4)}];
            break;
        case 2: ///粉丝
            [RouteManager routeForName:RN_User_UserRelationList currentC:self parameters:@{@"navTitle":kLocalizationMsg(@"我的粉丝"), @"type":@(3)}];
            break;
        case 3: ///赞过
            [RouteManager routeForName:RN_center_mineLike currentC:self];
            break;
        case 4:{ ///谁看过我
            if (self.mineCenterModel.nobleExpireDay > 0) {
                [RouteManager routeForName:RN_center_lookMeMore currentC:self parameters:@{@"id":@(model.userId),@"title":kLocalizationMsg(@"谁看过我")}];
            }else{
                if (self.mineCenterModel.isVipSee) {
                    [RouteManager routeForName:RN_center_lookMeMore currentC:self parameters:@{@"id":@(model.userId),@"title":kLocalizationMsg(@"谁看过我")}];
                }else{
                    [LookeMeTipView showLookeMeTipViewCallBack:^(BOOL isClose) {
                        if (!isClose) {
                            [RouteManager routeForName:RN_User_buyVIP currentC:self parameters:nil];
                        }
                    }];
                    
                }
            }
            
        }
            break;
        case 6:{ ///我的剧集
            [RouteManager routeForName:RN_Television_MineTelevision currentC:self];
        }
            break;
        default:
            break;
    }
}


#pragma mark - lazy load

- (MineHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 50, kScreenWidth, 160)];
        _headerView.delegate = self;
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UIView *)redSignPoint{
    if (!_redSignPoint) {
        _redSignPoint = [[UIView alloc]initWithFrame:CGRectMake(21, 5, 6, 6)];
        _redSignPoint.backgroundColor = [UIColor redColor];
        _redSignPoint.layer.cornerRadius = 3;
        _redSignPoint.clipsToBounds = YES;
        _redSignPoint.hidden = YES;
    }
    return _redSignPoint;
}

- (UIScrollView *)bgScrollV{
    if (!_bgScrollV) {
        _bgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)];
        _bgScrollV.contentInset = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            _bgScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        if (@available(iOS 13.0, *)) {
            _bgScrollV.automaticallyAdjustsScrollIndicatorInsets = YES;
        }
         
        _bgScrollV.showsVerticalScrollIndicator = NO;
        _bgScrollV.showsHorizontalScrollIndicator = NO;
    }
    return _bgScrollV;
}

- (UIView *)signView{
    if (!_signView) {
        UIImageView *signImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 22, 22)];
        signImageV.image = [UIImage imageNamed:@"icon_nav_sign"];
        UIButton *signBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];;
        [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _signView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth-44, kStatusBarHeight+9, 32, 32)];
        [_signView addSubview:signImageV];
        [_signView addSubview:self.redSignPoint];
        [_signView addSubview:signBtn];
    }
    return _signView;
}
- (HistBackImageView *)pubulishV{
    if (!_pubulishV) {
        _pubulishV = [[HistBackImageView alloc]initWithFrame:CGRectMake(kScreenWidth-80, kScreenHeight-kTabBarHeight-80, 80, 80)];
        _pubulishV.image = [UIImage imageNamed:@"mineCenter_live_publish_suspen"];
        _pubulishV.userInteractionEnabled = YES;
        UIButton *publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 50, 50)];
        publishBtn.backgroundColor = [UIColor clearColor];
        [publishBtn addTarget:self action:@selector(minePublishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_pubulishV addSubview:publishBtn];
    }
    return _pubulishV;
}
@end
