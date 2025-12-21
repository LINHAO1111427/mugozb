//
//  OrderDetailHeaderView.m
//  Shopping
//
//  Created by yww on 2020/8/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OrderDetailHeaderView.h"
#import <LibProjModel/ShopUserOrderDetailDTOModel.h>
#import <LibProjModel/ShopBusinessOrderModel.h>
#import <LibProjModel/LogisticsBeanModel.h>
#import <LibProjModel/TraceBeanModel.h>
  




@interface OrderDetailHeaderView()
///tip
@property (nonatomic, strong)UIView *logisticsView;
@property (nonatomic, strong)UILabel *logisticsL;
@property (nonatomic, strong)UILabel *timeL;

@property (nonatomic, strong)UIView *addresView;
@property (nonatomic, weak)UITextView *addressTextL;
@property (nonatomic, strong)UILabel *userNameL;

@end

@implementation OrderDetailHeaderView

+ (CGFloat)getHeaderHeight:(ShopUserOrderDetailDTOModel *)model{
    CGFloat scale;
    //判断退货退款
    BOOL isRefunding = NO;
    if (model.businessOrder.refundType > 0) {
        if (model.businessOrder.quitStatus > 0 && model.businessOrder.quitStatus != 7) {
            isRefunding = YES;
        }
    }
    
    BOOL isHigh = NO;
    if (isRefunding) {//退货退款
        isHigh = YES;
    }else{
        if (model.businessOrder.status == 2 || model.businessOrder.status == 3)  {//代发货待收货
            if (model.businessOrder.quitStatus == 7) {//被拒绝
                isHigh = YES;
            }
        }
    }
    if (isHigh) {
        scale = 340/750.0;
    }else{
        scale = 280/750.0;
    }
    //橘色背景的高度
    CGFloat height = kScreenWidth*scale+kNavBarHeight-64;
    if (isHigh) {
        CGFloat heightM = height-kNavBarHeight;
        if ((heightM-80)/2.0 < 25) {
            CGFloat margin = 25-(heightM-80)/2.0;
            height += 2*margin;
        }
    }
    return height;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
  
 
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
}

- (void)setModel:(ShopUserOrderDetailDTOModel *)model{
    _model = model;

    [self.logisticsView removeAllSubViews];
    [self.logisticsView removeFromSuperview];
    self.logisticsView = nil;
    
    NSString *name = model.businessOrder.name;
    NSString *phone = model.businessOrder.phoneNum;
    NSMutableAttributedString *attristr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",name,phone]];
    ///设置行间距
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineSpacing = 3;// 字体的行间距
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName:kRGB_COLOR(@"#333333"),
        NSFontAttributeName:[UIFont boldSystemFontOfSize:15]
//            NSParagraphStyleAttributeName:paragraphStyle
    };
    [attristr addAttributes:attributes range:NSMakeRange(0, name.length)];
    [attristr addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#333333")} range:[attristr.string rangeOfString:phone]];
    
    self.addresView.hidden = NO;
    self.userNameL.attributedText = attristr;
    self.addressTextL.text = (model.businessOrder.address.length > 0)?model.businessOrder.address:kLocalizationMsg(@"暂无地址");
    
    [self.addressTextL layoutIfNeeded];
    [self.addresView layoutIfNeeded];
    
    
    CGFloat totalHeight = [OrderDetailHeaderView getHeaderHeight:model] - 20;
    
    ///有物流订单
    if (model.logisticsNum.length > 0) {

        [self addSubview:self.logisticsView];
        self.logisticsL.text = model.sellerLogisticsContent.length>0?model.sellerLogisticsContent:kLocalizationMsg(@"暂无物流信息");
        NSString *date = [model.sellerLogisticsTime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.timeL.text = date.length > 0?date:@"";
        [self.logisticsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).inset(totalHeight);
        }];
        [self.logisticsView layoutIfNeeded];
        
        totalHeight += self.logisticsView.height;
        totalHeight += 10;
    }
    
    [self.addresView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(totalHeight);
    }];
    [self.addresView layoutIfNeeded];
    totalHeight += self.addresView.height;

    self.height = totalHeight;
}
 
- (void)tapLogistic{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderDetailHeaderView:logisticTapWith:)]) {
        [self.delegate OrderDetailHeaderView:self logisticTapWith:self.model];
    }
}
 

#pragma mark - lazy load

