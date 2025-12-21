//
//  PayResultView.m
//  LibProjView
//
//  Created by klc_sl on 2020/11/3.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "PayResultView.h"
#import <LibProjBase/PopupTool.h>
#import <Masonry/Masonry.h>

@interface PayResultView ()

@property (nonatomic, assign)BusinessType payType;
@property (nonatomic, copy)void (^btnClickBlock)(PayResultSelectType);

@end

@implementation PayResultView

+ (void)showResult:(BOOL)isSuccess payType:(BusinessType)payType value:(double)value failReason:(NSString *)reason btnClick:(void (^)(PayResultSelectType))btnClickBlock {
    UIView *resultV = [PopupTool getPopupViewForClass:self];
    if (!resultV) {
        dispatch_async(dispatch_get_main_queue(), ^{
            PayResultView *resultV = [[PayResultView alloc] init];
            resultV.payType = payType;
            resultV.btnClickBlock = btnClickBlock;
            [resultV createView:isSuccess value:value reason:reason];
        });
    }
}

- (void)createView:(BOOL)success value:(double)value reason:(NSString *)reason{
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:YES cover:YES];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(275, 240));
        make.center.equalTo(self.superview);
    }];
    [self layoutIfNeeded];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
    
    self.backgroundColor = [UIColor whiteColor];
    
    ///状态图片
    UIImageView *stateImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 80, 80)];
    stateImg.centerX = self.width/2.0;
    [self addSubview:stateImg];
    ///状态文字
    UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(10, stateImg.maxY+10, self.width-20, 28)];
    stateLab.font = [UIFont systemFontOfSize:20];
    stateLab.textColor = kRGBA_COLOR(@"#333333", 1.0);
    stateLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:stateLab];
    ///详细文字
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10, stateLab.maxY+10, self.width-20, 19)];
    detailLab.font = [UIFont systemFontOfSize:13];
    detailLab.textColor = kRGBA_COLOR(@"#666666", 1.0);
    detailLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:detailLab];
    ///线
    UIView *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height-51, self.width, 1.0)];
    line.backgroundColor = kRGBA_COLOR(@"#EEEEEE", 1.0);
    [self addSubview:line];
    ///取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:0];
    [cancelBtn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:kRGBA_COLOR(@"#999999", 1.0) forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, line.maxY, success?0:self.width/2.0, 50);
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    ///确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:0];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.frame = CGRectMake(cancelBtn.maxX, line.maxY, success?self.width:self.width/2.0, 50);
    [sureBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
    [self addSubview:sureBtn];
    
    ///成功
    if (success) {
        stateImg.image = [UIImage imageNamed:@"payment_result_successful"];
        [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
        if (self.payType == BusinessTypeGuard) {
            stateLab.text = kLocalizationMsg(@"开通守护成功!");
        }else{
            stateLab.text = kLocalizationMsg(@"支付成功!");
        }
        
        if (self.payType == BusinessTypeCharge) {
            detailLab.text = [NSString stringWithFormat:kLocalizationMsg(@"您已成功充值%.0lf金币"),value];
        }
        [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-30-10, 10, 30, 30)];
        [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
        [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        [closeBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
    }else{ ///失败
        stateImg.image = [UIImage imageNamed:@"payment_result_failed"];
        [sureBtn setTitle:kLocalizationMsg(@"重新支付") forState:UIControlStateNormal];
        stateLab.text = kLocalizationMsg(@"支付失败!");
        if(self.payType == BusinessTypeGuard){
            detailLab.text = [NSString stringWithFormat:kLocalizationMsg(@"只差一步就能守护Ta了哦～")];
        }else{
            if (reason.length) {
                detailLab.text = kStringFormat(kLocalizationMsg(@"%@,请重新支付"),reason);
            }else{
                detailLab.text = kLocalizationMsg(@"支付失败,请重新支付");
            }
        }
        [sureBtn addTarget:self action:@selector(againBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)cancelClick{
    if(self.btnClickBlock){
        self.btnClickBlock(PayResultSelectCancel);
    }
    [[PopupTool share] closePopupView:self];
}

- (void)sureBtnClick{
    if(self.btnClickBlock){
        self.btnClickBlock(PayResultSelectSuccess);
    }
    [[PopupTool share] closePopupView:self];
}

- (void)againBtnClick{
    if(self.btnClickBlock){
        self.btnClickBlock(PayResultSelectAgain);
    }
    [[PopupTool share] closePopupView:self];
}

@end
