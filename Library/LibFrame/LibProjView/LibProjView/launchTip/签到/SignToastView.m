//
//  SignToastView.m
//  HomePage
//
//  Created by klc on 2020/7/31.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "SignToastView.h"
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/ApiSignInModel.h>
#import <LibProjModel/ApiSignInDtoModel.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjView/PublicMethodObj.h>

@interface SignGiftItem : UIView

kStrong(UILabel, dateLab)
kStrong(UIImageView, giftImv)
kStrong(UILabel, nameLab)

@end

@implementation SignGiftItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 4;
        self.backgroundColor = kRGB_COLOR(@"#F6F7F9");
        self.clipsToBounds = YES;
        _dateLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:@"" textColor:[UIColor grayColor] font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.left.top.equalTo(self).offset(5);
            make.centerX.equalTo(self);
        }];
        
        _giftImv = [Maker Imv:nil layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.center.equalTo(self);
            make.size.mas_equalTo(SIZE(34, 34));
        }];
        
        _nameLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:@"" textColor:[UIColor grayColor] font:kFont(10) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.right.bottom.equalTo(self).inset(5);
            make.centerX.equalTo(self);
        }];
        _nameLab.numberOfLines = 1;
    }
    return self;
}

@end

@interface SignToastView ()

@property (nonatomic, weak)UIView *bgView;
kStrong(UIControl, maskCtr)
kStrong(UIButton, signBtn)
kStrong(UIView, giftsView)
kAssign(BOOL, isSignIn)
kBlock(dismissBlock,BOOL isSignIn)
kStrong(UIButton, closeBtn)

@property(nonatomic,strong)ApiSignInDtoModel *model;

@end

@implementation SignToastView

+(instancetype)toastView{
    __weak static SignToastView *weakView ;
    SignToastView *strongView = weakView;
    @synchronized (self) {
        if (!strongView) {
            strongView = [[[self class] alloc] initWithFrame:CGRectZero];
            weakView = strongView;
        }
    }
    return strongView;
}

+ (void)showSignViewWithComplition:(toastDissmissBlock)complition {
    [SignToastView getSignData:^(BOOL success, ApiSignInDtoModel *model) {
        if (success && model.signList.count) {
            UIView *signV = [PopupTool getPopupViewForClass:self];
            if (![signV isKindOfClass:[SignToastView class]]) {
                SignToastView *signTV = [[SignToastView alloc] initWithFrame:CGRectZero];
                signTV.model = model;
                [signTV showInSuperViewDismissComplition:complition];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"暂无签到数据")];
        }
    }];
}


+ (void)launchAutoShowSign:(toastDissmissBlock)complition{
    [PublicMethodObj launchTimeJudge:@"everydaySignsKey" withinOneDayBlock:^(BOOL within) {
        if (!within) {
            [SignToastView getSignData:^(BOOL success, ApiSignInDtoModel *model) {
                if (success && (!model.isSign && model.signList.count)) {
                    UIView *signV = [PopupTool getPopupViewForClass:self];
                    if (![signV isKindOfClass:[SignToastView class]]) {
                        SignToastView *signTV = [[SignToastView alloc] initWithFrame:CGRectZero];
                        signTV.model = model;
                        [signTV showInSuperViewDismissComplition:complition];
                        [PublicMethodObj LaunchTimechange:@"everydaySignsKey"];
                    }
                }else{
                    if (complition) {
                        complition(YES);
                    }
                }
            }];
        }else{
            if (complition) {
                complition(YES);
            }
        }
    }];
}

+ (void)getUserIsSign:(toastDissmissBlock)complition{
    [SignToastView getSignData:^(BOOL success, ApiSignInDtoModel *model) {
        if (success && model.signList.count>0) {
            complition?complition(model.isSign):nil;
        }else{
            complition?complition(YES):nil;
        }
    }];
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


-(void)setupSubViews{
    
    UIImageView *tipImv = [Maker Imv:ImgNamed(@"my_sign_header") layerCorner:0 superView:self.bgView constraints:^(MASConstraintMaker * _Nonnull make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(80);
    }];
    _signBtn = [Maker BtnWithShadow:NO backColor:kRGB_COLOR(@"#8A8DFF") text:kLocalizationMsg(@"立即签到") textColor:[UIColor whiteColor] font:kFont(14) superView:self.bgView constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.size.mas_equalTo(SIZE(200, 34));
        make.centerX.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).inset(18);
    }];
    _signBtn.layer.cornerRadius = 17;
    [_signBtn addTarget:self action:@selector(signClickAction:) forControlEvents:UIControlEventTouchUpInside];
    _giftsView = [Maker viewWithShadow:NO backColor:[UIColor whiteColor] superView:self.bgView constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.left.equalTo(self.bgView).offset(12);
        make.right.equalTo(self.bgView).inset(12);
        make.top.equalTo(tipImv.mas_bottom).offset(18);
        make.bottom.equalTo(_signBtn.mas_top).inset(24);
    }];
    
}

+ (void)getSignData:(void(^)(BOOL success, ApiSignInDtoModel *model))callBack{
    [HttpApiUserController getSignInfo:^(int code, NSString *strMsg, ApiSignInDtoModel *model) {
        callBack((code == 1)?YES:NO, model);
    }];
}

