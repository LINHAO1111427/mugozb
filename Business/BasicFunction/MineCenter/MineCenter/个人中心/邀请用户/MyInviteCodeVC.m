//
//  MyInviteCodeVC.m
//  MineCenter
//
//  Created by klc_sl on 2021/3/13.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MyInviteCodeVC.h"
#import "MineCenterRes.h"
#import <LibTools/LibTools.h>
#import <LibProjView/LiveShareView.h>

#import <LibProjModel/HttpApiSupport.h>
#import <LibProjModel/KeyValueDtoModel.h>
#import <LibProjModel/InviteDtoModel.h>
#import <LibProjModel/HttpApiAPPFinance.h>

#import "CommissWithdrawVc.h"
#import "InviteRecordVc.h"
#import "PictureSharingVC.h"
#import "InviteUserRollView.h"

@interface MyInviteCodeVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollV;

///喇叭图标
@property (weak, nonatomic) IBOutlet UIImageView *hornImageV;
///邀请排行版
@property (weak, nonatomic) IBOutlet UIView *inviteListBgView;
///佣金余额
@property (weak, nonatomic) IBOutlet UILabel *commissionL;
///已提现金额
@property (weak, nonatomic) IBOutlet UILabel *withdrawL;
///累计佣金
@property (weak, nonatomic) IBOutlet UILabel *totalCommisionL;
///去邀请按钮
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
///提现按钮
@property (weak, nonatomic) IBOutlet UIButton *withdrawBtn;
///我的邀请码
@property (weak, nonatomic) IBOutlet UILabel *myInviteL;

///邀请步骤123
@property (weak, nonatomic) IBOutlet UILabel *inviteStep1L;
@property (weak, nonatomic) IBOutlet UILabel *inviteStep2L;
@property (weak, nonatomic) IBOutlet UILabel *inviteStep3L;

///我的邀请记录
@property (weak, nonatomic) IBOutlet UIButton *inviteRecordBtn;
///邀请排行榜
@property (weak, nonatomic) IBOutlet UIButton *inviteListBtn;
///邀请规则
@property (weak, nonatomic) IBOutlet UILabel *inviteRuleL;


@property (nonatomic, weak)InviteUserRollView *userRollView;//轮播
@property (nonatomic, strong)InviteDtoModel *inviteModel;

@end

@implementation MyInviteCodeVC

