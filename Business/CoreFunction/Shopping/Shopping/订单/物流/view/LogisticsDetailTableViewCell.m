//
//  LogisticsDetailTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/8/5.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LogisticsDetailTableViewCell.h"
#import <LibProjModel/LogisticsNodeDTOModel.h>

@interface LogisticsDetailTableViewCell ()
@property (nonatomic, strong)UILabel *timeL;
@property (nonatomic, strong)UIView *point;
@property (nonatomic, strong)UILabel *contentL;

@property (nonatomic, strong)UIView *lineUp;
@property (nonatomic, strong)UIView *lineDown;
@property (nonatomic, assign)CGFloat cellHeight;
@end
@implementation LogisticsDetailTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellHeight = height;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.point];
    [self.contentView addSubview:self.contentL];
    [self.contentView addSubview:self.lineUp];
    [self.contentView addSubview:self.lineDown];
    
}
 
- (void)setModel:(LogisticsNodeDTOModel *)model{
    self.timeL.text = [model.time timeStringWithDateFormat:@"MM-dd HH:mm"];
    NSMutableString *content = [[NSMutableString alloc]init];
    if (model.deliveryStatus.length > 0) {
        [content appendString:[NSString stringWithFormat:@"%@，",model.deliveryStatus]];
    }
    if (model.courier.length > 0) {
        [content appendString:[NSString stringWithFormat:kLocalizationMsg(@"快递员：%@，"),model.courier]];
    }
    if (model.courierPhone.length > 0) {
        [content appendString:[NSString stringWithFormat:kLocalizationMsg(@"电话：%@，"),model.courierPhone]];
    }
    if (model.courierPhone.length > 0) {
        [content appendString:[NSString stringWithFormat:kLocalizationMsg(@"电话：%@，"),model.courierPhone]];
    }
    if (model.content.length > 0) {
        [content appendString:[NSString stringWithFormat:@"%@",model.content]];
    }
    self.contentL.text = content;
    self.lineUp.hidden = self.isFirstOne;
    self.lineDown.hidden = self.isLastOne;
}

#pragma mark - lazy load
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(24, (self.cellHeight-40)/2.0, 44, 40)];
        _timeL.numberOfLines = 0;
        _timeL.textAlignment = NSTextAlignmentCenter;
        _timeL.font = [UIFont systemFontOfSize:14];
        _timeL.textColor = kRGB_COLOR(@"#888888");
    }
    return _timeL;
}
 
- (UIView *)point{
    if (!_point) {
        _point = [[UIView alloc]initWithFrame:CGRectMake(_timeL.maxX+18, (self.cellHeight-8)/2.0, 8, 8)];
        _point.backgroundColor = kRGB_COLOR(@"#D8D8D8");
        _point.layer.cornerRadius = 4;
        _point.clipsToBounds = YES;
    }
    return _point;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc]initWithFrame:CGRectMake(_timeL.maxX + 44, 0, kScreenWidth-24-40-44-10, self.cellHeight)];
        _contentL.textAlignment = NSTextAlignmentLeft;
        _contentL.font = [UIFont systemFontOfSize:12];
        _contentL.numberOfLines = 0;
        _contentL.textColor = kRGB_COLOR(@"#999999");
    }
    return _contentL;
}
- (UIView *)lineUp{
    if (!_lineUp) {
        _lineUp = [[UIView alloc]initWithFrame:CGRectMake(_timeL.maxX+21.5, 0, 1.0, (self.cellHeight-_point.height)/2.0)];
        _lineUp.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    }
    return _lineUp;
}
 
- (UIView *)lineDown{
    if (!_lineDown) {
        _lineDown = [[UIView alloc]initWithFrame:CGRectMake(_timeL.maxX+21.5, _point.maxY, 1.0, (self.cellHeight-_point.height)/2.0)];
        _lineDown.backgroundColor = kRGB_COLOR(@"#D8D8D8");
    }
    return _lineDown;
}
@end
