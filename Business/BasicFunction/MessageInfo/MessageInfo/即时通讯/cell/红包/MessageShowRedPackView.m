//
//  MessageShowRedPackView.m
//  Message
//
//  Created by klc_sl on 2021/6/24.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MessageShowRedPackView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/KLCAppConfig.h>
#import "MessageContentObj.h"

@implementation MessageShowRedPackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIButton *btn = [UIButton buttonWithType:0];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(redBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    visualView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    visualView.userInteractionEnabled = NO;
    [self addSubview:visualView];
    visualView.alpha = 0.0;
    self.visualView = visualView;
    [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed:@"message_liaotian_redPack"];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgV];
    _imgV = imgV;
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(15);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:12];
    titleL.text = kLocalizationMsg(@"红包");
    [self addSubview:titleL];
    _titleL = titleL;
    [titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgV);
        make.top.equalTo(self.imgV.mas_bottom).offset(5);
    }];
    
    
    UILabel *openStatusL = [[UILabel alloc] init];
    openStatusL.textColor = [UIColor whiteColor];
    openStatusL.font = [UIFont systemFontOfSize:14];
    [self addSubview:openStatusL];
    _openStatusL = openStatusL;
    [openStatusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgV);
        make.left.equalTo(imgV.mas_right).offset(10);
        make.right.equalTo(self);
    }];
}

- (void)showRedPtInfo:(MessageRedPacketModel *)redPtInfo isOwn:(BOOL)isOwn{
    self.visualView.alpha = redPtInfo.redPtStatus>0?1.0:0.0;
    ///红包封面显示金币
    self.openStatusL.text = [NSString stringWithFormat:@"%.2lf%@", redPtInfo.redPacket.deductionAfterTotalValue,redPtInfo.redPacket.currencyType==1?kUnitStr:kLocalizationMsg(@"积分")];
    
//    switch (redPtInfo.redPtStatus) {
//        case 0:  ///未领取
//            self.openStatusL.text = kLocalizationMsg(@"待领取");
//            break;
//        case 1: ///领到了(表示本次打开红包)
//        case 2: ///已经领过了
//            self.openStatusL.text = kLocalizationMsg(@"已领取");
//            break;
//        case 3: ///红包领取完了
//            self.openStatusL.text = kLocalizationMsg(@"已被领完");
//            break;
//        case 4: ///红包过期了
//            self.openStatusL.text = kLocalizationMsg(@"已过期");
//            break;
//        default:
//            break;
//    }
}


- (void)redBtnClick{
    if (self.clickRedPt) {
        self.clickRedPt();
    }
}

@end
