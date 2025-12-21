//
//  VersionTipView.m
//  LibProjView
//
//  Created by klc on 2020/5/20.
//  Copyright © 2020 . All rights reserved.
//

#import "VersionTipView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/HttpApiAppLogin.h>
#import <LibProjModel/ApiVersionModel.h>

@interface VersionTipView()

@property(nonatomic,strong)UIView *contentView;
@property (nonatomic, copy)VersionTipCallback callBack;
@property (nonatomic, strong)ApiVersionModel *versionModel;
@end
@implementation VersionTipView

- (UIView *)contentView{
    if (!_contentView) {
        CGFloat scale = 270/358.0;
        CGFloat scaleW = 270/360.0;
        CGFloat width = kScreenWidth*scaleW;
        CGFloat height = width/scale;
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2.0, (kScreenHeight-height)/2.0, width, height)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 10;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}


+ (void)showVersionTip:(VersionTipCallback)callBack{
    [HttpApiAppLogin getAppUpdateInfoNew:[IPhoneInfo appVersionNO] type:2 versionCode:[[IPhoneInfo appVersionBuild] intValue] callback:^(int code, NSString *strMsg, ApiVersionModel *model) {
        if (code == 1 && model) {
            if (model.isConstraint == -1) {
                if (callBack) {
                    callBack(YES, @"");
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [VersionTipView showVersionTipViewWith:model callBack:callBack];
                });
            }
        }else{
            if (callBack) {
                callBack(YES, @"");
            }
        }
    }];
}



+ (void)showVersionTipViewWith:(ApiVersionModel *)versionModel callBack:(VersionTipCallback)callBack{

    UIView *verionV = [PopupTool getPopupViewForClass:VersionTipView.class];
    if (verionV) {
        return;
    }
    
    VersionTipView *showView = [[VersionTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    showView.callBack = callBack;
    showView.versionModel = versionModel;
    [showView addSubview:showView.contentView];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[VersionTipView class]];
    });
    
    {
        //内容
        CGFloat scale = 270/150.0;
        CGFloat height = showView.contentView.width/scale;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , showView.contentView.width, height)];
        imageView.image = [UIImage imageNamed:@"version_update_bg"];
        [showView.contentView addSubview:imageView];
        
        UILabel *titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(22, 40, showView.contentView.width-44, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:22];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = kLocalizationMsg(@"发现新版本");
        [showView.contentView addSubview:titleLabel];
        UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 80, showView.contentView.width-44, 22)];
        versionLabel.textColor = [UIColor whiteColor];
        versionLabel.textAlignment = NSTextAlignmentLeft;
        versionLabel.font = [UIFont systemFontOfSize:14];
        
        versionLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"最新版本：%@"),versionModel.versionNo];
        [showView.contentView addSubview:versionLabel];
        CGFloat contentHeight = showView.contentView.height-height-60;
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, height, showView.contentView.width-40, contentHeight)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.numberOfLines = 0;
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.textColor = kRGB_COLOR(@"#666666");
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"更新内容：\n\n%@"),versionModel.des];
        [showView.contentView addSubview:contentLabel];
        
        CGFloat scale2 = 270/180.0;
        CGFloat btnW = showView.contentView.width/scale2;
        CGFloat x = (showView.contentView.width-btnW)/2.0;
        NSInteger num = 0;
        if (!versionModel.isConstraint) {//非强制更新
            btnW = 90;
            x = (showView.contentView.width-180)/3.0;
            num = 1;
            UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, showView.contentView.height - 60, btnW, 34)];
            cancelBtn.backgroundColor = [UIColor grayColor];
            cancelBtn.layer.cornerRadius = 17;
            cancelBtn.clipsToBounds = YES;
            [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancelBtn addTarget:showView action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cancelBtn setTitle:kLocalizationMsg(@"使用旧版") forState:UIControlStateNormal];
            [showView.contentView addSubview:cancelBtn];
        }
        
        UIButton *updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(x+(btnW+x)*num, showView.contentView.height - 60, btnW, 34)];
        updateBtn.backgroundColor = kRGB_COLOR(@"#A570FE");
        updateBtn.layer.cornerRadius = 17;
        updateBtn.clipsToBounds = YES;
        [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        updateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [updateBtn addTarget:showView action:@selector(updateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [updateBtn setTitle:kLocalizationMsg(@"立即更新") forState:UIControlStateNormal];
        [showView.contentView addSubview:updateBtn];
    }
}

- (void)updateBtnClick:(UIButton *)btn{
    NSString *versionUrl = [self.versionModel.url stringByTrimmingWhitespace];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:versionUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionUrl]];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"地址有误")];
    }
    if (!self.versionModel.isConstraint) {//非强制更新
        self.callBack(NO, self.versionModel.url);
        [self removeAllSubViews];
        [self removeFromSuperview];
        [[PopupTool share] closePopupView:self];
    }
}

- (void)cancelBtnClick:(UIButton *)btn{
    self.callBack(YES, @"");
    [self removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}

@end
