//
//  O2OCallTypeSelectedView.m
//  LibProjView
//
//  Created by ssssssss on 2020/9/7.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "O2OCallTypeSelectedView.h"
#import <LibProjModel/ApiUsersLineModel.h>
#import <LibProjModel/KLCAppConfig.h>

@implementation O2OCallTypeParam
@end

@interface O2OCallTypeSelectedView ()<UIGestureRecognizerDelegate>
@property (nonatomic, copy)O2OCallTypeCallback callBack;
@property (nonatomic, strong)UIView *tipView;
@end

@implementation O2OCallTypeSelectedView

+ (void)showCallTypeViewWith:(O2OCallTypeParam *)param callBack:(O2OCallTypeCallback)callBack {
    NSString *userName = param.username;
    float voiceCoin = param.voiceCoin;
    float videoCoin = param.videoCoin;
    
    O2OCallTypeSelectedView *showView = [[O2OCallTypeSelectedView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    showView.callBack = callBack;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:showView action:@selector(tap)];
    [showView addGestureRecognizer:tap];
    tap.delegate = showView;
    [[UIApplication sharedApplication].keyWindow addSubview:showView];
    
    //tip
    UIView *tipView=  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 245, 230) ];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 10;
    tipView.center = showView.center;
    showView.tipView = tipView;
    [showView addSubview:tipView];
    
    //标题
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 225, 20)];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = kRGB_COLOR(@"#333333");
    NSString *title = [NSString stringWithFormat:kLocalizationMsg(@"请选择和 %@ 通话类型"),userName];
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc]initWithString:title];
    [titleAtt addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14 ]} range:NSMakeRange(5, userName.length)];
    titleL.attributedText = titleAtt;
    [tipView addSubview:titleL];
    
    for (int i = 0; i < 2; i++) {
         UIView *callView  = [[UIView alloc]initWithFrame:CGRectMake(25, titleL.maxY+20+i*75, 195, 65)];
         callView.backgroundColor = kRGB_COLOR(@"#FFF8FF");
         callView.layer.cornerRadius = 10;
         callView.clipsToBounds = YES;
         [tipView addSubview:callView];
        
        UIImageView *imageV = [[UIImageView alloc ]initWithFrame:CGRectMake(28, 0, 30, 30)];
        imageV.centerY = callView.height/2.0;
        imageV.image = [UIImage imageNamed:i == 0?@"1v1_call_type_voice":@"1v1_call_type_video"];
        [callView addSubview:imageV];
        
        UILabel *callT = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX+20, 12.5, 245-50-28-28, 20)];
        callT.textColor = kRGB_COLOR(@"#333333");
        callT.textAlignment = NSTextAlignmentLeft;
        callT.font = [UIFont boldSystemFontOfSize:14];
        callT.text = i== 0?kLocalizationMsg(@"与TA通话"):kLocalizationMsg(@"与TA视频");
        [callView addSubview:callT];
        
        UILabel *priceL = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX+20, callT.maxY, 245-50-28-28, 20)];
        priceL.textAlignment = NSTextAlignmentLeft;
        priceL.font = [UIFont systemFontOfSize:12];
        priceL.textColor = kRGB_COLOR(@"#999999");
        if (i == 0) {
            priceL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.1f%@/分钟"),voiceCoin,[KLCAppConfig unitStr]];
        }else{
            priceL.text = [NSString stringWithFormat:kLocalizationMsg(@"%.1f%@/分钟"),videoCoin,[KLCAppConfig unitStr]];
        }
        
        ///显示金额并且邀请通话对象的角色是主播
        if ([KLCAppConfig showOtmCoin] && param.callUserRole == 1) {
            [callView addSubview:priceL];
        }else{
            callT.centerY = imageV.centerY;
        }
        
        UIButton *callBtn = [[UIButton alloc]initWithFrame:callView.bounds];
        callBtn.backgroundColor = [UIColor clearColor];
        callBtn.tag = i+1;
        [callBtn addTarget:showView action:@selector(callBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [callView addSubview:callBtn];
    }
}

- (void)callBtnClick:(UIButton *)btn{
    [self.tipView removeAllSubViews];
    [self removeAllSubViews];
    self.callBack( btn.tag,self);
}

- (void)tap{
    [self.tipView removeAllSubViews];
    [self removeAllSubViews];
    self.callBack( 0,self);
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]){
        return NO;
    }
    if (touch.view == self.tipView){
        return NO;
    }
    return YES;
}
@end
