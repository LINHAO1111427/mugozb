//
//  AnchorAuthorityStatusTipView.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/8.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "AnchorAuthorityStatusTipView.h"
#import <LibProjView/FunctionSheetBaseView.h>

@interface AnchorAuthorityStatusTipView()
@property (nonatomic, copy)AnchorAuthStatusTipCallBack callBack;
@property (nonatomic, copy)NSString *imageStr;// 图
@property (nonatomic, strong)NSArray *viewArray;
@end

@implementation AnchorAuthorityStatusTipView

+ (void)showAnchorAuthStatusTipViewWith:(NSArray*)viewArray imageStr:(NSString *)imageStr callBack:(AnchorAuthStatusTipCallBack)callBack{
    __block AnchorAuthorityStatusTipView *showView = [[AnchorAuthorityStatusTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,220)];
    showView.callBack = callBack;
    showView.imageStr = imageStr;
    showView.viewArray = viewArray;
    showView.backgroundColor = [UIColor whiteColor];
    [FunctionSheetBaseView showView:showView cover:YES];
    [showView createUI];
}
- (void)createUI{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(45, 50, 120, 120)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = [UIImage imageNamed:self.imageStr];
    [self addSubview:imageV];
    
    
    ///显示的文字内容
    CGFloat y = 0;
    UIView *centerV = [[UIView alloc] initWithFrame:CGRectMake(imageV.maxX+30, 0, kScreenWidth-45-(imageV.maxX+30), 20)];
    [self addSubview:centerV];
    
    for (int i = 0; i < self.viewArray.count; i++) {
        NSDictionary *dic = self.viewArray[i];
        int type = [dic[@"type"] intValue];
        NSString *text = dic[@"text"];
        if (type == 0) {//标题
            if (text.length > 0) {
                UILabel *titeL = [[UILabel alloc]initWithFrame:CGRectMake(0, y, centerV.width, 20)];
                titeL.text = text;
                titeL.textAlignment = NSTextAlignmentLeft;
                titeL.font = [UIFont systemFontOfSize:17];
                titeL.textColor = kRGB_COLOR(@"#666666");
                [centerV addSubview:titeL];
                y = titeL.maxY;
            }
        }else if(type == 1){//提示
            if (text.length > 0) {
                y = (y>0)?y+10:y;
                UILabel *tipL = [[UILabel alloc]init];
                tipL.text = text;
                tipL.textAlignment = NSTextAlignmentLeft;
                tipL.font = [UIFont systemFontOfSize:14];
                tipL.numberOfLines = 0;
                tipL.textColor = kRGB_COLOR(@"#999999");
                [centerV addSubview:tipL];
                [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(centerV).offset(y);
                    make.left.right.equalTo(centerV);
                }];
                [tipL layoutIfNeeded];
                y = (y+tipL.height);
            }
        }else{//按钮
            UIButton *sureBtn = [UIButton buttonWithType:0];
            sureBtn.frame = CGRectMake(0, y+15, 110, 32);
            sureBtn.backgroundColor = kRGB_COLOR(@"");
            sureBtn.layer.cornerRadius = 16;
            sureBtn.clipsToBounds = YES;
            [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [sureBtn setBackgroundImage:[UIImage createImageSize:sureBtn.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
            sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [sureBtn setTitle:text forState:UIControlStateNormal];
            [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [centerV addSubview:sureBtn];
            y = sureBtn.maxY;
        }
    }
    centerV.height = y;
    centerV.centerY = imageV.centerY;
}

- (void)sureBtnClick:(UIButton *)btn{
    self.callBack(YES,self);
    [FunctionSheetBaseView deletePopView:self];
}
@end
