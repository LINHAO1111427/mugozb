//
//  AccountDisabledHud.m
//  LibProjView
//
//  Created by klc on 2020/8/21.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "AccountDisabledHud.h"
#import <LibProjBase/PopupTool.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/CustomerServiceSettingModel.h>
#import <LibTools/LibTools.h>

@interface AccountDisabledHud ()

kStrong(UILabel, titleLab)

kStrong(UILabel, msgLab)

/**禁用天数*/
@property(nonatomic,copy)NSString *disableTitle;

/**禁用理由*/
@property(nonatomic,copy)NSString  *disableMsg;

@property(nonatomic,assign)BOOL  isDisableMe;//是否是禁用自己

@end


@implementation AccountDisabledHud


+ (void)shareDisable:(NSString *)str{
    
    UIView *shareV = [PopupTool getPopupViewForClass:AccountDisabledHud.class];
    if (!shareV) {
        AccountDisabledHud *hudView = [[AccountDisabledHud alloc] initWithFrame:CGRectMake(0, 0, 280, 320)];
               
        [[PopupTool share] createPopupViewWithLinkView:hudView allowTapOutside:NO];
        
//        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//        [window addSubview:hudView];
        
        hudView.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);

        __block BOOL isDisableMe = NO;
        CGSize viewSize = hudView.superview.size;
        hudView.frame = CGRectMake((viewSize.width-280)/2.0, (viewSize.height-320)/2.0, 280, 320);
        NSData *jsonData = [str dataUsingEncoding:(NSUTF8StringEncoding)];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingFragmentsAllowed) error:nil];
        NSString *userIds = kStringFormat(@"%@",dic[@"userIds"]);
        NSArray<NSString *> *useridArr = [userIds componentsSeparatedByString:@","];
        if (useridArr.count > 0 && [ProjConfig userId] > 0) {
            [useridArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([str intValue]==[ProjConfig userId]) {
                    isDisableMe = YES;
                    *stop = YES;
                }
            }];
        }else{
            isDisableMe = YES;
        }

        hudView.isDisableMe = isDisableMe;
        hudView.disableTitle = dic[@"msg"];
        hudView.disableMsg = dic[@"reason"];
        [hudView setupSubViews];
    }
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 7;
    }
    return self;
}


-(void)setupSubViews{
    
    
    UIImageView *imv = [Maker Imv:ImgNamed(@"account_disabled") layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(40, 54, 180, 54));
        make.size.mas_equalTo(SIZE(172, 100));
    }];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:ImgNamed(@"present_close") forState:0];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(12);
        make.right.equalTo(self).inset(12);
    }];
    [closeBtn addTarget:self action:@selector(closeClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:_disableTitle textColor:[UIColor blackColor] font:kFont(14) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(imv.mas_bottom).offset(22);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).inset(30);
    }];
    
    _msgLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:_disableMsg textColor:kRGB_COLOR(@"#333333") font:kFont(13) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(15);
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).inset(30);
    }];
    
    [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#DEDEDE") superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        
        make.bottom.equalTo(self).inset(45);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    if (self.isDisableMe) {
            UIView *line = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#DEDEDE") superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
                
                make.size.mas_equalTo(SIZE(1, 45));
                make.bottom.centerX.equalTo(self);
            }];
            UIButton *cancelBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"取消") textColor:kRGB_COLOR(@"#888888") font:kFont(13) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
                
                make.bottom.equalTo(self).inset(0);
                make.height.mas_equalTo(line.mas_height);
                make.left.equalTo(self).offset(0);
                make.right.equalTo(line);
            }];
            [cancelBtn addTarget:self action:@selector(closeClickAction:) forControlEvents:UIControlEventTouchUpInside];
             
            UIButton *appealBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"申诉") textColor:[UIColor blackColor] font:kFont(13) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
                
                make.bottom.equalTo(self).inset(0);
                make.right.equalTo(self).inset(0);
                make.height.mas_equalTo(line.mas_height);
                make.left.equalTo(line);
            }];
            [appealBtn addTarget:self action:@selector(appealClickAction:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            UIButton *cancelBtn = [Maker BtnWithShadow:NO backColor:[UIColor clearColor] text:kLocalizationMsg(@"我知道了") textColor:kRGB_COLOR(@"#888888") font:kFont(13) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
                
                make.bottom.equalTo(self).inset(0);
                make.height.mas_equalTo(45);
                make.left.equalTo(self).offset(0);
                make.right.equalTo(self).inset(0);
            }];
            [cancelBtn addTarget:self action:@selector(closeClickAction:) forControlEvents:UIControlEventTouchUpInside];
        }
}


-(void)closeClickAction:(UIButton *)sender{
//    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
    [self removeFromSuperview];
}
-(void)appealClickAction:(UIButton *)sender{
//    [self removeFromSuperview];
    [[PopupTool share] closePopupView:self];
    [self removeFromSuperview];
    
    [RouteManager routeForName:RN_Base_BannedTheAppeal currentC:[ProjConfig currentVC]];
    
}

@end
