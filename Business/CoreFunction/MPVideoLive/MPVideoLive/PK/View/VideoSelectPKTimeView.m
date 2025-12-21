//
//  VideoSelectPKTimeView.m
//  MPVideoLive
//
//  Created by klc_sl on 2021/2/25.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "VideoSelectPKTimeView.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiPublicLive.h>

@interface VideoSelectPKTimeView ()

@property (nonatomic, copy)NSArray<LivePkConfigurationVOModel *> *listArr;

@property (nonatomic, weak)UIButton *selectBtn;

@property (nonatomic, copy)void(^selectTimeBlock)(int64_t);

@end

@implementation VideoSelectPKTimeView

+ (void)showPkTime:(void (^)(int64_t pkTimeId))timeBlock{
    [HttpApiPublicLive getLivePkConfiguration:[LiveManager liveInfo].serviceLiveType callback:^(int code, NSString *strMsg, NSArray<LivePkConfigurationVOModel *> *arr) {
        if (code == 1) {
            if (arr.count > 0) {
                VideoSelectPKTimeView *pkV = [[VideoSelectPKTimeView alloc] init];
                pkV.listArr = arr;
                pkV.selectTimeBlock = timeBlock;
                [pkV createUI];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"暂无PK时间")];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (void)createUI{
    
    self.frame = CGRectMake(0, 0, kScreenWidth, 50);
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 20)];
    title.text = kLocalizationMsg(@"请选择PK时长");
    title.textColor = kRGBA_COLOR(@"#333333", 1.0);
    title.font = [UIFont systemFontOfSize:15];
    [self addSubview:title];
    
    CGFloat btnW = (self.width-30-46)/3.0;
    CGFloat btnH = 40;
    CGFloat maxY = title.maxY;
    for (int i = 0; i<self.listArr.count; i++) {
        LivePkConfigurationVOModel *vcModel = self.listArr[i];
        UIButton *selectBtn = [UIButton buttonWithType:0];
        selectBtn.frame = CGRectMake(15 + (btnW+23)*(i%3), 40+(btnH+15)*(i/3), btnW, btnH);
        [selectBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"%d分钟"),vcModel.pkTime] forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        selectBtn.layer.borderWidth = 1.0;
        selectBtn.layer.borderColor = kRGBA_COLOR(@"#F4F4F4", 1.0).CGColor;
        [selectBtn setTitleColor:kRGBA_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
        [selectBtn setTitleColor:kRGBA_COLOR(@"#FE5EC6", 1.0) forState:UIControlStateSelected];
        [selectBtn setBackgroundImage:[UIImage imageWithColor:kRGBA_COLOR(@"#F4F4F4", 1.0)] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageWithColor:kRGBA_COLOR(@"#FFF2FA", 1.0)] forState:UIControlStateSelected];
        selectBtn.layer.masksToBounds = YES;
        selectBtn.layer.cornerRadius = btnH/2.0;
        selectBtn.tag = 668552+i;
        [self addSubview:selectBtn];
        [selectBtn addTarget:self action:@selector(selectTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        maxY = selectBtn.maxY;
        
        if (i == 0) {
            [self selectTimeBtnClick:selectBtn];
        }
    }
    
    UIButton *sendPk = [UIButton buttonWithType:0];
    sendPk.frame = CGRectMake(15, maxY+25, self.width-30, 40);
    [sendPk setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sendPk setTitle:kLocalizationMsg(@"发起PK") forState:UIControlStateNormal];
    [sendPk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendPk addTarget:self action:@selector(startPKBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sendPk.layer.masksToBounds = YES;
    sendPk.layer.cornerRadius = btnH/2.0;
    [self addSubview:sendPk];
    
    self.height = sendPk.maxY+20;
    
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"主播PK") detailView:self cover:NO];
}

- (void)startPKBtnClick{
    if (!_selectBtn) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择PK时间")];
        return;
    }
    
    LivePkConfigurationVOModel *vcModel = self.listArr[_selectBtn.tag-668552];
    if (self.selectTimeBlock) {
        self.selectTimeBlock((int64_t)vcModel.id_field);
    }
    [FunctionSheetBaseView deletePopView:self];
}


- (void)selectTimeBtnClick:(UIButton *)clickBtn{
    clickBtn.selected = YES;
    clickBtn.layer.borderColor = kRGBA_COLOR(@"#FE5EC6", 1.0).CGColor;
    if (_selectBtn != clickBtn) {
        _selectBtn.selected = NO;
        _selectBtn.layer.borderColor = kRGBA_COLOR(@"#F4F4F4", 1.0).CGColor;
        _selectBtn = clickBtn;
    }
}

@end
