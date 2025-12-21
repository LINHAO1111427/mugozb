//
//  SVTrySeeAlertVC.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SVTrySeeAlertVC.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiShortVideoDtoModel.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjView/BalanceLackPromptView.h>

@interface SVTrySeeAlertVC ()

@property (nonatomic, weak)UIView *alertV;

@property (nonatomic, weak)UIImageView *dtoImageV;

@property (nonatomic, weak)UILabel *showLab;

@property (nonatomic, weak)UIButton *vipBtn;

@property (nonatomic, weak)UIButton *coinBtn;

@end

@implementation SVTrySeeAlertVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self createUI];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view) {
        [self dismissView];
    }
}


- (void)createUI{
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 320)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 10;
    [self.view addSubview:alertView];
    _alertV = alertView;
    alertView.center = CGPointMake(alertView.superview.width/2.0, alertView.superview.height/2.0);
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, alertView.width-30, 21)];
    titleL.text = kLocalizationMsg(@"付费查看");
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = kRGBA_COLOR(@"#333333", 1.0);
    titleL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:titleL];
    
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(alertView.width-30, 0, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleL.maxY+15, 87, 117)];
    imageV.centerX = titleL.centerX;
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 5;
    [alertView addSubview:imageV];
    _dtoImageV = imageV;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectV = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectV.alpha = 0.9;
    effectV.frame = imageV.bounds;
    [imageV addSubview:effectV];
    
    UIBlurEffect *blurEffect1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectV1 = [[UIVisualEffectView alloc] initWithEffect:blurEffect1];
    effectV1.alpha = 0.6;
    effectV1.frame = imageV.bounds;
    [imageV addSubview:effectV1];
    
    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.maxY+15, alertView.width, 20)];
    showLab.font = [UIFont systemFontOfSize:14];
    showLab.textColor = kRGBA_COLOR(@"#666666", 1.0);
    showLab.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:showLab];
    _showLab = showLab;
    
    UIButton *vipBtn = [UIButton buttonWithType:0];
    vipBtn.frame = CGRectMake(0, showLab.maxY+20, 200, 32);
    vipBtn.centerX = showLab.centerX;
    vipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [vipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vipBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    vipBtn.layer.masksToBounds = YES;
    vipBtn.layer.cornerRadius = 16;
    [vipBtn addTarget:self action:@selector(buyViP:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:vipBtn];
    _vipBtn = vipBtn;

    UIButton *payBtn = [UIButton buttonWithType:0];
    [payBtn setTitle:kLocalizationMsg(@"付费查看") forState:UIControlStateNormal];
    payBtn.frame = CGRectMake(0, vipBtn.maxY+11, 200, 32);
    payBtn.centerX = showLab.centerX;
    payBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [payBtn setTitleColor:kRGBA_COLOR(@"#FF5EC6", 1.0) forState:UIControlStateNormal];
    [payBtn setBackgroundColor:[UIColor whiteColor]];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 16;
    payBtn.layer.borderColor = [ProjConfig normalColors].CGColor;
    payBtn.layer.borderWidth = 1.0;
    [payBtn addTarget:self action:@selector(payMoney:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:payBtn];
    _coinBtn = payBtn;
    
    [self showSVInfo];
}

- (void)showSVInfo{
    NSString *lastStr = [NSString stringWithFormat:kLocalizationMsg(@" 查看此%@"),_dtoModel.type == 1?kLocalizationMsg(@"视频"):kLocalizationMsg(@"图片")];
    NSString *str = [NSString stringWithFormat:kLocalizationMsg(@"花费 %.0lf"),_dtoModel.coin];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:str];
    [muStr appendAttributedString:[lastStr attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:YES]];
    _showLab.attributedText = muStr;
    
    if (_dtoModel.privilegesLowestName.length > 0) {
        [_vipBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"开通%@免费看"),_dtoModel.privilegesLowestName] forState:UIControlStateNormal];
        ///有VIP
        _vipBtn.hidden = NO;
        _coinBtn.y = _vipBtn.maxY+11;
    }else{
        ///没有VIP
        _vipBtn.hidden = YES;
        _coinBtn.y = _vipBtn.y+11;
    }

    if (_dtoModel.type == 1) {  ///视频
        if (_dtoModel.thumb.length) {
            [_dtoImageV sd_setImageWithURL:[NSURL URLWithString:_dtoModel.thumb]];
        }else{
            [_dtoImageV sd_setImageWithURL:[NSURL URLWithString:_dtoModel.avatar]];
        }
        if (_dtoModel.width >= _dtoModel.height) {
            _dtoImageV.contentMode = UIViewContentModeScaleAspectFit;
        }else{
            if ([[ProjConfig getAppVerticalVideoGravity] isEqualToString:@"AVLayerVideoGravityResizeAspectFill"]) {
                _dtoImageV.contentMode = UIViewContentModeScaleAspectFill;
            }else{
                _dtoImageV.contentMode = UIViewContentModeScaleAspectFit;
            }
        }
        UIImageView *playStatusImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        playStatusImgV.center = CGPointMake(_dtoImageV.width/2.0, _dtoImageV.height/2.0);
        playStatusImgV.image = [UIImage imageNamed:@"shorVideo_play"];
        [_dtoImageV addSubview:playStatusImgV];
    }else{
        NSArray *arr = [_dtoModel.images componentsSeparatedByString:@","];
        if (arr.count > 0) {
            NSString *url = arr.firstObject;
            _dtoImageV.contentMode = UIViewContentModeScaleAspectFit;
            [_dtoImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        }
    }
}


- (void)shortVideoReadWithType:(int)type callBack:(void(^)(int code))callback{
    kWeakSelf(self);
    [HttpApiAppShortVideo useReadShortVideoNumber:self.dtoModel.id_field type:type callback:^(int code, NSString *strMsg, ApiBaseEntityModel *model) {
        if(code == 1){
            callback(model.code);
            if(model.code == 3) {
                [BalanceLackPromptView gotoRecharge:^(BOOL go) {
                    if (go) {
                        [weakself dismissView];
                    }
                }];
            }
        }else{
            callback(code);
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"支付失败")];
        }
    }];
}


- (void)buyViP:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:self];
    }else{
        [RouteManager routeForName:RN_User_buyVIP currentC:[ProjConfig currentVC]];
        [self dismissView];
    }
}

- (void)payMoney:(UIButton *)btn{
    if (![ProjConfig isUserLogin]) {
        [RouteManager routeForName:RN_login_ShowLoginVC currentC:self];
    }else{
        kWeakSelf(self);
        [self shortVideoReadWithType:1 callBack:^(int code) {
            if (code == 1) {//充值成功
                if (weakself.isPlayBlock) {
                    weakself.isPlayBlock(YES);
                }
                [self dismissView];
            }
        }];
    }
}

- (void)closeBtnClick:(UIButton *)btn{
    [self dismissView];
}


- (void)dismissView{
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
