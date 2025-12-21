//
//  guardPayBtn.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "guardPayBtn.h"


@interface guardPayBtn()
@property (nonatomic, strong)UIImageView *subV;
@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UIImageView *limitTimeDiscountImageV;
@end
 
@implementation guardPayBtn
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         
    }
    return self;
}
- (void)setModel:(GuardVOModel *)model{
    _model = model;
    [self updateUI];
}
- (void)updateUI{
    [self removeAllSubViews];
    CGFloat spaceV = (self.height-40)/2.0;
    if (spaceV < 0) {
        spaceV = 0;
    }
    self.backgroundColor = [UIColor clearColor];
    UIImageView *subV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    subV.contentMode = UIViewContentModeScaleToFill;
    subV.layer.cornerRadius = 10;
    subV.clipsToBounds = YES;
    subV.layer.borderColor =kRGB_COLOR(@"#DBDBDB").CGColor;
    subV.layer.borderWidth = 1.0;
    subV.backgroundColor = [UIColor whiteColor];
    subV.userInteractionEnabled = NO;
    self.subV = subV;
    [self addSubview:self.subV];
    
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, spaceV, self.width, 20)];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.font = [UIFont systemFontOfSize:15];
    dayLabel.textColor = kRGB_COLOR(@"#333333");
    NSString *dayStr = [NSString stringWithFormat:kLocalizationMsg(@"%d天"),self.model.length];
    dayLabel.text = dayStr;
    self.dayLabel = dayLabel;
    [subV addSubview:self.dayLabel];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, dayLabel.maxY, self.width, 20)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [ProjConfig normalColors];
    moneyLabel.font = [UIFont systemFontOfSize:20];
    NSString *orignMoneyStr = [NSString stringWithFormat:@"¥%.2f",self.model.iosPrice];
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:orignMoneyStr];
    [moneyAttr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]} range:[orignMoneyStr rangeOfString:@"¥"]];
    moneyLabel.attributedText = moneyAttr;
    self.moneyLabel = moneyLabel;
    [subV addSubview:self.moneyLabel];
}
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.selected = isSelected;
    if (isSelected) {
        self.subV.layer.borderColor = [UIColor clearColor].CGColor;
        self.subV.layer.borderWidth = 0.0;
        self.subV.image = [UIImage imageNamed:@"icon_account_frame_selected"];
    }else{
        self.subV.image = nil;
        self.subV.layer.borderColor =kRGB_COLOR(@"#DBDBDB").CGColor;
        self.subV.layer.borderWidth = 1.0;
    }
}
@end
