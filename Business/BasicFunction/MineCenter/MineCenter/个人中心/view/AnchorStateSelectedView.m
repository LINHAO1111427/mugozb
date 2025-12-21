//
//  AnchorStateSelectedView.m
//  MineCenter
//
//  Created by ssssssss on 2020/9/25.
//

#import "AnchorStateSelectedView.h"
#import <LibProjView/FunctionSheetBaseView.h>

@interface AnchorStateSelectedView ()
@property (nonatomic, copy)StateSelectedCallback callBack;
@end

@implementation AnchorStateSelectedView
+ (void)showAnchorStateSelectedViewWith:(int)state CallBack:(StateSelectedCallback)callback{
    AnchorStateSelectedView *showView = [[AnchorStateSelectedView  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200+kSafeAreaBottom)];
    showView.backgroundColor = [UIColor whiteColor];
    showView.callBack = callback;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path =  [UIBezierPath bezierPathWithRoundedRect:showView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)].CGPath;
    showView.layer.mask = shapeLayer;
    [FunctionSheetBaseView  showView:showView cover:YES];
    
    UILabel *titeL = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth-24, 20)];
    titeL.textAlignment = NSTextAlignmentCenter;
    titeL.textColor = kRGB_COLOR(@"#333333");
    titeL.text = kLocalizationMsg(@"请选择状态");
    titeL.font = [UIFont systemFontOfSize:14];
    [showView addSubview:titeL];
    
    for (int i = 0; i < 3; i++) {//0在线1忙碌2离开3通话中
        UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(12, 50+i*50, kScreenWidth-24, 50)];
        textL.textAlignment = NSTextAlignmentCenter;
        textL.font = [UIFont boldSystemFontOfSize:14];
        textL.textColor = kRGB_COLOR(@"#333333");
        UIColor *color ;
        NSString *statusStr;
        if (i == 0) {//在线
            color = [UIColor greenColor];
            statusStr = kLocalizationMsg(@"● 在线");
        }else if(i == 1){//忙碌
            color = [UIColor redColor];
            statusStr = kLocalizationMsg(@"● 忙碌");
        }else {//离开
            color = [UIColor grayColor];
            statusStr = kLocalizationMsg(@"● 离开");
        }
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:statusStr];
        [attriStr addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, 1)];
        textL.attributedText = attriStr;
        [showView addSubview:textL];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0,50+i*50, kScreenWidth, 0.5)];
        line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        [showView addSubview:line];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12, 50+i*50, kScreenWidth-24, 50)];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn addTarget:showView action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)btn{
    self.callBack(NO, (int)btn.tag);
    [FunctionSheetBaseView  deletePopView:self];
}
@end
