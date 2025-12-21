//
//  RefundOrderCheckVc.m
//  Shopping
//
//  Created by yww on 2020/11/14.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RefundOrderCheckVc.h"
 
#import <LibProjView/ForceAlertController.h>

#import <LibProjModel/HttpApiShopQuiteOrder.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
 
@interface RefundOrderCheckVc ()<UITextFieldDelegate>
@property (nonatomic, strong)ShopBusinessOrderModel *model;
@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, strong)UITextField *reduseResonTextF;
@end

@implementation RefundOrderCheckVc
- (instancetype)initWithModel:(ShopBusinessOrderModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB_COLOR(@"#DDDDDD");
    self.navigationItem.title = kLocalizationMsg(@"审核退款申请");
    [self.view addSubview:self.scrollV];
    [self creatUI];
}
- (void)creatUI{
    CGFloat scrollH = 5;
    for (int i = 0; i < 4; i ++) {
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+50*i, 100, 20)];
        titleL.textColor = kRGB_COLOR(@"#666666");
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentLeft;
        NSString *title;
        if (i == 0) {
            title = kLocalizationMsg(@"退款类型");
        }else if (i == 1){
            title = kLocalizationMsg(@"退款原因");
        }else if (i == 2){
            title = kLocalizationMsg(@"退款金额");
        }else{
            title = kLocalizationMsg(@"备注");
        }
        titleL.text = title;
        [self.scrollV addSubview:titleL];
        
        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(titleL.maxX, 0, kScreenWidth-20-100, 40)];
        contentL.centerY = titleL.centerY;
        contentL.textColor = kRGB_COLOR(@"#333333");
        contentL.font = [UIFont systemFontOfSize:14];
        contentL.numberOfLines = 0;
        contentL.textAlignment = NSTextAlignmentRight;
        NSString *content;
        if (i == 0) {
            content = self.model.refundType == 1?kLocalizationMsg(@"仅退款"):kLocalizationMsg(@"退货退款(已收到货)");
        }else if (i == 1){
            content = self.model.reason;
        }else if (i == 2){
            content = [NSString stringWithFormat:@"%.2f",self.model.transactionAmount];
        }else{
            content = self.model.refundNotes.length > 0?self.model.refundNotes:kLocalizationMsg(@"暂无");
        }
        contentL.text = content;
        [self.scrollV addSubview:contentL];
        scrollH += 50;
    }
    
    if (self.model.refundNotesImages.length > 0) {
        NSArray *imageArr = [self.model.refundNotesImages componentsSeparatedByString:@","];
        if (imageArr.count > 0) {
            scrollH += 60;
            UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+50*4, 100, 20)];
            titleL.textColor = kRGB_COLOR(@"#666666");
            titleL.font = [UIFont systemFontOfSize:14];
            titleL.textAlignment = NSTextAlignmentLeft;
            titleL.text = kLocalizationMsg(@"凭证");
            [self.scrollV addSubview:titleL];
            CGFloat width = (kScreenWidth-40)/3.0;
            int num = (int)imageArr.count;
            if (num > 3) {
                num = 3;
            }
            scrollH += width;
            for (int i = 0 ; i < imageArr.count; i++) {
                NSString *imageUrl = imageArr[i];
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*(width+10),10+titleL.maxY, width, width)];
                imageV.layer.cornerRadius = 6;
                imageV.clipsToBounds = YES;
                [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
                imageV.contentMode = UIViewContentModeScaleAspectFill;
                [self.scrollV addSubview:imageV];
            }
        }
    }
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, scrollH +20 , kScreenWidth-20, 40)];
    agreeBtn.backgroundColor = kRGB_COLOR(@"#FC8F3A");
    agreeBtn.layer.cornerRadius = 20;
    agreeBtn.clipsToBounds = YES;
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [agreeBtn setTitle:kLocalizationMsg(@"同意退款申请") forState:UIControlStateNormal];
    [agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scrollH += 60;
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollV addSubview:agreeBtn];
    
    UIButton *refuseBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, agreeBtn.maxY+20 , kScreenWidth-20, 40)];
    refuseBtn.backgroundColor = [UIColor whiteColor];
    refuseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    refuseBtn.layer.cornerRadius = 20;
    refuseBtn.clipsToBounds = YES;
    refuseBtn.layer.borderWidth = 0.5;
    refuseBtn.layer.borderColor = kRGB_COLOR(@"#DDDDDD").CGColor;
    [refuseBtn setTitle:kLocalizationMsg(@"拒绝退款申请") forState:UIControlStateNormal];
    [refuseBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
    [refuseBtn addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollV addSubview:refuseBtn];
    scrollH += 60+kSafeAreaBottom;
    self.scrollV.contentSize = CGSizeMake(kScreenWidth, scrollH);
}
- (void)agreeBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"同意退款申请") message:kLocalizationMsg(@"确认同意退款申请?")];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
        [weakself chekWithIsAgree:YES refuseReson:nil];
    }];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)refuseBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"拒绝退款申请") message:@""];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = kRGB_COLOR(@"#333333");
        textField.placeholder = kLocalizationMsg(@"请填写拒绝原因");
        textField.delegate = self;
        weakself.reduseResonTextF = textField;
    }];
    [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
    [alert addOptions:kLocalizationMsg(@"确定") textColor:ForceAlert_OrangeColor clickHandle:^{
        if (weakself.reduseResonTextF.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写拒绝原因")];
        }else{
            [weakself chekWithIsAgree:NO refuseReson:weakself.reduseResonTextF.text];
        }
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)chekWithIsAgree:(BOOL)isAgree refuseReson:(NSString *)reson{
    kWeakSelf(self);
    [HttpApiShopQuiteOrder refundAudit:self.model.id_field reason:isAgree?@"":self.reduseResonTextF.text state:isAgree?1:2 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 

#pragma mark - lazy
- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0,5, kScreenWidth, kScreenHeight-5)];
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.backgroundColor = [UIColor whiteColor];
    }
    return _scrollV;
}

#pragma mark - UITfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.reduseResonTextF) {
        NSString *str = [NSString stringWithFormat:@"%@%@", textField.text, string];
        if (str.length > 50){
            textField.text = [str substringToIndex:50];
            return NO;
        }
        return YES;
    }
    return YES;
}
 
@end
