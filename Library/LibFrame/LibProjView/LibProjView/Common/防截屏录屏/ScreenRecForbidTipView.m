//
//  ScreenRecForbidTipView.m
//  LibProjView
//
//  Created by ssssssss on 2020/11/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ScreenRecForbidTipView.h"
#import <LibProjBase/PopupTool.h>

@interface ScreenRecForbidTipView()
@property (nonatomic, strong)UILabel *tipL;
@end

@implementation ScreenRecForbidTipView


+ (void)showForbidTipView{
    ScreenRecForbidTipView *showView = [[ScreenRecForbidTipView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showView.backgroundColor = [UIColor blackColor];
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 40)];
    tipL.textColor = [UIColor whiteColor];
    tipL.numberOfLines = 0;
    tipL.center = showView.center;
    tipL.font = [UIFont systemFontOfSize:16];
    tipL.textAlignment = NSTextAlignmentCenter;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    tipL.text = [NSString stringWithFormat:kLocalizationMsg(@"对不起，【%@】禁止用户私自录屏，谢谢你的理解"),app_Name];
    showView.tipL = tipL;
    [showView addSubview:tipL];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
}

+ (void)DismissForbidTipView{
    UIView *showView = [PopupTool getPopupViewForClass:[ScreenRecForbidTipView class]];
    [showView removeAllSubViews];
    [[PopupTool share] closePopupView:showView];
}


@end
