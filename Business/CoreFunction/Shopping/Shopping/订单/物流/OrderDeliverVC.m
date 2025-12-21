//
//  OrderDeliverVC.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDeliverVC.h"
#import "LogisticsIncSheetSelectedView.h"
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/ShopLogisticsDTOModel.h>
#import <LibProjModel/LogisticsBeanModel.h>
 
 
@interface OrderDeliverVC ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)UITextField *logisticsContentTF;
@property (nonatomic, strong)UITextField *wayBillContentTF;
@property (nonatomic, assign)int selectedIndex;
@property (nonatomic, strong)ShopLogisticsDTOModel *logisticsModel;
 
@end

@implementation OrderDeliverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"立即发货");
    self.selectedIndex = -1;
    [self creatSubv];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
- (void)creatSubv{
    
    //物流
    UILabel *logisticsTitleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, 60, 20)];
    logisticsTitleL.textColor = kRGB_COLOR(@"#444444");
    logisticsTitleL.font = [UIFont systemFontOfSize:14];
    logisticsTitleL.textAlignment = NSTextAlignmentLeft;
    logisticsTitleL.text = kLocalizationMsg(@"物流公司");
    [self.view addSubview:logisticsTitleL];
    
    UITextField *logisticsContentTF = [[UITextField alloc]initWithFrame:CGRectMake(logisticsTitleL.maxX+10, 0, kScreenWidth-24-10-60, 30)];
    logisticsContentTF.font= [UIFont systemFontOfSize:14];
    logisticsContentTF.centerY = logisticsTitleL.centerY;
    logisticsContentTF.enabled = NO;
    logisticsContentTF.textColor = kRGB_COLOR(@"#444444");
    logisticsContentTF.textAlignment = NSTextAlignmentLeft;
    logisticsContentTF.placeholder = kLocalizationMsg(@"请选择物流");
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
    UIImageView *rihtImgV = [[UIImageView alloc]initWithFrame:CGRectMake(3, 0, 8, 14)];
    rihtImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    [rightV addSubview:rihtImgV];
    logisticsContentTF.rightView = rightV;
    logisticsContentTF.rightViewMode = UITextFieldViewModeAlways;
    self.logisticsContentTF = logisticsContentTF;
    [self.view addSubview:self.logisticsContentTF];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(12, 49, kScreenWidth-24, 0.5)];
    line1.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.view addSubview:line1];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(logisticsTitleL.x, 0, kScreenWidth-24, 50)];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    //运单号
    UILabel *wayBillTitleL = [[UILabel alloc]initWithFrame:CGRectMake(12, line1.maxY+15, 60, 20)];
    wayBillTitleL.textColor = kRGB_COLOR(@"#444444");
    wayBillTitleL.font = [UIFont systemFontOfSize:14];
    wayBillTitleL.textAlignment = NSTextAlignmentLeft;
    wayBillTitleL.text = kLocalizationMsg(@"运单号码");
    [self.view addSubview:wayBillTitleL];
    
    UITextField *wayBillContentTF = [[UITextField alloc]initWithFrame:CGRectMake(logisticsTitleL.maxX+10, 0, kScreenWidth-24-10-60, 30)];
    wayBillContentTF.font= [UIFont systemFontOfSize:14];
    wayBillContentTF.centerY = wayBillTitleL.centerY;
    wayBillContentTF.textColor = kRGB_COLOR(@"#444444");
    wayBillContentTF.textAlignment = NSTextAlignmentLeft;
    wayBillContentTF.placeholder = kLocalizationMsg(@"请填写运单号");
    wayBillContentTF.keyboardType =  UIKeyboardTypeNumbersAndPunctuation;
    self.wayBillContentTF = wayBillContentTF;
    [self.view addSubview:self.wayBillContentTF];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(12, line1.maxY+49, kScreenWidth-24, 0.5)];
    line2.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.view addSubview:line2];
    
    //确认发货
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight-kNavBarHeight-kSafeAreaBottom-120, 280, 44)];
    sureBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 22;
    sureBtn.clipsToBounds = YES;
    sureBtn.centerX = kScreenWidth/2.0;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitle:kLocalizationMsg(@"确定发货") forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
}
 
- (void)btnClick:(UIButton *)btn{
    [self.wayBillContentTF resignFirstResponder];
    kWeakSelf(self);
    [HttpApiShopOrder getLogisticsList:^(int code, NSString *strMsg, ShopLogisticsDTOModel *model) {
        if (code == 1) {
            weakself.logisticsModel = model;
            [LogisticsIncSheetSelectedView  showInSuperV:self.view logisticsModel:model callBack:^(BOOL isSelected, NSInteger index) {
                if (isSelected) {
                    weakself.logisticsContentTF.text = model.logisticsList[index];
                    weakself.selectedIndex = index;
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)tap{
    [self.view endEditing:YES];
}
- (void)sureBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (self.selectedIndex < 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择物流")];
        return;
    }
    if (self.wayBillContentTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写运单号")];
        return;
    }
//    if (self.logisticsModel.logisticsBean.logisticCode.length == 0) {
//        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"物流单号不存在")];
//        return;
//    }
    [HttpApiShopOrder confirmSent:[self.order_id intValue] logisticsName:self.logisticsModel.logisticsList[self.selectedIndex] logisticsNum:self.wayBillContentTF.text callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        [SVProgressHUD showSuccessWithStatus:strMsg];
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }else{
        return YES;
    }
}
@end
