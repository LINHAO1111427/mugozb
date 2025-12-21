//
//  VideoGuideView.m
//  ShortVideo
//
//  Created by KLC on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "VideoGuideView.h"
#import <LibTools/LibTools.h>

@interface VideoGuideView()<UIGestureRecognizerDelegate>
@property (nonatomic, assign)VideoGuideType guideType;
@end

@implementation VideoGuideView
+ (void)showIn:(UIView *)superV type:(VideoGuideType)guideType{
    if (guideType == videoGuideTypeDynamic) {
        BOOL notfirstDynamic = [[NSUserDefaults standardUserDefaults] boolForKey:@"dynamicFirstInComplete"];
        if (notfirstDynamic) {
            return;
        }
    }
    if (guideType == videoGuideTypeShortVideo) {
        BOOL notfirstShortVideo = [[NSUserDefaults standardUserDefaults] boolForKey:@"shortVdieoFirstInComplete"];
        if (notfirstShortVideo) {
            return;
        }
    }
    VideoGuideView *guideView = [[VideoGuideView alloc]initWithFrame:superV.bounds];
    guideView.backgroundColor = kRGBA_COLOR(@"#000000", 0.4);
    guideView.userInteractionEnabled = YES;
    guideView.guideType = guideType;
    //点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:guideView action:@selector(guideTap)];
    [guideView addGestureRecognizer:tap];
    //滑动
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:guideView action:@selector(guideSwip)];
    swip.delegate = guideView;
    [guideView addGestureRecognizer:swip];
    
    [superV insertSubview:guideView atIndex:10];
    
    
    UIImageView *guideImgUp  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 60, 70)] ;
    guideImgUp.image = [UIImage imageNamed:@"video_guide_up"];
    guideImgUp.centerX = guideView.centerX;
    [guideView addSubview:guideImgUp];
    
    
    UILabel *guideTipLabelUp = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImgUp.maxY+10, kScreenWidth-24, 20)];
    guideTipLabelUp.textAlignment = NSTextAlignmentCenter;
    guideTipLabelUp.font = [UIFont systemFontOfSize:14];
    guideTipLabelUp.textColor = [UIColor whiteColor];
    guideTipLabelUp.text = kLocalizationMsg(@"上滑切换上一个视频");
    guideTipLabelUp.centerX = guideImgUp.centerX;
    [guideView addSubview:guideTipLabelUp];
    
    
    UIImageView *guideImgDown  =[[UIImageView alloc]initWithFrame:CGRectMake(0,kScreenHeight-kNavBarHeight-120-30-kTabBarHeight, 60, 70)] ;
    guideImgDown.image = [UIImage imageNamed:@"userinfo_guide_down"];
    guideImgDown.centerX = guideView.centerX;
    [guideView addSubview:guideImgDown];
    
    
    UILabel *guideTipLabelDown = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImgDown.maxY+10, kScreenWidth-24, 20)];
    guideTipLabelDown.textAlignment = NSTextAlignmentCenter;
    guideTipLabelDown.font = [UIFont systemFontOfSize:14];
    guideTipLabelDown.textColor = [UIColor whiteColor];
    guideTipLabelDown.text = kLocalizationMsg(@"下滑切换下一个视频");
    guideTipLabelDown.centerX = guideImgDown.centerX;
    [guideView addSubview:guideTipLabelDown];
    
    
}
- (void)guideTap{
    if (self.guideType == videoGuideTypeDynamic) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"dynamicFirstInComplete"];
    }else if (self.guideType == videoGuideTypeShortVideo){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"shortVdieoFirstInComplete"];
    }
    [self removeAllSubViews];
    [self removeFromSuperview];
}
- (void)guideSwip{
    if (self.guideType == videoGuideTypeDynamic) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"dynamicFirstInComplete"];
    }else if (self.guideType == videoGuideTypeShortVideo){
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"shortVdieoFirstInComplete"];
    }
    [self removeAllSubViews];
    [self removeFromSuperview];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    [self guideSwip];
    return YES;
}
@end
