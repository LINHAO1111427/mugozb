//
//  AddShippingAddressVC.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "AddOrModifyShippingAddressVC.h"
#import "ShoppingAddressSelectedView.h"
#import "SAProvinceModel.h"
#import <LibProjModel/HttpApiShopCar.h>
#import <LibProjModel/ShopAddressModel.h>

 

@interface AddOrModifyShippingAddressVC ()<UITextViewDelegate>

@property (nonatomic, strong)UITextField *acceptNameTextF;//收货人
@property (nonatomic, strong)UITextField *phoneNumTextF;//手机号码
@property (nonatomic, strong)UITextField *areaTextF;//所在地区
@property (nonatomic, strong)UIButton *areaBtn;
@property (nonatomic, strong)UITextView *detailAddressTextV;//详细地址
@property (nonatomic, strong)UISwitch *switchPro;
@property (nonatomic, strong)SASelctedModel *addressModel;
 
@end

@implementation AddOrModifyShippingAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.isModify boolValue]) {
        self.navigationItem.title = kLocalizationMsg(@"编辑收货地址");
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [deleteBtn setTitle:kLocalizationMsg(@"删除") forState:UIControlStateNormal];
        [deleteBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
        self.navigationItem.rightBarButtonItem = item;
    }else{
        self.navigationItem.title = kLocalizationMsg(@"添加收货地址");
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubView];
    if ([self.isModify boolValue]) {
        self.acceptNameTextF.text = self.modifyAddressModel.userName;
        self.phoneNumTextF.text = self.modifyAddressModel.phoneNum;
        self.areaTextF.text =  [NSString stringWithFormat:@"%@ %@ %@",self.modifyAddressModel.pro,self.modifyAddressModel.city,self.modifyAddressModel.area];
        self.detailAddressTextV.text = self.modifyAddressModel.address;
        self.switchPro.on = self.modifyAddressModel.isDefault;
        SASelctedModel *address = [[SASelctedModel alloc]init];
        address.areaName_one = self.modifyAddressModel.pro;
        address.areaName_two = self.modifyAddressModel.city;
        address.areaName_three = self.modifyAddressModel.area;
        self.addressModel = address;
    }
}
- (void)tap{
    [self.view endEditing:YES];
}
- (void)createSubView{
    //基本信息
    CGFloat y = 10;
    for (int i = 0;i<3; i++) {
        UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 10+i*50, kScreenWidth-24, 50)];
        y += 50;
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 60, 20)];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.textColor = kRGB_COLOR(@"#444444");
        titleL.font = [UIFont systemFontOfSize:14];
        [contentV addSubview:titleL];
        
        UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(titleL.maxX+10, 10, contentV.width-10-60, 40)];
        textF.textColor = kRGB_COLOR(@"#444444");
        textF.font = [UIFont systemFontOfSize:13];
        textF.textAlignment = NSTextAlignmentLeft;
        if (i == 0) {
            titleL.text = kLocalizationMsg(@"收货人");
            textF.placeholder = kLocalizationMsg(@"请填写收货人姓名");
            self.acceptNameTextF = textF;
        }else if (i == 1){
            titleL.text = kLocalizationMsg(@"手机号码");
            textF.keyboardType = UIKeyboardTypePhonePad;
            textF.placeholder = kLocalizationMsg(@"请填写收件人手机号");
            self.phoneNumTextF = textF;
        }else if (i == 2){
            titleL.text = kLocalizationMsg(@"所在地区");
            textF.placeholder = kLocalizationMsg(@"省市区县、乡镇等");
            textF.enabled = NO;
            UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 14, 14)];
            UIImageView *rihtImgV = [[UIImageView alloc]initWithFrame:CGRectMake(3, 0, 8, 14)];
            rihtImgV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
            [rightV addSubview:rihtImgV];
            textF.rightView = rightV;
            textF.rightViewMode = UITextFieldViewModeAlways;
            self.areaTextF = textF;
            
            UIButton *areaBtn = [[UIButton alloc]initWithFrame:textF.frame];
            areaBtn.backgroundColor = [UIColor clearColor];
            [areaBtn addTarget:self action:@selector(areaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentV addSubview:areaBtn];
        }
        [contentV addSubview:textF];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, contentV.width, 0.5)];
        line.backgroundColor =kRGB_COLOR(@"#DEDEDE");
        [contentV addSubview:line];
        [self.view addSubview:contentV];
    }
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, y+20, 60, 20)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.textColor = kRGB_COLOR(@"#444444");
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = kLocalizationMsg(@"详细地址");
    [self.view addSubview:titleL];
    
    UITextView *detailTextV = [[UITextView alloc]initWithFrame:CGRectMake(titleL.maxX+10, titleL.y+2, kScreenWidth-24-10-60, 80)];
    detailTextV.font = [UIFont systemFontOfSize:14];
    detailTextV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    detailTextV.textContainer.lineFragmentPadding = 0.0;
    detailTextV.placeholderColor = kRGB_COLOR(@"#9BA2AC");
    detailTextV.placeholder = kLocalizationMsg(@"街道、楼牌号等街道、楼牌号等街道、楼牌号等街道、楼牌号等");
    detailTextV.delegate = self;
    self.detailAddressTextV = detailTextV;
    [self.view addSubview:self.detailAddressTextV];
    y += 120;
    
    UIView *midV = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 10)];
    midV.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self.view addSubview:midV];
    y += 10;
    
    UILabel *defaultL = [[UILabel alloc]initWithFrame:CGRectMake(12, y+20, kScreenWidth-24-52, 20)];
    defaultL.textAlignment = NSTextAlignmentLeft;
    defaultL.textColor = kRGB_COLOR(@"#444444");
    defaultL.font = [UIFont systemFontOfSize:14];
    defaultL.text = kLocalizationMsg(@"设置默认地址");
    [self.view addSubview:defaultL];
    y += 40;
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(defaultL.x, defaultL.maxY, kScreenWidth-24-52, 20)];
    tipL.textColor = kRGB_COLOR(@"#999999");
    tipL.text = kLocalizationMsg(@"提示：每次下单会默认使用该地址");
    tipL.font = [UIFont systemFontOfSize:12];
    tipL.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tipL];
    UISwitch *switchPro = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-64, 0, 52, 26)];
    switchPro.on = YES;
    [switchPro addTarget:self action:@selector(switchProClick:) forControlEvents:UIControlEventValueChanged];
    switchPro.centerY = defaultL.centerY;
    self.switchPro = switchPro;
    [self.view addSubview:self.switchPro];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kScreenHeight-kSafeAreaBottom-kNavBarHeight-60, kScreenWidth-40, 40)];
    saveBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
    saveBtn.layer.cornerRadius = 20;
    saveBtn.clipsToBounds = YES;
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if ([self.isModify boolValue]) {
        [saveBtn setTitle:kLocalizationMsg(@"保存") forState:UIControlStateNormal];
    }else{
        [saveBtn setTitle:kLocalizationMsg(@"保存并使用") forState:UIControlStateNormal];
    }
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}
- (void)switchProClick:(UISwitch *)switchP{
   
}
- (void)areaBtnClick:(UIButton *)btn{
    [self.view endEditing:YES];
    kWeakSelf(self);
    [ShoppingAddressSelectedView showInSuperV:self.view height:(kScreenHeight-self.detailAddressTextV.y-kNavBarHeight) selectedModel:nil callBack:^(BOOL suceess, SASelctedModel * _Nonnull addressModel) {
        if (suceess) {
            weakself.addressModel= addressModel;
            NSString *str = [NSString stringWithFormat:@"%@ %@ %@",addressModel.areaName_one,addressModel.areaName_two,addressModel.areaName_three];
            weakself.areaTextF.text = str;
        }
    }];
}
- (void)saveBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字保存"));
    if (self.acceptNameTextF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写收货人")];
        return;
    }
    if (self.phoneNumTextF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填电话号码")];
        return;
    }
    if (self.areaTextF.text.length == 0 || !self.addressModel) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择地区")];
        return;
    }
    if (self.detailAddressTextV.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写详细地址")];
        return;
    }
    if ([self.isModify boolValue]) {
        [self modifyAddressNow];
    }else{
        [self addAddressWow];
    }
     
     
}
- (void)addAddressWow{
    kWeakSelf(self);
    int isDefault = self.switchPro.on;
    NSString *userName = self.acceptNameTextF.text;
    NSString *phoneNum = self.phoneNumTextF.text;
    NSString *address = self.detailAddressTextV.text;
    NSString *pro = self.addressModel.areaName_one.length > 0?self.addressModel.areaName_one:@"";
    NSString *city = self.addressModel.areaName_two.length > 0?self.addressModel.areaName_two:@"";
    NSString *area = self.addressModel.areaName_three.length > 0?self.addressModel.areaName_three:@"";
    [HttpApiShopCar saveAddress:address area:area city:city isDefault:isDefault phoneNum:phoneNum pro:pro userName:userName callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)modifyAddressNow{
    kWeakSelf(self);
    int isDefault = self.switchPro.on;
    int64_t addressId = self.modifyAddressModel.id_field;
    NSString *userName = self.acceptNameTextF.text;
    NSString *phoneNum = self.phoneNumTextF.text;
    NSString *address = self.detailAddressTextV.text;
    NSString *pro = self.addressModel.areaName_one.length > 0?self.addressModel.areaName_one:@"";
    NSString *city = self.addressModel.areaName_two.length > 0?self.addressModel.areaName_two:@"";
    NSString *area = self.addressModel.areaName_three.length > 0?self.addressModel.areaName_three:@"";
    [HttpApiShopCar updateShopAddress:address addressId:addressId area:area city:city isDefault:isDefault phoneNum:phoneNum pro:pro userName:userName callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
         if (code == 1) {
             [SVProgressHUD showSuccessWithStatus:strMsg];
             [weakself.navigationController popViewControllerAnimated:YES];
         }else{
             [SVProgressHUD showInfoWithStatus:strMsg];
         }
    }];
}
- (void)deleteBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    [HttpApiShopCar delShopAddress:self.modifyAddressModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
     
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length+text.length > 200) {
        return NO;
    }
    return YES;
}



@end
