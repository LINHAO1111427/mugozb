//
//  LogisticsIncSheetSelectedView.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LogisticsIncSheetSelectedView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/ShopLogisticsDTOModel.h>
 
@interface LogisticsIncSheetSelectedView()
@property (nonatomic, copy)LogisticsCallBack callBack;
@property (nonatomic, strong)ShopLogisticsDTOModel *logisticModel;
@end

@implementation LogisticsIncSheetSelectedView
+ (void)showInSuperV:(UIView*)superV logisticsModel:(ShopLogisticsDTOModel*)model callBack:(LogisticsCallBack)callBack{
    LogisticsIncSheetSelectedView *showView = [[LogisticsIncSheetSelectedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,(model.logisticsList.count+1) *50+kSafeAreaBottom)];
    showView.logisticModel = model;
    showView.callBack = callBack;
    showView.backgroundColor = [UIColor whiteColor];
    [FunctionSheetBaseView showView:showView cover:YES];
    
    for (int i = 0; i < model.logisticsList.count+1; i++) {
        NSString *title ;
        if (i != model.logisticsList.count) {
            title = model.logisticsList[i];
        }else{
            title = kLocalizationMsg(@"取消");
        }
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12, i*50, kScreenWidth-24, 49)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:kRGB_COLOR(@"#3A3A3A") forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:showView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:btn];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, i*50-1, kScreenWidth-24, 0.5)];
        line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
        [showView addSubview:line];
    }
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == self.logisticModel.logisticsList.count) {
        self.callBack(NO, 0);
    }else{
        self.callBack(YES, btn.tag);
    }
    [FunctionSheetBaseView deletePopView:self];
}
@end