- (instancetype)init
{
    
    NSString* nibFullName=  [MineCenterRes getNibFullName:@"MyInviteCodeVC"];
    self = [super initWithNibName:nibFullName bundle:[NSBundle mainBundle]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"邀请赚钱");
    self.view.backgroundColor = [UIColor whiteColor];
    
    //佣金
    UIButton *commissionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [commissionBtn setTitle:kLocalizationMsg(@"佣金明细") forState:UIControlStateNormal];
    [commissionBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    commissionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [commissionBtn addTarget:self action:@selector(commissionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:commissionBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self createUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    [self getInviteRank];
    [_userRollView startRoll];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_userRollView stoptRoll];
}

- (void)loadData{
    kWeakSelf(self);
    [HttpApiSupport getInviteCodeInfo:^(int code, NSString *strMsg, InviteDtoModel *model) {
        if (code == 1) {
            weakself.inviteModel = model;
            [weakself showViewInfo];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getInviteRank{
    kWeakSelf(self);
    [HttpApiAPPFinance incomeRanking:1 toUserId:0 type:0 callback:^(int code, NSString *strMsg, PageInfo *pageInfo, NSArray<AppUserIncomeRankingDtoModel *> *arr) {
        if (code == 1) {
            weakself.userRollView.inviteArray = arr;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)createUI{
    if (@available(iOS 11.0, *)) {
        _bgScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _commissionL.text = @"0";
    _withdrawL.text = @"0";
    _totalCommisionL.text = @"0";
    
    _inviteStep1L.text = kLocalizationMsg(@"点击邀请按钮\n分享给好友");
    _inviteStep2L.text = kLocalizationMsg(@"好友下载app\n并注册成功");
    _inviteStep3L.text = kLocalizationMsg(@"佣金到账");
    
    [_inviteBtn setImage:[UIImage imageNamed:@"icon_mine_invite_more"] forState:UIControlStateNormal];
    [_inviteBtn setTitle:kLocalizationMsg(@" 去邀请") forState:UIControlStateNormal];
    [_inviteBtn setBackgroundImage:[UIImage createImageSize:_inviteBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    
    [_withdrawBtn setImage:[UIImage imageNamed:@"icon_mine_invite_withdraw"] forState:UIControlStateNormal];
    [_withdrawBtn setTitle:kLocalizationMsg(@" 提现") forState:UIControlStateNormal];
    [_withdrawBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FF6271")] forState:UIControlStateNormal];
    
    [_inviteRecordBtn setTitle:kLocalizationMsg(@"邀请记录") forState:UIControlStateNormal];
    [_inviteListBtn setTitle:kLocalizationMsg(@"收入排行榜") forState:UIControlStateNormal];
    
    ///背景颜色
    UIView *bgColorV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-50, _inviteListBgView.height)];
    bgColorV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    bgColorV.layer.masksToBounds = YES;
    bgColorV.layer.cornerRadius = 10;
    [_inviteListBgView addSubview:bgColorV];
    [_inviteListBgView sendSubviewToBack:bgColorV];
    
    InviteUserRollView *rollView = [[InviteUserRollView alloc]initWithFrame:bgColorV.bounds];
    [bgColorV addSubview:rollView];
    _userRollView = rollView;
}

- (void)showViewInfo{
    
    _commissionL.text = [NSString stringWithFormat:@"¥%.2f",self.inviteModel.amount];
    _withdrawL.text = [NSString stringWithFormat:@"¥%.2f",self.inviteModel.totalCash];
    _totalCommisionL.text = [NSString stringWithFormat:@"¥%.2f",self.inviteModel.totalAmount];
    [_inviteRecordBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"邀请记录(%d)"),self.inviteModel.inviteUserNum] forState:UIControlStateNormal];
    _inviteRuleL.attributedText = [self.inviteModel.inviteRule HTMLTextWithTextColor:kRGBA_COLOR(@"#666666", 1.0)];
    _myInviteL.text = [NSString stringWithFormat:kLocalizationMsg(@"我的邀请码 %@"),self.inviteModel.code];
     [self addShakeAnimation:_hornImageV];
}

///邀请记录
- (IBAction)inviteBtnClick:(id)sender {
    [RouteManager routeForName:RN_center_InviteRecode currentC:self];
}

///排行榜
- (IBAction)inviteListBtnClick:(id)sender {
    [RouteManager routeForName:RN_center_incomeRank currentC:self];
}

///去邀请
- (IBAction)goInviteBtnClick:(id)sender {
    kWeakSelf(self);
    ShareFunctionItem *picShare = [ShareFunctionItem shareIcon:[UIImage imageNamed:@"icon_more_picture"] name:kLocalizationMsg(@"图片分享") clickBlock:^{
        [weakself pictureShare];
    }];
    [LiveShareView showShareViewForType:3 shareId:0 moreFunction:@[picShare,[ShareFunctionItem getCopyLinkFunction]]];
}

///提现按钮
- (IBAction)withDrawBtnClick:(id)sender {
    CommissWithdrawVc *commisVc = [[CommissWithdrawVc alloc]init];
    commisVc.inviteModel = self.inviteModel;
    [self.navigationController pushViewController:commisVc animated:YES];
}

- (void)addShakeAnimation:(UIImageView *)imageView{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:+0.15];
    shake.toValue = [NSNumber numberWithFloat:-0.15];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = LONG_MAX;
    shake.removedOnCompletion = NO;
    [imageView.layer addAnimation:shake forKey:@"imageView_shake"];
}

- (void)pictureShare{
    if (kStringIsEmpty(_inviteModel.shareImg.value1)) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"图片为空")];
    }else{
        [RouteManager routeForName:RN_center_pictureSharingAC currentC:self parameters:@{@"model":self.inviteModel}];
    }
}
- (void)commissionBtnClick:(UIButton *)btn{
    NSString *url = @"/api/h5/rewardRecord";
    [RouteManager routeForName:RN_general_webView currentC:self parameters:@{@"url":url}];
}


@end