//物流
- (UIView *)logisticsView{
    if (!_logisticsView) {
        CGFloat scale = 280/750.0;
        CGFloat height = kScreenWidth*scale;
        _logisticsView = [[UIView alloc]initWithFrame:CGRectMake(10, height-20, kScreenWidth-20, 100)];
        _logisticsView.layer.cornerRadius = 10;
        _logisticsView.clipsToBounds = YES;
        _logisticsView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLogistic)];
        [_logisticsView addGestureRecognizer:tap];
        [self addSubview:_logisticsView];
        [_logisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).inset(height);
            make.height.mas_greaterThanOrEqualTo(80);
            make.right.left.equalTo(self).inset(10);
        }];
        
        UIImageView *logisticsImageV = [[UIImageView alloc] init];
        logisticsImageV.image = [UIImage imageNamed:@"shop_logistics"];
        [_logisticsView addSubview:logisticsImageV];
        [logisticsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.centerY.equalTo(_logisticsView);
            make.left.equalTo(_logisticsView).offset(12);
        }];
        
        UIView *centerV = [[UIView alloc] init];
        [_logisticsView addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(logisticsImageV.mas_right).offset(10);
            make.right.equalTo(_logisticsView).inset(10);
            make.height.mas_lessThanOrEqualTo(_logisticsView.height-20);
            make.centerY.equalTo(_logisticsView);
        }];
        
        _logisticsL = [[UILabel alloc] init];
        _logisticsL.textColor = kRGB_COLOR(@"#333333");
        _logisticsL.font = [UIFont systemFontOfSize:14];
        _logisticsL.numberOfLines = 0;
        _logisticsL.textAlignment = NSTextAlignmentLeft;
        [_logisticsL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [centerV addSubview:_logisticsL];
        [_logisticsL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(centerV);
        }];
        
        _timeL = [[UILabel alloc] init];
        _timeL.textAlignment = NSTextAlignmentLeft;
        _timeL.textColor = kRGB_COLOR(@"#666666");
        _timeL.font = [UIFont systemFontOfSize:14];
        [_timeL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [centerV addSubview:_timeL];
        [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_logisticsL.mas_bottom).offset(5);
            make.left.right.bottom.equalTo(centerV);
        }];
    }
    return _logisticsView;
}

//地址
- (UIView *)addresView{
    if (!_addresView) {
        CGFloat scale = 280/750.0;
        CGFloat height = kScreenWidth*scale;
        _addresView = [[UIView alloc] init];
        _addresView.backgroundColor = [UIColor whiteColor];
        _addresView.layer.cornerRadius = 10;
        _addresView.clipsToBounds = YES;
        [self addSubview:_addresView];
        [_addresView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).inset(height);
            make.height.mas_greaterThanOrEqualTo(80);
            make.right.left.equalTo(self).inset(10);
        }];
        
        UIImageView *addressImageV = [[UIImageView alloc] init];
        addressImageV.image = [UIImage imageNamed:@"shop_order_address"];
        [_addresView addSubview:addressImageV];
        [addressImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.left.equalTo(_addresView).offset(12);
            make.centerY.equalTo(_addresView);
        }];
        
        UIView *centerBgV = [[UIView alloc] init];
        [_addresView addSubview:centerBgV];
        [centerBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_addresView);
            make.left.equalTo(addressImageV.mas_right).offset(10);
            make.right.equalTo(_addresView).inset(10);
            make.bottom.top.mas_greaterThanOrEqualTo(_addresView).inset(15);
        }];
        
        _userNameL = [[UILabel alloc]init];
        _userNameL.textAlignment = NSTextAlignmentLeft;
        _userNameL.numberOfLines = 0;
        _userNameL.font = [UIFont systemFontOfSize:14];
        [_userNameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _userNameL.textColor = kRGB_COLOR(@"#666666");
        [centerBgV addSubview:_userNameL];
        [_userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(centerBgV);
        }];
        
        UITextView *addressTextL = [[UITextView alloc] init];
        addressTextL.userInteractionEnabled = NO;
        addressTextL.scrollEnabled = NO;
        addressTextL.font = [UIFont systemFontOfSize:14];
        addressTextL.textColor = kRGB_COLOR(@"#666666");
        addressTextL.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [addressTextL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        addressTextL.textContainer.lineFragmentPadding = 0;
        [centerBgV addSubview:addressTextL];
        _addressTextL = addressTextL;
        [addressTextL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userNameL.mas_bottom).inset(5);
            make.bottom.left.right.equalTo(centerBgV);
        }];

    }
    return _addresView;
}
 
@end
