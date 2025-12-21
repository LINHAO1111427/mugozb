//
//  OrderStatusHeader.m
//  Shopping
//
//  Created by yww on 2020/11/12.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "OrderStatusHeader.h"

#import "OrderRefundStatusView.h"
#import "OrderDetailHeaderView.h"
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjView/ForceAlertController.h>
#import <LibTools/TimerBlock.h>

@interface OrderStatusHeader()
@property (nonatomic, assign)QuitOrderStatus quitStatus;// 退货订单状态
@property (nonatomic, assign)HostOrderStatus orderStatus;//普通订单状态
@property (nonatomic, strong)UIImageView *backImageV;
@property (nonatomic, strong)UILabel *titleL;//标题状态
@property (nonatomic, strong)UILabel *tipL;//提示信息
@property (nonatomic, strong)UIImageView *comeDownTimeImageV;//倒计时背景图
@property (nonatomic, strong)UILabel *comeDownTimeL;//倒计时
@property (nonatomic, strong)UIImageView *finishStatusImageV;//✅或❌图片
@property (nonatomic, strong)OrderRefundStatusView *refundStatusView;//退货状态
@property (nonatomic, copy)TimerBlock *timerBlock;
@property (nonatomic, weak)UIView *contentBgV;

@property (nonatomic, copy)NSString *hintJoinStr; ///提示文字的拼接文字

@end

@implementation OrderStatusHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (TimerBlock *)timerBlock{
    if (!_timerBlock) {
        _timerBlock = [[TimerBlock alloc] init];
    }
    return _timerBlock;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    _backImageV = [[UIImageView alloc] init];
    _backImageV.userInteractionEnabled = YES;
    _backImageV.image = [UIImage createImageSize:CGSizeMake(kScreenWidth, kScreenWidth) gradientColors:@[kRGB_COLOR(@"#FF8D34"),kRGB_COLOR(@"#FFB322")] percentage:@[@0.1,@1.0] gradientType:GradientFromLeftToRight];
    [self addSubview:_backImageV];
    [_backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contentBgV = [[UIView alloc] init];
    [self addSubview:contentBgV];
    _contentBgV = contentBgV;
    [contentBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kNavBarHeight);
        make.left.right.equalTo(self).inset(20);
    }];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor whiteColor];
    _titleL.font = [UIFont boldSystemFontOfSize:17];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_titleL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [contentBgV addSubview:_titleL];
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contentBgV);
    }];
    
    _tipL = [[UILabel alloc] init];
    _tipL.textColor = [UIColor whiteColor];
    _tipL.numberOfLines = 0;
    _tipL.font = [UIFont systemFontOfSize:13];
    [_tipL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    _tipL.textAlignment = NSTextAlignmentCenter;
    [contentBgV addSubview:_tipL];
    [_tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(contentBgV);
        make.top.equalTo(_titleL.mas_bottom).offset(5);
    }];
    
    _refundStatusView = [[OrderRefundStatusView alloc]initWithFrame:CGRectMake(10, _tipL.maxY+5, kScreenWidth-20, 45)];
    _refundStatusView.hidden = YES;
    [self addSubview:_refundStatusView];
    [_refundStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 45));
        make.centerX.equalTo(self);
        make.top.mas_equalTo(contentBgV.mas_bottom).inset(10);
    }];
    
    ///倒计时
    _comeDownTimeImageV = [[UIImageView alloc]init];
    _comeDownTimeImageV.contentMode = UIViewContentModeScaleToFill;
    _comeDownTimeImageV.image = [UIImage imageNamed:@"shop_order_time_bg"];
    _comeDownTimeImageV.hidden = YES;
    [_backImageV addSubview:_comeDownTimeImageV];
    [_comeDownTimeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 60));
        make.right.equalTo(_backImageV).inset(10);
        make.centerY.equalTo(contentBgV);
    }];
    _comeDownTimeL = [[UILabel alloc] init];
    _comeDownTimeL.textColor = [UIColor whiteColor];
    _comeDownTimeL.font = [UIFont boldSystemFontOfSize:21];
    _comeDownTimeL.textAlignment = NSTextAlignmentCenter;
    [_comeDownTimeImageV addSubview:_comeDownTimeL];
    [_comeDownTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_comeDownTimeImageV);
    }];
    
    ///状态图片
    _finishStatusImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100, 0, 66, 66)];
    _finishStatusImageV.contentMode = UIViewContentModeScaleAspectFit;
    _finishStatusImageV.hidden = YES;
    [_backImageV addSubview:_finishStatusImageV];
    [_finishStatusImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66, 66));
        make.right.equalTo(_backImageV).inset(34);
        make.centerY.equalTo(_tipL);
    }];
    
}

