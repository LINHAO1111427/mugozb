//
//  AgreementView.m
//  Shopping
//
//  Created by kalacheng on 2020/6/23.
//  Copyright © 2020 klc. All rights reserved.
//

#import "AgreementView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface AgreementView ()
@property(nonatomic,strong)UIButton *protocolLBtn;
 
@end
@implementation AgreementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    UIView *protocolV  = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 30)];
    [self addSubview:protocolV];
    protocolV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(protocolVTap)];
    [protocolV addGestureRecognizer:tap];
    
    CGFloat protocolLW = [kLocalizationMsg(@"点击按钮标识同意《官方小店入驻协议》") widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:20];
    UILabel *protocolL = [[UILabel alloc] initWithFrame:CGRectMake((protocolV.width - protocolLW)/2 + 14, 5, protocolLW + 8, 20)];
    protocolL.textAlignment = NSTextAlignmentLeft;
    protocolL.font = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:kLocalizationMsg(@"点击按钮标识同意《官方小店入驻协议》")];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(8, 10)];
    [str addAttribute:NSForegroundColorAttributeName value:kRGB_COLOR(@"#DC92F5") range:NSMakeRange(8, 10)];
    [str addAttribute:NSForegroundColorAttributeName value:kRGB_COLOR(@"#AAAAAA") range:NSMakeRange(0, 8)];
    protocolL.attributedText = str;
    [protocolV addSubview:protocolL];
    

    self.protocolLBtn = [[UIButton alloc] initWithFrame:CGRectMake(protocolL.x - 25 , 5, 18, 18)];
    self.protocolLBtn.selected = YES;
    [self.protocolLBtn setImage:nil forState:UIControlStateNormal];
    [self.protocolLBtn setImage:[UIImage imageNamed:@"shop_agree"] forState:UIControlStateSelected];
    [self.protocolLBtn addTarget:self action:@selector(protocolLBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.protocolLBtn.layer.borderColor = kRGB_COLOR(@"#AAAAAA").CGColor;
    self.protocolLBtn.layer.borderWidth = 0.3;
    [protocolV addSubview:self.protocolLBtn];
//    self.protocolLBtn.enabled = NO;
    
    UIButton *agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth -kScreenWidth *0.6)/2 , 45, kScreenWidth *0.6, 44)];
    [agreeBtn setTitle:kLocalizationMsg(@"我已阅读并同意协议") forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:agreeBtn];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    agreeBtn.layer.masksToBounds = YES;
    agreeBtn.layer.cornerRadius = 22;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = @[(__bridge id) kRGB_COLOR(@"#FB72E2").CGColor, (__bridge id) kRGB_COLOR(@"#9C58FE").CGColor];
    gradientLayer.locations  = @[@0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1.0, 0);
    gradientLayer.frame      = CGRectMake(0, 0, kScreenWidth *0.6, 44);
    gradientLayer.cornerRadius = 22;
    [agreeBtn.layer addSublayer:gradientLayer];
    [agreeBtn.layer insertSublayer:gradientLayer atIndex:0];

}

-(void)protocolLBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
}

-(void)protocolVTap{
    self.protocolLBtn.selected = !self.protocolLBtn.selected;
}

-(void)agreeBtnClick{
    
    
    if (YES == self.protocolLBtn.selected) {
        if (self.agreeBtnBlock) {
            self.agreeBtnBlock();
        }
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请同意《官方小店入驻协议》")];
    }
    
    
}


@end
