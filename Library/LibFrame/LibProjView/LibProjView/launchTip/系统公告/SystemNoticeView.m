//
//  SystemNoticeView.m
//  LibProjView
//
//  Created by klc on 2020/5/16.
//  Copyright © 2020 . All rights reserved.
//

#import "SystemNoticeView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <SDWebImage.h>
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/SysNoticModel.h>

@interface SystemNoticeView()
@property (nonatomic, copy)SystemNoticeCallback callBack;
@property (nonatomic, strong)SysNoticModel *notice;
@end

@implementation SystemNoticeView

+ (void)showSystemNoticeCallBack:(SystemNoticeCallback)block{
    [HttpApiUserController getSysNotic:^(int code, NSString *strMsg, SysNoticModel *model) {
        if (code == 1 && model.id_field > 0) {
            [SystemNoticeView checkData:model.id_field showType:model.showType showBlock:^(BOOL isShow) {
                if (isShow) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SystemNoticeView showSystemNoticeNowWithNotice:model callBack:block];
                    });
                }else{
                    if (block) {
                        block(NO, @"");
                    }
                }
            }];
        }else{
            if (block) {
                block(NO, @"");
            }
        }
    }];
}

+ (void)checkData:(int64_t)noticeId showType:(int)showType showBlock:(void(^)(BOOL isShow))block{
    switch (showType) {
        case 1: //每次都弹，不管公告一不一样
            if (block) {
                block(YES);
            }
            break;
        case 2:{ //每天弹一次
            //上一次弹框的数据
            NSDictionary *systemNoticeDic = [NSUserDefaults dictionaryForKey:@"systemNoticeShowData"];
            NSDate *beforeDate = systemNoticeDic[@"showDate"];
            
            if ([systemNoticeDic[@"noticeId"] longLongValue] != noticeId) {
                ///如果两个公告的ID不相等，直接显示
                if (block) {
                    block(YES);
                }
            }else{
                ///如果是相同公告，判断显示的日期
                //获取签日期的数据
                unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
                NSDateComponents *beforeC = [[NSCalendar autoupdatingCurrentCalendar] components:unitFlags fromDate:beforeDate];
                NSDateComponents *currentC = [[NSCalendar autoupdatingCurrentCalendar] components:unitFlags fromDate:[NSDate date]];
                
                if ((beforeC.year == currentC.year) && (beforeC.month == currentC.month) && (beforeC.day == currentC.day)) {
                    ///不显示
                    if (block) {
                        block(NO);
                    }
                    return;
                }else{
                    ///显示
                    if (block) {
                        block(YES);
                    }
                }
            }
        }
            break;
        default:
        {
            if (block) {
                block(NO);
            }
        }
            break;
    }
}


+ (void)showSystemNoticeNowWithNotice:(SysNoticModel*)notice callBack:(SystemNoticeCallback)callBack{
    
    {
        NSDictionary *dic = @{
            @"showDate":[NSDate date],
            @"noticeId":@(notice.id_field)
        };
        [NSUserDefaults setObject:dic forKey:@"systemNoticeShowData"];
    }

    SystemNoticeView *showView = [[SystemNoticeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    showView.layer.cornerRadius = 10;
    showView.clipsToBounds = YES;
    showView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    showView.callBack = callBack;
    showView.notice = notice;
    CGFloat width = 260.0*kScreenWidth/360;
    CGFloat height = width*334/260.0;
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    tipView.backgroundColor = [UIColor whiteColor];
    tipView.layer.cornerRadius = 8;
    tipView.center = showView.center;
    tipView.clipsToBounds = YES;
    [showView addSubview:tipView];
    [[PopupTool share] createPopupViewWithLinkView:showView allowTapOutside:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopupTool bringViewToFront:[SystemNoticeView class]];
    });
    
    ///内容
    {
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tipView.maxY+20, 40, 40)];
        closeBtn.centerX = tipView.centerX;
        [closeBtn setImage:[UIImage imageNamed:@"tip_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:showView action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.backgroundColor = [UIColor clearColor];
        [showView addSubview:closeBtn];
        
        if (notice.shape == 1) {//文字
            CGFloat scaleT = 260/60;
            CGFloat widthT = 260.0*kScreenWidth/360;
            CGFloat heightT = widthT/scaleT;
            UIImageView *tipTextipImageV = [[UIImageView alloc]initWithFrame:CGRectMake((width-widthT)/2.0,0, widthT, heightT)];
            tipTextipImageV.image = [UIImage imageNamed:@"system_tip_notice_header"];
            tipTextipImageV.contentMode = UIViewContentModeScaleAspectFill;
            [tipView addSubview:tipTextipImageV];
            
            UIImageView *bellImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, tipView.y-40, 80, 80)];
            bellImageV.centerX = showView.width/2.0;
            bellImageV.image = [UIImage imageNamed:@"system_notice_bell"];
            [showView addSubview:bellImageV];
            
            //公告
            UITextView *noticeTV = [[UITextView alloc]initWithFrame:CGRectMake(20, tipTextipImageV.maxY+10, width-40, height-tipTextipImageV.maxY-80)];
            noticeTV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
            noticeTV.textColor = kRGB_COLOR(@"#999999");
            noticeTV.font = [UIFont systemFontOfSize:14];
            noticeTV.textAlignment = NSTextAlignmentLeft;
            noticeTV.text = notice.content;
            noticeTV.selectable = NO;
            noticeTV.editable = NO;
            [tipView addSubview:noticeTV];
        }else{//图片
            CGFloat imgH = height-80;
            CGFloat imgW = width-16;
            UIImageView*imageV = [[UIImageView alloc]initWithFrame:CGRectMake((width-imgW)/2.0, 8,imgW, imgH)];
            imageV.clipsToBounds = YES;
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            [imageV sd_setImageWithURL:[NSURL URLWithString:notice.imageUrl] placeholderImage:PlaholderImage];
            [tipView addSubview:imageV];
        }
        
        
        //知道了按钮
        UIButton *kownBtn  = [[UIButton alloc]initWithFrame:CGRectMake((width-160)/2.0, height-60, 160, 40)];
        kownBtn.layer.cornerRadius = 20;
        kownBtn.clipsToBounds = YES;
        [kownBtn addTarget:showView action:@selector(kownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [kownBtn setBackgroundImage:[UIImage createImageSize:kownBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FE73E1"),kRGB_COLOR(@"#9A58FF")] percentage:@[@0.3,@1.0] gradientType:GradientFromLeftToRight] forState:UIControlStateNormal];
        [kownBtn setTitle:kLocalizationMsg(@"查看详情") forState:UIControlStateNormal];
        [kownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        kownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [tipView addSubview:kownBtn];
    }
}


- (void)closeBtnClick:(UIButton *)btn{
    self.callBack(NO,@"");
    [self removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}
- (void)kownBtnClick:(UIButton *)btn{
    
    self.callBack((self.notice.url.length > 0? YES:NO),self.notice.url);
    [self removeAllSubViews];
    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
}

@end
