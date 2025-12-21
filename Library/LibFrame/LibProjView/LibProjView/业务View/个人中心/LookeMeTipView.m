//
//  LookeMeTipView.m
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import "LookeMeTipView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AppBackpackManageVOModel.h>

@interface LookeMeTipView()
@property (nonatomic, copy)LookeMeTipViewCallBack callBack;
@end
 
@implementation LookeMeTipView

+ (void)showLookeMeTipViewCallBack:(LookeMeTipViewCallBack)callBack{
    LookeMeTipView *showView = [[LookeMeTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    showView.callBack = callBack;
    
    CGFloat width = kScreenWidth*332/360.0;
    CGFloat height = width*400/332.0;
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tipView.userInteractionEnabled = YES;
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 8;
    tipView.center = showView.center;
    tipView.clipsToBounds = YES;
    [showView addSubview:tipView];
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    
    //bg
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 260*width/360.0)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:[KLCAppConfig appConfig].appBackpackManageVO.whoLooksAtMe]];
    bgImageView.layer.masksToBounds = YES;
    [tipView addSubview:bgImageView];
    
    
    //close
    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-45, 10, 30, 30)];
    [closeBtn setImage:[UIImage imageNamed:@"main_close_jinshan"] forState:UIControlStateNormal];
    [closeBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:closeBtn];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, bgImageView.maxY+(height-65-bgImageView.height-20)/2.0, width-20, 20)];
    tipLabel.text = kLocalizationMsg(@"开通贵族即可查看谁喜欢我");
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kRGB_COLOR(@"#666666");
    [tipView addSubview:tipLabel];
    
    //立即解锁
    UIButton *doBtn = [[UIButton alloc]initWithFrame:CGRectMake((width-155)/2.0, height-65,155, 40)];
    doBtn.layer.cornerRadius = 20;
    [doBtn setTitle:kLocalizationMsg(@"立即解锁") forState:UIControlStateNormal];
    [doBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doBtn setBackgroundImage:[UIImage createImageSize:doBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
    doBtn.clipsToBounds = YES;
    [doBtn addTarget:showView action:@selector(doBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tipView addSubview:doBtn];
}
-(void)closeBtnClick:(UIButton *)btn{
    [self removeAllSubViews];
    [self removeFromSuperview];
    self.callBack(YES);
}
-(void)doBtnClick:(UIButton *)btn{
    [self removeAllSubViews];
    [self removeFromSuperview];
    self.callBack(NO);
}
 
@end
