//
//  FamilyNoticeTipView.m
//  Family
//
//  Created by klc_sl on 2021/8/3.
//

#import "FamilyNoticeTipView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>

@implementation FamilyNoticeTipView

+ (void)show:(NSString *)content {
    
    UIView *popV = [PopupTool getPopupViewForClass:self];
    if (!popV) {
    
        FamilyNoticeTipView *infoV = [[FamilyNoticeTipView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*2/3.0, 0.1)];
        infoV.backgroundColor = [UIColor whiteColor];
        infoV.layer.cornerRadius = 10;
        infoV.layer.masksToBounds = YES;
        [[PopupTool share] createPopupViewWithLinkView:infoV allowTapOutside:YES cover:YES];
        
        UIView *headerV = [[UIView alloc] init];
        [infoV addSubview:headerV];
        [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(infoV);
            make.height.mas_equalTo(60);
        }];
        [headerV layoutIfNeeded];
        {
            ///图标
            UIImageView *noticeIconV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_notice_yellow"]];
            noticeIconV.layer.masksToBounds = YES;
            noticeIconV.layer.cornerRadius = 7.5;
            [infoV addSubview:noticeIconV];
            [noticeIconV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.left.equalTo(infoV).offset(25);
                make.centerY.equalTo(headerV);
            }];
            [noticeIconV layoutIfNeeded];
            
            ///家族公告
            UILabel *titleL = [[UILabel alloc] init];
            titleL.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
            titleL.text = kLocalizationMsg(@"家族公告");
            titleL.textColor = [UIColor blackColor];
            [infoV addSubview:titleL];
            [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(noticeIconV.mas_right).offset(10);
                make.centerY.equalTo(noticeIconV);
            }];
            [titleL layoutIfNeeded];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(30, headerV.height-1.0, headerV.width-60, 1.0)];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [headerV addSubview:line];
        }
        
        UILabel *contentL = [[UILabel alloc] init];
        contentL.font = [UIFont systemFontOfSize:14];
        contentL.text = content;
        contentL.numberOfLines = 0;
        contentL.textColor = [UIColor darkGrayColor];
        [infoV addSubview:contentL];
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerV.mas_bottom).offset(25);
            make.left.equalTo(infoV).offset(25);
            make.right.equalTo(infoV).offset(-25);
        }];
        
        UIButton *sureBtn = [UIButton buttonWithType:0];
        [sureBtn setTitle:kLocalizationMsg(@"我知道了") forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
        sureBtn.layer.masksToBounds = YES;
        sureBtn.layer.cornerRadius = 20;
        [infoV addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentL);
            make.top.equalTo(contentL.mas_bottom).offset(20);
            make.bottom.equalTo(infoV).offset(-20);
            make.height.mas_equalTo(40);
        }];
        
        [sureBtn klc_whenTapped:^{
            [[PopupTool share] closePopupView:infoV];
        }];
        
        [infoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(infoV.superview);
            make.width.mas_equalTo(kScreenWidth*2/3.0);
            make.top.mas_equalTo(kNavBarHeight+50);
        }];
    }
}

@end
