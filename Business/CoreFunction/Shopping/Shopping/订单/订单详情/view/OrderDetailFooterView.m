//
//  OrderDetailFooterView.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailFooterView.h"
 
#import <LibProjModel/ShopParentOrderModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>

@interface OrderDetailFooterCellModel : NSObject
@property (nonatomic, assign)int tag;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@end
@implementation OrderDetailFooterCellModel
@end


@interface OrderDetailFooterView()
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)NSMutableArray *contentArray;
@property (nonatomic, strong)UIView *logisticsView;//物流

@end
@implementation OrderDetailFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
 
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentV];
    [self addSubview:self.logisticsView];
}
- (void)setModel:(ShopUserOrderDetailDTOModel *)model{
    _model = model;
    CGFloat y = 0;
    self.logisticsView.hidden = YES;
    [self.logisticsView removeAllSubViews];
    [self.contentV removeAllSubViews];
    //订单信息
    [self addInfoList];
    CGFloat height = self.contentArray.count *30+20;
    if (model.refundLogisticsNum.length > 0) {//退货物流地址
        height += 80; 
        y += 80;
        self.logisticsView.hidden = NO;
        UIView *addressImgeV = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        addressImgeV.layer.cornerRadius = 10;
        addressImgeV.clipsToBounds = YES;;
        addressImgeV.backgroundColor= [UIColor whiteColor];
        UIImageView *locatImg = [[UIImageView alloc]initWithFrame:addressImgeV.bounds];
        locatImg.image = [UIImage imageNamed:@"shop_logistics"];
        [addressImgeV addSubview:locatImg];
        [self.logisticsView addSubview:addressImgeV];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(addressImgeV.maxX, 5, 60, 20)];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.text = kLocalizationMsg(@"退货信息");
        titleL.textAlignment = NSTextAlignmentLeft;
        [self.logisticsView addSubview:titleL];
        
        UILabel *logisticNumL = [[UILabel alloc]initWithFrame:CGRectMake(titleL.maxX, 5, kScreenWidth-20-100, 20)];
        logisticNumL.textColor = kRGB_COLOR(@"#262626");
        logisticNumL.font = [UIFont systemFontOfSize:12];
        logisticNumL.text = [NSString stringWithFormat:@"%@：%@",model.refundLogisticsName,model.refundLogisticsNum];
        logisticNumL.textAlignment = NSTextAlignmentRight;
        [self.logisticsView addSubview:logisticNumL];
        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-40, 40)];
        contentL.text = model.buyerLogisticsContent.length>0?model.buyerLogisticsContent:kLocalizationMsg(@"暂无物流信息");
        contentL.textColor = kRGB_COLOR(@"#666666");
        contentL.font = [UIFont systemFontOfSize:12];
        contentL.numberOfLines = 0;
        contentL.textAlignment = NSTextAlignmentLeft;
        [self.logisticsView addSubview:contentL];
        
        UIButton *logsiticsBtn = [[UIButton alloc]initWithFrame:self.logisticsView.bounds];
        logsiticsBtn.backgroundColor = [UIColor clearColor];
        [logsiticsBtn addTarget:self action:@selector(logsiticsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.logisticsView addSubview:logsiticsBtn];
    }
    self.contentV.y = y;
    self.height = height;
}
- (void)addInfoList{
    [self.contentArray removeAllObjects];
    if (self.model.businessOrder.orderNum.length > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"订单编号");
        cellModel.tag = 0;
        cellModel.content = self.model.businessOrder.orderNum;
        [self.contentArray addObject:cellModel];
    }
    if (self.model.parentOrder.addTime) {
        NSDate *date = self.model.businessOrder.addTime;
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"下单时间");
        cellModel.tag = 1;
        cellModel.content = [date timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [self.contentArray addObject:cellModel];
    }
    if (self.model.businessOrder.orderAmount > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"订单金额");
        cellModel.tag = 2;
        cellModel.content = [NSString stringWithFormat:@"¥%.2f",self.model.businessOrder.orderAmount];
        [self.contentArray addObject:cellModel];
    }
    if (self.model.businessOrder.orderAmount > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"优惠金额");
        cellModel.tag = 3;
        cellModel.content = [NSString stringWithFormat:@"¥%.2f",self.model.businessOrder.orderAmount-self.model.businessOrder.transactionAmount];
        [self.contentArray addObject:cellModel];
    }
    if (self.model.businessOrder.transactionAmount > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"实付金额");
        cellModel.tag = 4;
        cellModel.content = [NSString stringWithFormat:@"¥%.2f",self.model.businessOrder.transactionAmount];
        [self.contentArray addObject:cellModel];
    }
    if (self.model.parentOrder.payTime && self.model.businessOrder.status > 1) {
        NSDate *date = self.model.parentOrder.payTime;
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"支付时间");
        cellModel.tag = 5;
        cellModel.content = [date timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [self.contentArray addObject:cellModel];
    }
    if (self.model.parentOrder.channelId > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"支付方式");
        cellModel.tag = 6;
        cellModel.content = self.model.parentOrder.channelId == 1?kLocalizationMsg(@"支付宝"):kLocalizationMsg(@"微信");
        [self.contentArray addObject:cellModel];
    }
    if (self.model.businessOrder.refundType > 0 && self.model.businessOrder.quitStatus == 5) {
        if (self.model.businessOrder.transactionAmount > 0) {
            OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
            cellModel.title = kLocalizationMsg(@"退款金额");
            cellModel.tag = 9;
            cellModel.content = [NSString stringWithFormat:@"¥%.2f",self.model.businessOrder.transactionAmount];
            [self.contentArray addObject:cellModel];
        }
        if (self.model.businessOrder.refundTime) {
            NSDate *date = self.model.businessOrder.refundTime;
            OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
            cellModel.title = kLocalizationMsg(@"退款时间");
            cellModel.tag = 10;
            cellModel.content = [date timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            [self.contentArray addObject:cellModel];
        }
    }
    if (self.model.parentOrder.payOrder.length > 0) {
        OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
        cellModel.title = kLocalizationMsg(@"支付交易号");
        cellModel.tag = 7;
        cellModel.content = self.model.parentOrder.payOrder;
        [self.contentArray addObject:cellModel];
    }
    
    OrderDetailFooterCellModel *cellModel = [[OrderDetailFooterCellModel alloc]init];
    cellModel.title = kLocalizationMsg(@"商品渠道");
    cellModel.tag = 8;
    cellModel.content = kLocalizationMsg(@"官方渠道");
    [self.contentArray addObject:cellModel];
    
    CGFloat viewH = 30;
    for (int i = 0; i < self.contentArray.count; i++) {
        
        OrderDetailFooterCellModel *cellModel = self.contentArray[i];

        UIView *itemBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 10+i*viewH, self.contentV.width, viewH)];
        [self.contentV addSubview:itemBgV];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10,0, 70, itemBgV.height)];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.textColor = kRGB_COLOR(@"#666666");
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.text = cellModel.title;
        [itemBgV addSubview:titleL];
        

        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(titleL.maxX, 0, itemBgV.width-10-titleL.maxX, itemBgV.height)];
        contentL.textAlignment = NSTextAlignmentRight;
        if (cellModel.tag == 3) {
            contentL.textColor = kRGB_COLOR(@"#FC8F3A");
        }else{
            contentL.textColor = kRGB_COLOR(@"#333333");
        }
        contentL.font = [UIFont systemFontOfSize:13];
        contentL.text = cellModel.content;
        [itemBgV addSubview:contentL];
        
    }
    //高度变化
    self.contentV.height = self.contentArray.count *viewH+ 20;
}

- (void)logsiticsBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailFooterViewLogisticBtnClick)]) {
        [self.delegate OrderDetailFooterViewLogisticBtnClick];
    }
}
#pragma mark - lazy load
 
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 280)];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.layer.cornerRadius = 10;
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}
- (UIView *)logisticsView{
    if (!_logisticsView) {
        _logisticsView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 70)];
        _logisticsView.backgroundColor = [UIColor whiteColor];
        _logisticsView.layer.cornerRadius = 10;
        _logisticsView.clipsToBounds = YES;
    }
    return _logisticsView;
}
- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}

@end
