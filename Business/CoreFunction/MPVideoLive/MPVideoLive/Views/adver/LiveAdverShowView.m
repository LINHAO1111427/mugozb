//
//  LiveAdverShowView.m
//  MPVideoLive
//
//  Created by klc_sl on 2021/6/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LiveAdverShowView.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjView/KLCNetworkShowView.h>
#import <LibTools/LibTools.h>

@implementation LiveAdverShowView

+ (void)showUrl:(NSString *)url{
    
    UIView *showV = [PopupTool getPopupViewForClass:self];
    if (!showV) {
        LiveAdverShowView *showV = [[LiveAdverShowView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight/2.0+kSafeAreaBottom)];
        [[PopupTool share] createPopupViewWithLinkView:showV allowTapOutside:YES cover:NO];
        [showV createUI:url];
    }
}

- (void)createUI:(NSString *)url{
    
    KLCNetworkShowView *WebV = [[KLCNetworkShowView alloc] initWithFrame:self.bounds];
    [WebV loadCompleteLinks:url];
    [self addSubview:WebV];
    [WebV cornerRadii:CGSizeMake(25, 25) byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(kScreenWidth-40, -30, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"guanbi_circle_gray"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    closeBtn.userInteractionEnabled = NO;
    
    [[PopupTool share] animationShowPopupView:self];
}


@end