///设置内容
- (void)setDetailModel:(ShopUserOrderDetailDTOModel *)detailModel {
    _detailModel = detailModel;
    
    self.finishStatusImageV.hidden = YES;
    self.comeDownTimeImageV.hidden = YES;
    [self stopTimer];
    
    //获取高度
    CGFloat height = [OrderDetailHeaderView getHeaderHeight:detailModel];
    self.height = height;
    
    if (self.isQuiterOrder) {// 退货订单
        self.refundStatusView.model = detailModel;
        self.refundStatusView.hidden = NO;
    }else{
        self.refundStatusView.hidden = YES;
    }
    
    [self showOrderStatus:detailModel.businessOrder.status quitStatus:detailModel.businessOrder.quitStatus];
    [self layoutIfNeeded];
}
 
 
- (void)showOrderStatus:(HostOrderStatus)orderStatus quitStatus:(QuitOrderStatus)quitStatus{
    _orderStatus = orderStatus;
    _quitStatus = quitStatus;
    
    kWeakSelf(self);
    ////退货退款的状态
    if (quitStatus > 0) {
        switch (quitStatus) {
            case QuitOrderStatusWaittingCheck:{//待审核
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
                self.titleL.text = kLocalizationMsg(@"订单退款中");
                [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.tipL.text = kLocalizationMsg(@"稍后将自动同意");
                    }else{
                        weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"后未审核订单将自动同意")];
                    }
                }];
            }
                break;
            case QuitOrderStatusWaittingForDeliver:{//待发货
                
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
    
                self.titleL.text = kLocalizationMsg(@"订单退款中");
                [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.tipL.text = kLocalizationMsg(@"稍后将自动取消退款");
                    }else{
                        weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"后未填写物流单号订单将自动取消退款")];
                    }
                }];
            }
                break;
            case QuitOrderStatusWaittingForReceive:{//待收货
    
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
                self.titleL.text = kLocalizationMsg(@"订单退款中");
                [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.tipL.text = kLocalizationMsg(@"稍后卖家将自动确认收货");
                    }else{
                        weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"后卖家自动确认收货")];
                    }
                }];
            }
                break;
            case QuitOrderStatusRefunding://退款中
            case QuitOrderStatusForFail:{//退款失败
                self.titleL.text = kLocalizationMsg(@"订单退款中");
                NSString *attStr;
                if (self.type == OrderTypeForCustomer) {
                    attStr = kLocalizationMsg(@"款项自动退回您的付款账户");
                }else{
                    attStr = kLocalizationMsg(@"款项自动退回买家的付款账户");
                }
                self.tipL.attributedText = [weakself getShowTipTime:self.detailModel.refundShowDay hintStr:attStr];
            }
                break;
            case QuitOrderStatusForComplete:{//退款完成
                self.titleL.text = kLocalizationMsg(@"订单已关闭");
                self.finishStatusImageV.hidden = NO;
                self.finishStatusImageV.image = [UIImage imageNamed:@"shop_order_fail"];
                self.titleL.textAlignment = NSTextAlignmentCenter;
                if (self.type == OrderTypeForCustomer) {
                    self.tipL.text = kLocalizationMsg(@"退款成功，款项已原路退回您的支付账户");
                }else{
                    self.tipL.text = kLocalizationMsg(@"退款成功，款项已原路退回买家的支付账户");
                }
            }
                break;
            case QuitOrderStatusForFefuse:{//退款拒绝
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
                
                if (orderStatus == HostOrderStatusWaittingForDeliver) {///待发货
                    self.titleL.text = kLocalizationMsg(@"等待卖家发货");
                    [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                        if (isOver) {
                            weakself.tipL.text = kLocalizationMsg(@"稍后订单自动取消");
                        }else{
                            weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"内未发货订单自动取消")];
                        }
                    }];
                }else if (orderStatus == HostOrderStatusWaittingForReceive){ ///待收货
                    self.titleL.text = kLocalizationMsg(@"等待买家收货");
                    [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                        if (isOver) {
                            weakself.tipL.text = kLocalizationMsg(@"稍后自动确认收货");
                        }else{
                            weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"后自动确认收货")];
                        }
                    }];
                }else if (orderStatus == HostOrderStatusForComplete){ ///已完成
                    self.titleL.text = kLocalizationMsg(@"订单已完成");
                    self.tipL.text = kLocalizationMsg(@"已确认收货");
                }else{
                    
                }
            }
                break;
                
            default:
                break;
        }
        
    }else{
        ///普通流程
        switch (orderStatus) {
            case HostOrderStatusWaittingForPay:{//待付款
                self.titleL.textAlignment = NSTextAlignmentLeft;
                self.tipL.textAlignment = NSTextAlignmentLeft;
                self.titleL.text = kLocalizationMsg(@"等待买家付款");
                self.tipL.text = kLocalizationMsg(@"指定时间未付款订单自动取消");
                
                self.comeDownTimeImageV.hidden = NO;
                [self timerBlock:NO timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.comeDownTimeL.text = @"00:00";
                    }else{
                        weakself.comeDownTimeL.text = timeStr;
                    }
                }];
            }
                break;
            case HostOrderStatusWaittingForDeliver:{//待发货
                self.titleL.textAlignment = NSTextAlignmentLeft;
                self.tipL.textAlignment = NSTextAlignmentLeft;
                self.titleL.text = kLocalizationMsg(@"等待卖家发货");
                self.tipL.text = kLocalizationMsg(@"指定时间内未发货订单自动取消");
                
                self.comeDownTimeImageV.hidden = NO;
                [self timerBlock:NO timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.comeDownTimeL.text = @"00:00";
                    }else{
                        weakself.comeDownTimeL.text = timeStr;
                    }
                }];
            }
                break;
            case HostOrderStatusWaittingForReceive:{//待收货
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
                
                self.titleL.text = kLocalizationMsg(@"等待买家收货");
                [self timerBlock:YES timeStrCallBack:^(BOOL isOver, NSString *timeStr) {
                    if (isOver) {
                        weakself.tipL.text = kLocalizationMsg(@"稍后将自动确认收货");
                    }else{
                        weakself.tipL.attributedText = [weakself getShowTipTime:timeStr hintStr:kLocalizationMsg(@"后自动确认收货")];
                    }
                }];

            }
                break;
            case HostOrderStatusForComplete:{//完成
                
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.tipL.textAlignment = NSTextAlignmentCenter;
                self.titleL.text = kLocalizationMsg(@"订单已完成");
                self.tipL.text = kLocalizationMsg(@"已确认收货");
                
                self.finishStatusImageV.hidden = NO;
                self.finishStatusImageV.image = [UIImage imageNamed:@"shop_order_complete"];

            }
                break;
            case HostOrderStatusForCancel:{//取消
                
                self.titleL.textAlignment = NSTextAlignmentCenter;
                self.titleL.text = kLocalizationMsg(@"订单已取消");
                self.tipL.text = @"";
    
                self.finishStatusImageV.hidden = NO;
                self.finishStatusImageV.image = [UIImage imageNamed:@"shop_order_fail"];

            }
                break;
            default:
                break;
        }
    }
}


