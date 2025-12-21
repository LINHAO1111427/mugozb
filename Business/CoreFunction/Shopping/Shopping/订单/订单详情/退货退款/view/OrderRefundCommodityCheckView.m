//
//  OrderRefundCommodityCheckView.m
//  Shopping
//
//  Created by yww on 2020/11/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderRefundCommodityCheckView.h"
@interface OrderRefundCommodityCheckView ()<UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, copy)OrderCommodityRefundCallBack callBack;
@property (nonatomic, strong)UIButton *agreeBtn;
@property (nonatomic, strong)UIButton *refuseBtn;
@property (nonatomic, strong)UILabel *contentL;
@property (nonatomic, strong)UITextView *refuseReasonTextF;
@property (nonatomic, assign)BOOL isAgree;
@end
@implementation OrderRefundCommodityCheckView

+ (void)showOrderLogisticsRefundViewCallBack:(OrderCommodityRefundCallBack)callBack{
    CGFloat width = kScreenWidth-100;
    CGFloat height = 260;
    OrderRefundCommodityCheckView  *showView = [[OrderRefundCommodityCheckView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight)];
    showView.backgroundColor = kRGBA_COLOR(@"#000000", 0.2);
    showView.callBack = callBack;
    showView.isAgree = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:showView action:@selector(tap)];
    tap.delegate = showView;
    [showView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:showView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.center = showView.center;
    contentView.layer.cornerRadius = 10;
    contentView.clipsToBounds = YES;
    [showView insertSubview:contentView atIndex:0];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, width-20, 20)];
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont boldSystemFontOfSize:15];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.text = kLocalizationMsg(@"货物审核");
    [contentView addSubview:titleL];
    
    CGFloat w = (width-90)/2.0;
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, titleL.maxY+20, w, 40)];
    agreeBtn.selected = YES;
    [agreeBtn setImage:[UIImage imageNamed:@"shop_icon_agree_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"shop_icon_agree_selected"] forState:UIControlStateSelected];
    [agreeBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateSelected];
    [agreeBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [agreeBtn setTitle:kLocalizationMsg(@"同意退款") forState:UIControlStateNormal];
    showView.agreeBtn = agreeBtn;
    [agreeBtn addTarget:showView  action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:agreeBtn];
    
    UIButton *refuseBtn = [[UIButton alloc]initWithFrame:CGRectMake(30+agreeBtn.maxX, titleL.maxY+20, w, 40)];
    [refuseBtn setImage:[UIImage imageNamed:@"shop_icon_agree_normal"] forState:UIControlStateNormal];
    [refuseBtn setImage:[UIImage imageNamed:@"shop_icon_agree_selected"] forState:UIControlStateSelected];
    [refuseBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateSelected];
    [refuseBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    refuseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    showView.refuseBtn = refuseBtn;
    [refuseBtn setTitle:kLocalizationMsg(@"拒绝退款") forState:UIControlStateNormal];
    [refuseBtn addTarget:showView  action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:refuseBtn];
    
    UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(10, agreeBtn.maxY+20, width-20, 60)];
    contentL.textColor = kRGB_COLOR(@"#666666");
    contentL.font = [UIFont systemFontOfSize:13];
    contentL.textAlignment = NSTextAlignmentCenter;
    contentL.numberOfLines = 0;
    contentL.text = kLocalizationMsg(@"已收到买家的退货，并退款给买家");
    showView.contentL = contentL;
    [contentView addSubview:contentL];
    
    UITextView *refuseTextV = [[UITextView alloc]initWithFrame:CGRectMake(30, agreeBtn.maxY+10, width-60, 80)];
    refuseTextV.textColor = kRGB_COLOR(@"#666666");
    refuseTextV.layer.cornerRadius = 10;
    refuseTextV.clipsToBounds = YES;
    refuseTextV.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    refuseTextV.font = [UIFont systemFontOfSize:13];
    refuseTextV.delegate = showView;
    refuseTextV.textAlignment = NSTextAlignmentLeft;
    refuseTextV.placeholderColor = kRGB_COLOR(@"#999999");
    refuseTextV.placeholder = kLocalizationMsg(@"请填写拒绝的原因");
    refuseTextV.hidden = YES;
    showView.refuseReasonTextF = refuseTextV;
    [contentView addSubview:refuseTextV];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, contentL.maxY+25, width, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#EEEEEE");
    [contentView addSubview:line];
    
    CGFloat W = (width-24*3)/2.0;
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(24, line.maxY+10,W,40)];
    [cancelBtn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [cancelBtn addTarget:showView action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(24+cancelBtn.maxX, line.maxY+10,W,40)];
    [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    [sureBtn addTarget:showView action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sureBtn];
}
- (void)agreeBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.isAgree = YES;
    self.refuseReasonTextF.hidden = YES;
    self.contentL.hidden = NO;
    self.refuseBtn.selected = NO;
}
 
- (void)refuseBtnClick:(UIButton *)btn{
    btn.selected = YES;
    self.isAgree = NO;
    self.refuseReasonTextF.hidden = NO;
    self.contentL.hidden = YES;
    self.agreeBtn.selected = NO;
}

- (void)cancelBtnClick:(UIButton *)btn{
    self.callBack(YES,NO,nil,self);
    [self removeAllSubViews];
    [self removeFromSuperview];
}
 
- (void)sureBtnClick:(UIButton *)btn{
    if (self.isAgree) {
        self.callBack(NO,self.isAgree,nil,self);
    }else{
        if (self.refuseReasonTextF.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写拒绝原因")];
            return;
        }
        self.callBack(NO,self.isAgree,self.refuseReasonTextF.text,self);
    }
     
    [self removeAllSubViews];
    [self removeFromSuperview];
}
- (void)tap{
    [self endEditing:YES];
}
#pragma mark - textviewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView == self.refuseReasonTextF) {
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
        if (str.length > 50){
            textView.text = [str substringToIndex:50];
            return NO;
        }
        return YES;
    }
    return YES;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    return YES;
}
@end
