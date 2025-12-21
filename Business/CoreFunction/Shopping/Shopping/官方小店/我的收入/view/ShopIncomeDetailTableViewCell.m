//
//  ShopIncomeTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopIncomeDetailTableViewCell.h"
 
@interface ShopIncomeDetailTableViewCell()
@property (nonatomic, strong)UILabel *orderNo_L;//订单编号
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *timeL;
@property (nonatomic, strong)UILabel *moneyL;//收入
@property (nonatomic, strong)UILabel *leftMoneyL;//余额
@end

@implementation ShopIncomeDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromInit];
    }
    return self;
}
 
- (void)awakeFromInit{
    [self.contentView addSubview:self.orderNo_L];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.moneyL];
    [self.contentView addSubview:self.leftMoneyL];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self.contentView addSubview:line];
    UIView *isolationZoneV = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-10, kScreenWidth, 10)];
    isolationZoneV.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentView addSubview:isolationZoneV];
}
 


#pragma mark - lazy load
- (UILabel *)orderNo_L{
    if (!_orderNo_L) {
        _orderNo_L = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-24, 20)];
        _orderNo_L.textColor = kRGB_COLOR(@"#666666");
        _orderNo_L.font = [UIFont systemFontOfSize:13];
        _orderNo_L.textAlignment = NSTextAlignmentLeft;
    }
    return _orderNo_L;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 10, kScreenWidth-24-100, 40)];
        _titleL.textColor = kRGB_COLOR(@"#333333");
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.numberOfLines = 0;
    }
    return _titleL;
}
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(12, _titleL.maxY, kScreenWidth-24-100, 20)];
        _timeL.textColor = kRGB_COLOR(@"#999999");
        _timeL.font = [UIFont systemFontOfSize:12];
        _timeL.textAlignment = NSTextAlignmentLeft;
    }
    return _timeL;
}
- (UILabel *)moneyL{
    if (!_moneyL) {
        _moneyL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-12-100, 20, 100, 20)];
        _moneyL.textAlignment = NSTextAlignmentRight;
        _moneyL.font = [UIFont boldSystemFontOfSize:16];
        _moneyL.textColor = kRGB_COLOR(@"#FF5500");
    }
    return _moneyL;
}
- (UILabel *)leftMoneyL{
    if (!_leftMoneyL) {
        _leftMoneyL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-12-100, _titleL.maxY, 100, 20)];
        _leftMoneyL.textAlignment = NSTextAlignmentRight;
        _leftMoneyL.font = [UIFont boldSystemFontOfSize:12];
        _leftMoneyL.textColor = kRGB_COLOR(@"#999999");
    }
    return _leftMoneyL;
}
@end
 
   
