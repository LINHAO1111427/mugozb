//
//  LiveTradePreviewTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LiveTradePreviewTableViewCell.h"

@interface LiveTradePreviewTableViewCell()
@property (nonatomic, strong)UILabel *timeL;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *emptyTipL;
@end
@implementation LiveTradePreviewTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.emptyTipL];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, kScreenWidth, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    [self.contentView addSubview:line];
}

- (void)showPreviewModel:(ShopLiveAnnouncementDetailDTOModel *)dtoModel isEmpty:(BOOL)isEmpty {
    self.emptyTipL.hidden = !isEmpty;
    self.timeL.hidden = isEmpty;
    self.titleL.hidden = isEmpty;
    if (!isEmpty) {
        self.timeL.text = [dtoModel.startTime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm"];
        self.titleL.text = dtoModel.title;
    }
}

#pragma mark - lazy load
- (UILabel *)timeL{
    if (!_timeL) {
        _timeL = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, (kScreenWidth-24)/2.0, 20)];
        _timeL.textAlignment = NSTextAlignmentLeft;
        _timeL.textColor = kRGB_COLOR(@"#666666");
        _timeL.font = [UIFont systemFontOfSize:14];
    }
    return _timeL;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(12+(kScreenWidth-24)/2.0, 15, (kScreenWidth-24)/2.0, 20)];
        _titleL.textAlignment = NSTextAlignmentRight;
        _titleL.textColor = kRGB_COLOR(@"#666666");
        _titleL.font = [UIFont systemFontOfSize:14];
    }
    return _titleL;
}

- (UILabel *)emptyTipL{
    if (!_emptyTipL) {
        _emptyTipL = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, kScreenWidth-24, 20)];
        _emptyTipL.textAlignment = NSTextAlignmentCenter;
        _emptyTipL.textColor = kRGB_COLOR(@"#9BA2AC");
        _emptyTipL.hidden = NO;
        _emptyTipL.text = kLocalizationMsg(@"你还没有直播预告，赶紧去添加告诉所有人吧！");
        _emptyTipL.font = [UIFont systemFontOfSize:14];
    }
    return _emptyTipL;
}

@end
