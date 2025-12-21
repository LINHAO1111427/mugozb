//
//  paySelectedBtn.m
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import "paySelectedBtn.h"
@interface paySelectedBtn()
@property (nonatomic, strong)UIImageView *subV;
@property (nonatomic, strong)UILabel *coinLabel;
@property (nonatomic, strong)UILabel *moneyLabel;
@property (nonatomic, strong)UILabel *dicountDesrLab; ///折扣信息
@property (nonatomic, strong)UIImageView *limitTimeDiscountImageV;
@end

@implementation paySelectedBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setRuleModel:(RechargeRulesVOModel *)ruleModel{
    _ruleModel = ruleModel;
    
    NSString *coinStr = [NSString stringWithFormat:@"%.0f",self.ruleModel.coin];
    self.coinLabel.attributedText = [coinStr attachmentForImage:[ProjConfig getCoinImage] bounds: CGRectMake(0, -2, 15, 15) before:YES];
    
    //原价
    NSString *orignMoneyStr = @"";
    if ([[NSString stringWithFormat:@"%.2f", self.ruleModel.money] isEqualToString:[NSString stringWithFormat:@"%.2f", self.ruleModel.discountMoney]] ||
        self.ruleModel.money == self.ruleModel.discountMoney) {
        orignMoneyStr = @"";
    } else {
        orignMoneyStr = [NSString stringWithFormat:@"%.0f",self.ruleModel.money];
    }
    
    //折后价
    NSString *currentMoneyStr = [NSString stringWithFormat:@"¥%.2f",self.ruleModel.discountMoney];;
    if (self.ruleModel.discountMoney > 0) {
        NSString *moneyStr = [NSString stringWithFormat:@"%@ %@",orignMoneyStr,currentMoneyStr];
        NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        [moneyAttr addAttributes:@{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:12],
            NSForegroundColorAttributeName: kRGB_COLOR(@"#999999"),
            NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
        }
                           range:NSMakeRange(0, orignMoneyStr.length)];
        
        [moneyAttr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName: kRGB_COLOR(@"#999999")} range:NSMakeRange(orignMoneyStr.length+1,currentMoneyStr.length)];
        self.moneyLabel.attributedText = moneyAttr;
        
    }else{
        NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:currentMoneyStr];
        self.moneyLabel.textColor = kRGB_COLOR(@"#999999");
        self.moneyLabel.font = [UIFont boldSystemFontOfSize:14];
        self.moneyLabel.attributedText = moneyAttr;
    }
    
    //限时折
    if (self.ruleModel.dicountDesr.length > 0) {
        self.limitTimeDiscountImageV.hidden = NO;
        self.dicountDesrLab.text = self.ruleModel.dicountDesr;
    }else{
        self.limitTimeDiscountImageV.hidden = YES;
    }
}


- (void)createUI{
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
    
    UILabel *coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, spaceV, self.width, 20)];
    coinLabel.textAlignment = NSTextAlignmentCenter;
    coinLabel.font = [UIFont boldSystemFontOfSize:16];
    self.coinLabel = coinLabel;
    [subV addSubview:self.coinLabel];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, coinLabel.maxY, self.width, 20)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel = moneyLabel;
    [subV addSubview:self.moneyLabel];
    
    //限时折
    {
        CGFloat scale2 = 50/140.0;
        UIImageView  *limitTimeDiscountImageV = [[UIImageView alloc]initWithFrame:CGRectMake(-2, -(self.width*scale2*0.6)/3.0, self.width*0.6, self.width*scale2*0.6)];
        limitTimeDiscountImageV.image = [UIImage imageNamed:@"icon_account_discount"];
        self.limitTimeDiscountImageV = limitTimeDiscountImageV;
        [self addSubview:limitTimeDiscountImageV];
        
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, limitTimeDiscountImageV.width, 20)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.font = [UIFont systemFontOfSize:10];
        [limitTimeDiscountImageV addSubview:tipLabel];
        self.dicountDesrLab = tipLabel;
    }
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