#pragma mark - 时间相关

-(void)stopTimer{
    [_timerBlock stopTimer];
    _timerBlock = nil;
}


- (NSAttributedString *)getShowTipTime:(NSString *)time hintStr:(NSString *)hintStr{
    
    NSString *tipStr = [NSString stringWithFormat:@"%@ %@", time, hintStr];
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:tipStr];
    NSRange rangeTime = [tipStr rangeOfString:time];
    if (rangeTime.length > 0) {
        [attriStr addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#C12A2A")} range:rangeTime];
    }
    self.tipL.attributedText  = attriStr;
    
    return [attriStr copy];
}



- (void)timerBlock:(BOOL)isStringTime timeStrCallBack:(void(^)(BOOL isOver,NSString *timeStr))callBack{
    [self.timerBlock stopTimer];
    kWeakSelf(self);
    [self.timerBlock startTimerForIntervalTime:1.0 progress:^(CGFloat progress) {
        [weakself getShowTime:isStringTime callBack:callBack];
    }];
}

- (void)getShowTime:(BOOL)isString callBack:(void(^)(BOOL isOver, NSString *timeStr))callBack{

    NSDate *closeDate = self.detailModel.closingDate;
    BOOL isOver = NO;
    NSString *timeStr = @"";
    
    if (!closeDate) {
        
        isOver = YES;
        [self stopTimer];
        
    }else{
        
        NSTimeInterval distanceBetweenDates = [closeDate timeIntervalSinceDate:[NSDate date]];
        int betweeTime= distanceBetweenDates;
        
        if (betweeTime < 0) {
            
            isOver = YES;
            [self stopTimer];
            
        }else{
            
            int days = betweeTime/(3600*24);
            betweeTime -= days*(3600*24);
            int hour = betweeTime/3600;
            betweeTime -= hour*3600;
            int minute = betweeTime/60;
            int seconds = betweeTime%60;
            
            if (!isString) {
                NSString *hourStr = [NSString stringWithFormat:@"%02d",hour];
                NSString *miunteStr = [NSString stringWithFormat:@"%02d",minute];
                NSString *secondsStr = [NSString stringWithFormat:@"%02d",seconds];;
                if (hour > 0) {
                    timeStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr,miunteStr,secondsStr];
                }else if (minute > 0){
                    timeStr = [NSString stringWithFormat:@"%@:%@",miunteStr,secondsStr];
                }else{
                    timeStr = [NSString stringWithFormat:@"00:%@",secondsStr];
                }
            }else{
                if (days == 0) {
                    if (hour > 0) {
                        timeStr = [NSString stringWithFormat:kLocalizationMsg(@"%02d时%02d分%02d秒"),hour,minute,seconds];
                    }else if(minute > 0){
                        timeStr = [NSString stringWithFormat:kLocalizationMsg(@"%02d分%02d秒"),minute,seconds];
                    }else{
                        timeStr = [NSString stringWithFormat:kLocalizationMsg(@"%02d秒"),seconds];
                    }
                }else{
                    timeStr = [NSString stringWithFormat:kLocalizationMsg(@"%d天%02d时%02d分"),days,hour,minute];
                }
            }
            
        }
    }

    callBack(isOver,timeStr);
}

- (void)dealloc{
    [self stopTimer];
}
  
 
@end
