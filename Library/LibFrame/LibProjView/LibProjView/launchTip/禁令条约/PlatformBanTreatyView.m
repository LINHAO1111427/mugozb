//
//  PlatformBanTreatyView.m
//  LibProjView
//
//  Created by klc_sl on 2021/4/7.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PlatformBanTreatyView.h"
#import <LibProjBase/PopupTool.h>
#import "KLCNetworkShowView.h"
#import <LibProjModel/HttpApiAppLogin.h>

@interface PlatformBanTreatyView ()

@property (nonatomic, copy)void(^agreeBlock)(void);

@property (nonatomic, weak)KLCNetworkShowView *showView;

@property (nonatomic, weak)UIImageView *selectImgV;

@property (nonatomic, assign)BOOL isAgree;

@end

@implementation PlatformBanTreatyView

+ (void)showTreaty:(void (^)(void))agreeBlock{
    [HttpApiAppLogin getUseLicense:^(int code, NSString *strMsg, AppPostsModel *model) {
        if (code == 1 && model.isUseLicense == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [PlatformBanTreatyView showView:model agreeBlock:agreeBlock];
            });
        }else{
            if (agreeBlock) {
                agreeBlock();
            }
        }
    }];
}

+ (void)showView:(AppPostsModel *)model agreeBlock:(void (^)(void))agreeBlock{
    
    UIView *banTreatyView = [PopupTool getPopupViewForClass:self];
    if (banTreatyView) {
        return;
    }
    PlatformBanTreatyView *banView = [[PlatformBanTreatyView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-40, (kScreenWidth-40)*550/335.0)];
    banView.agreeBlock = agreeBlock;
    [[PopupTool share] createPopupViewWithLinkView:banView allowTapOutside:NO cover:YES];
    banView.centerY = banView.superview.height/2.0;
    [banView createUI:model];
}

///显示视图
- (void)createUI:(AppPostsModel *)model{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0;
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, self.width-40, 20)];
    titleL.font = kFont(17);
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = kRGBA_COLOR(@"#000000", 1.0);
    titleL.text = model.postTitle;
    [self addSubview:titleL];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(20, 50, self.width-40, 0.5)];
    lineT.backgroundColor = kRGBA_COLOR(@"#CECECE", 1.0);
    [self addSubview:lineT];
    
    UIButton *noSureBtn = [UIButton buttonWithType:0];
    noSureBtn.frame = CGRectMake(25, self.height-35-15, self.width-50, 35);
    noSureBtn.titleLabel.font = kFont(14);
    [noSureBtn setTitle:kLocalizationMsg(@"不同意并退出") forState:UIControlStateNormal];
    [noSureBtn setTitleColor:kRGBA_COLOR(@"#999999", 1.0) forState:UIControlStateNormal];
    [noSureBtn addTarget:self action:@selector(userNoSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:noSureBtn];
    
    UIButton *agreeBtn = [UIButton buttonWithType:0];
    agreeBtn.frame = CGRectMake(25, noSureBtn.y-noSureBtn.height-5, noSureBtn.width, noSureBtn.height);
    agreeBtn.layer.masksToBounds = YES;
    agreeBtn.layer.cornerRadius = 3.0;
    agreeBtn.titleLabel.font = kFont(15);
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [agreeBtn setTitle:kLocalizationMsg(@"我同意以上条约") forState:UIControlStateNormal];
    [agreeBtn setTitleColor:kRGBA_COLOR(@"#ffffff", 1.0) forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(userAgreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:agreeBtn];
    
    ///同意
    UIView *agreeBgV = [[UIView alloc] initWithFrame:CGRectMake(20, agreeBtn.y-38, self.width-40, 50)];
    [self addSubview:agreeBgV];
    {
        UIImageView *selectImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 13, 13)];
        selectImgV.image = [UIImage imageNamed:@"launch_agree_normal"];
        [agreeBgV addSubview:selectImgV];
        _selectImgV = selectImgV;
        UILabel *agreeTextL = [[UILabel alloc] init];
        agreeTextL.font = kFont(12);
        agreeTextL.textColor = kRGBA_COLOR(@"#000000", 1.0);
        agreeTextL.text = kLocalizationMsg(@"我已阅读并了解条约内容，本人同意条约内所有条款。");
        agreeTextL.numberOfLines = 0;
        [agreeBgV addSubview:agreeTextL];
        [agreeTextL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(agreeBgV).offset(20);
            make.left.equalTo(selectImgV.mas_right).offset(5);
            make.right.equalTo(agreeBgV).offset(-20);
            make.bottom.equalTo(agreeBgV).offset(-25);
        }];
        [agreeBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(agreeBtn.mas_top);
        }];
        
        UIButton *selectBtn = [UIButton buttonWithType:0];
        selectBtn.frame = CGRectMake(0, 0, selectImgV.width+20, selectImgV.width+20);
        selectBtn.center = selectImgV.center;
        [agreeBgV addSubview:selectBtn];
        [selectBtn addTarget:self action:@selector(selectAgreeBan:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *lineB = [[UIView alloc] init];
    lineB.backgroundColor = kRGBA_COLOR(@"#CECECE", 1.0);
    [self addSubview:lineB];
    [lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineT);
        make.bottom.equalTo(agreeBgV.mas_top);
        make.height.mas_equalTo(lineT.height);
    }];
    
    KLCNetworkShowView *showV = [[KLCNetworkShowView alloc] init];
    showV.showProgressLine = NO;
    [showV loadLocalHTML:model.postExcerpt];
    [self addSubview:showV];
    [showV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineT).offset(5);
        make.left.right.equalTo(titleL);
        make.bottom.equalTo(lineB.mas_top).offset(-5);
    }];
}


- (void)selectAgreeBan:(UIButton *)btn{
    _isAgree = !_isAgree;
    _selectImgV.image = [UIImage imageNamed:_isAgree?@"launch_agree_selected":@"launch_agree_normal"];
}


- (void)userAgreeBtnClick:(UIButton *)btn{
    if (!_isAgree) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请同意")];
        return;
    }
    btn.userInteractionEnabled = NO;
    kWeakSelf(self);
    [HttpApiAppLogin addUseLicense:^(int code, NSString *strMsg, HttpNoneModel *model) {
        btn.userInteractionEnabled = YES;
        if (code == 1) {
            [weakself dismissView];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///用户不同意
- (void)userNoSureBtnClick:(UIButton *)btn{
    [ProjConfig logout];
    exit(0);
}

- (void)dismissView{
    if (self.agreeBlock) {
        self.agreeBlock();
    }
    [[PopupTool share] closePopupView:self];
}


@end
