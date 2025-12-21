//
//  OrderRefundStatusView.m
//  Shopping
//
//  Created by yww on 2020/11/13.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderRefundStatusView.h"
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
#import <LibProjModel/ShopOrderReturnProcessDTOModel.h>
 
@interface OrderRefundStatusView()

@end

@implementation OrderRefundStatusView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor clearColor];

}

- (void)setModel:(ShopUserOrderDetailDTOModel *)model{
    _model = model;
    [self updateScrollview];
}

- (void)updateScrollview{
    [self removeAllSubViews];
    int num = (int)self.model.processList.count;
    if (num <= 0) {
        return;
    }
    CGFloat pointW = 15.0;
    CGFloat contentWidth = self.width/self.model.processList.count;
    
    NSInteger currentIndex = (self.model.processList.count-1);
    for (int i = 0; i < num; i++) {
        ShopOrderReturnProcessDTOModel *processModel = self.model.processList[i];
        if (!processModel.operateStatus) {
            currentIndex = MAX((i - 1), 0);
            break;
        }
    }
    
    UIView *beforePoint = nil;
    
    for (int i = 0; i < num; i++) {
        ShopOrderReturnProcessDTOModel *processModel = self.model.processList[i];
        CGFloat pointCenterX = contentWidth*i + contentWidth/2.0;
        
        UIButton *pointImageV = [UIButton buttonWithType:0];
        pointImageV.userInteractionEnabled = NO;
        pointImageV.frame = CGRectMake(0,0, pointW, pointW);
        pointImageV.centerX = pointCenterX;
        pointImageV.layer.cornerRadius = 5;
        pointImageV.clipsToBounds = YES;
        
        UIImage *pointImg = [UIImage imageNamed:@"shop_refund_status_point"];
        if (currentIndex == i) {
            pointImageV.contentEdgeInsets = UIEdgeInsetsMake(1, 1, 1, 1);
            pointImg = [UIImage imageNamed:@"shop_refund_status_point"];
        }else if(processModel.operateStatus){
            pointImageV.contentEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
            UIView *pointV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
            pointV.layer.masksToBounds = YES;
            pointV.layer.cornerRadius = 13;
            pointV.backgroundColor = kRGB_COLOR(@"#C12A2A");
            pointImg = [UIImage imageConvertFromView:pointV];
        }else{
            pointImageV.contentEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
            UIView *pointV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
            pointV.layer.masksToBounds = YES;
            pointV.layer.cornerRadius = 13;
            pointV.backgroundColor = [UIColor whiteColor];
            pointImg = [UIImage imageConvertFromView:pointV];
        }
        [pointImageV setImage:pointImg forState:UIControlStateNormal];
        [self addSubview:pointImageV];

        if (i > 0) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = processModel.operateStatus?kRGB_COLOR(@"#C12A2A"):[UIColor whiteColor];
            [self addSubview:line];
            [self sendSubviewToBack:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(beforePoint.mas_right).offset(-3);
                make.right.equalTo(pointImageV.mas_left).offset(3);
                make.centerY.equalTo(beforePoint);
                make.height.mas_equalTo(1.0);
            }];
        }
        beforePoint = pointImageV;
        
        UILabel *textL = [[UILabel alloc]init];
        textL.textColor = processModel.operateStatus?kRGB_COLOR(@"#C12A2A"):[UIColor whiteColor];
        textL.font = [UIFont systemFontOfSize:11];
        textL.textAlignment = NSTextAlignmentCenter;
        textL.text = processModel.nodeName;
        [textL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        textL.centerX = pointCenterX;
        [self addSubview:textL];
        [textL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(pointImageV);
            make.top.equalTo(pointImageV.mas_bottom).inset(3);
        }];
        
        if (processModel.operateStatus) {
            UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(0, textL.maxY+1, 70, 10)];
            timeL.textColor = processModel.operateStatus?kRGB_COLOR(@"#C12A2A"):[UIColor whiteColor];
            timeL.font = [UIFont systemFontOfSize:8];
            timeL.textAlignment = NSTextAlignmentCenter;
            [timeL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
            timeL.centerX = pointCenterX;
            timeL.text = [processModel.upTime timeStringWithDateFormat:@"yyyy-MM-dd"];
            [self addSubview:timeL];
            [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(textL);
                make.top.equalTo(textL.mas_bottom).inset(3);
            }];
        }
    }
}


@end
