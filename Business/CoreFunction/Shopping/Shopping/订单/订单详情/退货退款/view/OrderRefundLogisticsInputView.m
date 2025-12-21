//
//  OderRefundLogisticsInputView.m
//  Shopping
//
//  Created by yww on 2020/11/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderRefundLogisticsInputView.h"
#import <LibProjModel/HttpApiShopOrder.h>
#import <LibProjModel/ShopLogisticsDTOModel.h>
@interface OrderRefundLogisticsInputView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, copy)OrderLogisticsRefundCallBack callBack;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITextField *nameTextF;
@property (nonatomic, strong)UITextField *NumberTextF;
@property (nonatomic, strong)UIImageView *rightImageV;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *tableBackView;
@property (nonatomic, strong)UIButton *nameBtn;
 
@end

@implementation OrderRefundLogisticsInputView
+ (void)showOrderLogisticsRefundViewCallBack:(OrderLogisticsRefundCallBack)callBack{
    
    CGFloat width = kScreenWidth-100;
    CGFloat height = 270;
    OrderRefundLogisticsInputView  *showView = [[OrderRefundLogisticsInputView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight)];
    showView.backgroundColor = kRGBA_COLOR(@"#000000", 0.2);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:showView action:@selector(tap)];
    tap.delegate = showView;
    [showView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:showView];
    showView.callBack = callBack;
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.center = showView.center;
    contentView.layer.cornerRadius = 10;
    contentView.clipsToBounds = YES;
    [showView insertSubview:contentView atIndex:0];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, width-20, 20)];
    titleL.text = kLocalizationMsg(@"填写退回物流单号");
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont boldSystemFontOfSize:14];
    titleL.textColor = kRGB_COLOR(@"#333333");
    [contentView addSubview:titleL];
    
    
    //物流名字
    UILabel *logisticNameL = [[UILabel alloc]initWithFrame:CGRectMake(24, titleL.maxY+20, 100, 20)];
    logisticNameL.textAlignment = NSTextAlignmentLeft;
    logisticNameL.textColor = kRGB_COLOR(@"#333333");
    logisticNameL.font = [UIFont systemFontOfSize:14];
    logisticNameL.text = kLocalizationMsg(@"物流公司");
    [contentView addSubview:logisticNameL];
    
    UITextField *nameTextF = [[UITextField alloc]initWithFrame:CGRectMake(24, logisticNameL.maxY+5, width-48, 40)];
    nameTextF.layer.cornerRadius = 10;
    nameTextF.clipsToBounds = YES;
    nameTextF.layer.borderColor = kRGB_COLOR(@"#DDDDDD").CGColor;
    nameTextF.layer.borderWidth = 0.5;
    nameTextF.enabled = NO;
    nameTextF.placeholder = kLocalizationMsg(@"请选择快递公司");
    nameTextF.textColor = kRGB_COLOR(@"#333333");
    nameTextF.font = [UIFont systemFontOfSize:14];
    showView.nameTextF = nameTextF;
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, 12, 12)];
    rightImageV.contentMode = UIViewContentModeScaleAspectFit;
    rightImageV.image = [UIImage imageNamed:@"shopCart_arrow_down"];
    showView.rightImageV = rightImageV;
    [rightV addSubview:rightImageV];
    nameTextF.rightView = rightV;
    nameTextF.rightViewMode = UITextFieldViewModeAlways;
     
    UIView *nameLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    nameTextF.leftView = nameLeftV;
    nameTextF.leftViewMode = UITextFieldViewModeAlways;
    [contentView addSubview:nameTextF];
    
    UIButton *nameBtn = [[UIButton alloc]initWithFrame:CGRectMake(24, logisticNameL.maxY+10, width-48, 40)];
    nameBtn.backgroundColor = [UIColor clearColor];
    [nameBtn addTarget:showView action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    showView.nameBtn = nameBtn;
    [contentView addSubview:nameBtn];
    
    //物流单单
    UILabel *logisticsNOL = [[UILabel alloc]initWithFrame:CGRectMake(24, nameBtn.maxY+10, 100, 20)];
    logisticsNOL.textAlignment = NSTextAlignmentLeft;
    logisticsNOL.textColor = kRGB_COLOR(@"#333333");
    logisticsNOL.font = [UIFont systemFontOfSize:14];
    logisticsNOL.text = kLocalizationMsg(@"物流单号");
    [contentView addSubview:logisticsNOL];
    
    UITextField *numTextF = [[UITextField alloc]initWithFrame:CGRectMake(24, logisticsNOL.maxY+5, width-48, 40)];
    numTextF.layer.cornerRadius = 10;
    numTextF.clipsToBounds = YES;
    numTextF.layer.borderColor = kRGB_COLOR(@"#DDDDDD").CGColor;
    numTextF.layer.borderWidth = 0.5;
    numTextF.keyboardType = UIKeyboardTypeASCIICapable;
    numTextF.placeholder = kLocalizationMsg(@"请选填写物流单号");
    numTextF.textColor = kRGB_COLOR(@"#333333");
    numTextF.font = [UIFont systemFontOfSize:14];
    showView.NumberTextF = numTextF;
    UIView *numLeftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    numTextF.leftView = numLeftV;
    numTextF.leftViewMode = UITextFieldViewModeAlways;
    [contentView addSubview:numTextF];
     
    CGFloat W = (width-24*3)/2.0;
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(24, numTextF.maxY+20,W,40)];
    [cancelBtn setTitle:kLocalizationMsg(@"取消") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [cancelBtn addTarget:showView action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(24+cancelBtn.maxX, numTextF.maxY+20,W,40)];
    [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setTitleColor:kRGB_COLOR(@"#FC8F3A") forState:UIControlStateNormal];
    [sureBtn addTarget:showView action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sureBtn];
    
    //列表物流
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(74, nameTextF.maxY+contentView.y, width-48, height-nameTextF.maxY)];
    [backV shadowPathWith:kRGB_COLOR(@"#F4F4F4") shadowOpacity:0.5 shadowRadius:5 shadowSide:KLCShadowPathLeftRight shadowPathWidth:4];
    showView.tableBackView = backV;
    [showView addSubview:backV];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width-48, height-nameTextF.maxY)];
    table.hidden = YES;
    table.delegate = showView;
    table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    table.showsVerticalScrollIndicator = NO;
    table.dataSource = showView;
    showView.tableView = table;
    [backV addSubview:table];
     
}