- (void)setModel:(ApiSignInDtoModel *)model{
    _model = model;
    [_giftsView removeAllSubViews];
    CGFloat gap = (286-24-58*4)/3;
    CGFloat count = MIN(model.signList.count, 7);
    for (int i= 0; i<count; i++) {
        ApiSignInModel *signInModel = model.signList[i];
        SignGiftItem *item = [[SignGiftItem alloc] initWithFrame:CGRectZero];
        [_giftsView addSubview:item];
        int row = i/4;
        int col = i%4;
        CGFloat width = i==6?(58*2+gap):58;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(SIZE(width, 80));
            make.left.equalTo(_giftsView).offset((58+gap)*col);
            make.top.equalTo(_giftsView).offset((80+gap)*row);
        }];
        
        item.dateLab.text = kStringFormat(kLocalizationMsg(@"第%d天"),signInModel.dayNumber);
        
        NSString *giftName = nil;
        if (signInModel.type == 2) {
            
            giftName = signInModel.name;
            [item.giftImv sd_setImageWithURL:[NSURL URLWithString:signInModel.image]];
        }else if (signInModel.type == 1){
            
            giftName = kStringFormat(@"%@*%d",kUnitStr.length > 0?kUnitStr:@"",signInModel.typeVal);
            item.giftImv.image = [ProjConfig getCoinImage];
        }
        item.nameLab.text = giftName;
        BOOL isGet = signInModel.isGet == 1;//已领取
        
        if (isGet) {
            [Maker viewWithShadow:NO backColor:[kRGB_COLOR(@"#A570FE") colorWithAlphaComponent:0.3] superView:item constraints:^(MASConstraintMaker * _Nonnull make) {
                make.edges.equalTo(item);
            }];
            UIImageView *giftImv = [Maker Imv:ImgNamed(@"icon_unsign_mark") layerCorner:0 superView:item constraints:^(MASConstraintMaker * _Nonnull make) {
                
                make.center.equalTo(item);
            }];
            giftImv.backgroundColor = [UIColor clearColor];
        }
    }
    
    [self signBtnTitleChange:model.isSign?kLocalizationMsg(@"已签到"):kLocalizationMsg(@"立即签到") isSignIn:model.isSign];
}
-(void)signClickAction:(UIButton*)sender{
    sender.enabled = NO;
    kWeakSelf(self);
    [HttpApiUserController signIn:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {//签到成功
            [SignToastView getSignData:^(BOOL success, ApiSignInDtoModel *model) {
                if (success) {
                    weakself.model = model;
                    [weakself getMyGift];
                }
            }];
            [weakself signBtnTitleChange:kLocalizationMsg(@"已存入背包") isSignIn:YES];
        }else{
            HudShowError(strMsg)
        }
        sender.enabled = YES;
    }];
}
- (void)signBtnTitleChange:(NSString *)title isSignIn:(BOOL)isSignIn{
    [self.signBtn setTitle:title forState:UIControlStateNormal];
    self.isSignIn = isSignIn;
}
- (void)setIsSignIn:(BOOL)isSignIn{
    _isSignIn = isSignIn;
    _signBtn.backgroundColor = isSignIn?[UIColor lightGrayColor]:kRGB_COLOR(@"#8A8DFF");
    _signBtn.enabled = !isSignIn;
}
-(void)getMyGift{
    [_giftsView removeFromSuperview];
    
    
    UILabel *titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:kLocalizationMsg(@"恭喜获得") textColor:kRGB_COLOR(@"#FF4A43") font:kFont(14) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(100);
    }];
    
    UIImageView *giftImv = [Maker Imv:nil layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.top.equalTo(titleLab.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(SIZE(90, 90));
    }];
    if (_model.signList.count == 0) return;
    if (_model.signList.count >= _model.signDay) {
        
        NSUInteger index =_model.signDay>0?(_model.signDay-1):0;
        ApiSignInModel * giftModel = _model.signList[index];
        
        if (giftModel.type == 2) {
            
            [giftImv sd_setImageWithURL:[NSURL URLWithString:giftModel.image]];
        }else if (giftModel.type == 1){
            
            giftImv.image = [ProjConfig getCoinImage];
        }
    }
}



-(void)showInSuperViewDismissComplition:(nullable toastDissmissBlock)complition{
    
    _dismissBlock = complition;
    
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES popupBgViewAction:@selector(dissmissToastView) popupBgViewTarget:self cover:YES];
    
    CGFloat sWidth = 286;
    CGFloat sHeight = 344 + 50;
    self.frame = CGRectMake((kScreenWidth - sWidth) / 2, (kScreenHeight - sHeight) / 2, sWidth, sHeight);
}


- (UIControl *)maskCtr{
    if (!_maskCtr) {
        _maskCtr = [[UIControl alloc] initWithFrame:CGRectZero];
        _maskCtr.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        //        [_maskCtr addTarget:self action:@selector(dissmissToastView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskCtr;
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgV = [[UIView alloc] init];
        [self addSubview:bgV];
        _bgView = bgV;
        
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(SIZE(286, 344));
            make.top.left.right.equalTo(self);
        }];
        bgV.layer.cornerRadius = 18;
        bgV.backgroundColor = [UIColor whiteColor];
        bgV.clipsToBounds = YES;
        
        self.closeBtn.hidden = NO;
    }
    return _bgView;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:ImgNamed(@"signView_close") forState:0];
        [self addSubview:_closeBtn];
        [_closeBtn addTarget:self action:@selector(dissmissToastView) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_bottom);
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _closeBtn;
}
-(void)dissmissToastView{
    
    [self removeFromSuperview];
    [_maskCtr removeFromSuperview];
    [_closeBtn removeFromSuperview];
    if (_dismissBlock) _dismissBlock(_isSignIn);
    
    [[PopupTool share] closePopupView:self];
    
}

@end
