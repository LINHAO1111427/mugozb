//
//  FreeCallTipView.m
//  LibProjView
//
//  Created by klc on 2020/6/3.
//  Copyright © 2020 . All rights reserved.
//

#import "FreeCallTipView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/OOORegisterCallVOModel.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/HttpApiUserController.h>


@interface FreeCallTipView()
 
@property (nonatomic, weak)UIView *tipView;
@property (nonatomic, weak)UIImageView *tipImagev;
@property (nonatomic, copy)FreeCallTipCallback callBack;
@end
@implementation FreeCallTipView

+ (void)showFreeCallTipWithComplete:(FreeCallTipCallback)callBack{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isFromLoginVc = [defaults boolForKey:@"isFromLoginVc"];
    if ([ProjConfig isContain1v1] && isFromLoginVc) {
        [defaults setBool:NO forKey:@"isFromLoginVc"];
        if ([KLCUserInfo isFirstLogin]) {
            [HttpApiUserController getUserByregister:[ProjConfig userId] callback:^(int code, NSString *strMsg, OOORegisterCallVOModel *model) {
                if (code == 1 && (model.registerCallSecond > 0 && model.registerCallTime > 0)) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [FreeCallTipView showFreeCallTipViewWith:model callBack:callBack];
                    });
                }else{
                    if (callBack) {
                        callBack(YES);
                    }
                }
            }];
        }else{
            if (callBack) {
                callBack(YES);
            }
        }
    }else{
        if (callBack) {
            callBack(YES);
        }
    }
}

+ (void)showFreeCallTipViewWith:(OOORegisterCallVOModel *)model callBack:(FreeCallTipCallback)callBack{
    
    FreeCallTipView *showView = [[FreeCallTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.callBack = callBack;
    [showView createView:model];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[FreeCallTipView class]];
    });
}

- (void)removeSelfView{
    [[PopupTool share] closePopupView:self];
    if (self.callBack) {
        self.callBack(YES);
    }
}

- (void)createView:(OOORegisterCallVOModel *)model{
    [[PopupTool share] createPopupViewWithLinkView:self allowTapOutside:NO popupBgViewAction:@selector(removeSelfView) popupBgViewTarget:self cover:YES];
    
    self.frame = CGRectMake(0, 0, 275, 400);
    self.centerX = self.superview.width/2.0;
    self.centerY = self.superview.height/2.0;
    
    UIImageView *tipImagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 275, 235)];
    tipImagev.image = [UIImage imageNamed:@"oto_free_giftbox"];
    [self addSubview:tipImagev];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tipImagev.maxY-15, 150, 35)];
    titleLabel.centerX = tipImagev.centerX;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightMedium];
    titleLabel.textColor = kRGB_COLOR(@"#FFFFFF");
    titleLabel.text = kLocalizationMsg(@"您已获得");
    [self addSubview:titleLabel];
    
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.maxY, self.width, self.height-titleLabel.maxY-40)];
    tipL.textAlignment = NSTextAlignmentCenter;
    tipL.textColor = kRGB_COLOR(@"#FFFFFF");
    tipL.numberOfLines = 0;
    tipL.font = [UIFont systemFontOfSize:14];
    tipL.text = [NSString stringWithFormat:kLocalizationMsg(@"· %d次时长为%d分钟的免费通话"),model.registerCallSecond,model.registerCallTime];
    [self addSubview:tipL];
    
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height-40, 40 , 40)];
    closeBtn.centerX = tipImagev.centerX;
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"oto_free_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
}
 
- (void)closeBtnClick:(UIButton *)btn{
    [self removeSelfView];
}

@end