- (void)cancelBtnClick:(UIButton *)btn{
    self.callBack(NO, nil, nil,self);
    [self removeAllSubViews];
    [self removeFromSuperview];
}

- (void)tap{
    [self endEditing:YES];
}

- (void)sureBtnClick:(UIButton *)btn{
    if (self.nameTextF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择物流")];
        return;
    }
    if (self.NumberTextF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写物流单号")];
        return;
    }
    self.callBack(YES, self.nameTextF.text, self.NumberTextF.text,self);
    [self removeAllSubViews];
    [self removeFromSuperview];
}

- (void)nameBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    btn.selected = !btn.selected;
    self.tableView.hidden = !btn.selected;
    self.tableBackView.hidden = !btn.selected;
    if (btn.selected) {
        self.rightImageV.image = [UIImage imageNamed:@"shopCart_arrow_up"];
    }else{
        self.rightImageV.image = [UIImage imageNamed:@"shopCart_arrow_down"];
    }
    if (btn.selected) {
        [HttpApiShopOrder getLogisticsList:^(int code, NSString *strMsg, ShopLogisticsDTOModel *model) {
            if (code == 1) {
                weakself.dataArray = model.logisticsList;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.tableView reloadData];
                });
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
     
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logisticesCell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logisticesCell"];
    }
    NSString *str =@"";
    if (indexPath.row < self.dataArray.count) {
        str = self.dataArray[indexPath.row];
    }
    cell.textLabel.textColor = kRGB_COLOR(@"#999999");
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text =str;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str =@"";
    if (indexPath.row < self.dataArray.count) {
        str = self.dataArray[indexPath.row];
    }
    self.nameTextF.text = str;
    self.tableView.hidden = YES;
    self.tableBackView.hidden = YES;
}

#pragma mark- UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]||[NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
        return NO;
    }
    return YES;
}
@end
