//
//  MyCenterAuthenStateView.m
//  MineCenter
//
//  Created by klc on 2020/7/30.
//

#import "MyCenterAuthenStateView.h"

@interface MyCenterAuthenStateView ()

kStrong(UILabel, tipsLab)

kStrong(UIButton, handlerBtn)

kBlock(btnActionBlock,AuthenState state)

@end

@implementation MyCenterAuthenStateView

- (instancetype)initWithFrame:(CGRect)frame authState:(AuthenState)state authenHandler:(void (^)(AuthenState state))authenHandler
{
    self = [super initWithFrame:frame];
    if (self) {

        _state = state;
        _btnActionBlock = authenHandler;
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    UIImageView * tipsImv = [Maker Imv:ImgNamed(@"Mine_Authen_tips") layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(140);
    }];
    
    UILabel *tipsLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:@"" textColor:[UIColor grayColor] font:kFont(13) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.top.equalTo(tipsImv.mas_bottom).offset(30);
        make.centerX.equalTo(self);
    }];
    
    switch (_state) {
        case authenStateUnAuthen:{
            tipsLab.text = kLocalizationMsg(@"你现在不是主播哦\n\n现在去认证");
            _handlerBtn = [Maker BtnWithShadow:NO backColor:[ProjConfig normalColors] text:kLocalizationMsg(@"立即认证") textColor:[UIColor whiteColor] font:kFont(15) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
               
                make.size.mas_equalTo(SIZE(150, 36));
                make.bottom.mas_equalTo(self).inset(75);
                make.centerX.equalTo(self);
            }];
            _handlerBtn.layer.cornerRadius = 18;
            [_handlerBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case authenStateProcessing:{
            tipsLab.text = kLocalizationMsg(@"你的身份证还在审核中\n\n请耐心等待");
            break;
        }
        case authenStateFail:{
         
            tipsLab.text = kLocalizationMsg(@"你的身份认证失败了哦\n\n请重新认证");
            _handlerBtn = [Maker BtnWithShadow:NO backColor:[ProjConfig normalColors] text:kLocalizationMsg(@"立即认证") textColor:[UIColor whiteColor] font:kFont(15) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
               
                make.size.mas_equalTo(SIZE(150, 36));
                make.bottom.mas_equalTo(self).inset(75);
                make.centerX.equalTo(self);
            }];
            _handlerBtn.layer.cornerRadius = 18;
            [_handlerBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
    }
}
-(void)btnAction:(UIButton *)sender{
    
    self.btnActionBlock(_state);
}

@end
