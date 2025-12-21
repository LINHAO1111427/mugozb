//
//  CAuthorityManageVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/27.
//  Copyright © 2020 KLC. All rights reserved.
//  主播认证

#import "CAuthorityManageVc.h"
#import "CAuthorityTipView.h"
#import "CAuthorityInfoListView.h"
#import <LibProjModel/HttpApiUserController.h>
 
@interface CAuthorityManageVc ()<CAuthorityInfoListViewDelegate>

@property (nonatomic, strong)CAuthorityTipView *tipView;//认证提示
@property (nonatomic, strong)CAuthorityInfoListView *infoListView;//认证信息
@property (nonatomic, assign)AuthorityStatus aStatus;//认证状态
@end

@implementation CAuthorityManageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = kLocalizationMsg(@"实名认证");
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tipView];

    //获取主播认证情况
    [self getAnchorInfo];
}

//获取主播认证信息
- (void)getAnchorInfo{
    kWeakSelf(self);
    [HttpApiUserController getMyAnchor:^(int code, NSString *strMsg, MyAnchorVOModel *model) {
        if (code == 1) {
            [weakself setMyAuthStatus:model.anchorAuditStatus authModel:model];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

 
- (void)setMyAuthStatus:(AuthorityStatus)status authModel:(MyAnchorVOModel *)model{
    _aStatus = status;
    kWeakSelf(self);
    [self.view removeAllSubViews];
    self.infoListView = nil;
    self.tipView = nil;
    self.tipView.model = model;
    [self.view addSubview:self.tipView];
    [self.view addSubview:self.infoListView];
    self.tipView.aStatus = _aStatus;
    switch (_aStatus) {
        case AuthorityStatusApply://待审核 未提交
            self.infoListView.hidden = NO;
            break;
        case AuthorityStatusPassed://审核通过
            self.tipView.hidden = NO;
            break;
        case AuthorityStatusReview://审核中
            self.tipView.hidden = NO;
            break;
        case AuthorityStatusRejected:{//审核未通过
            self.tipView.hidden = NO;
            [self.tipView.reApplayBtn klc_whenTapped:^{
                [weakself setMyAuthStatus:AuthorityStatusApply authModel:model];
            }];
        }
            break;
        default:
            break;
    }
}
 
- (CAuthorityTipView *)tipView{
    if (!_tipView) {
        _tipView = [[CAuthorityTipView alloc]initWithFrame:self.view.bounds];
        _tipView.hidden = YES;
    }
    return _tipView;
}
- (CAuthorityInfoListView *)infoListView{
    if (!_infoListView) {
        _infoListView = [[CAuthorityInfoListView alloc]initWithFrame:self.view.bounds];
        _infoListView.delegate = self;
        _infoListView.superVc = self;
        _infoListView.hidden = YES;
    }
    return _infoListView;
}


#pragma mark - CAuthorityInfoListViewDelegate -
- (void)authenticationSuccess{
   UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[ProjConfig shareInstence].baseConfig showHomeMainVC];
    }
}

@end
