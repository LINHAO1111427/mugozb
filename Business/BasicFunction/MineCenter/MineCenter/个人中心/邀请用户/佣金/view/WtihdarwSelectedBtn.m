//
//  WtihdarwSelectedBtn.m
//  MineCenter
//
//  Created by klc on 2020/5/22.
//

#import "WtihdarwSelectedBtn.h"

@interface WtihdarwSelectedBtn()
@property (nonatomic, strong)UIImageView *subV;
@property (nonatomic, strong)UILabel *coinLabel;
@property (nonatomic, strong)UILabel *dicountDesrLab; ///折扣信息

@end

@implementation WtihdarwSelectedBtn

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setRuleModel:(FixedWithdrawRuleVOModel *)ruleModel {
    _ruleModel = ruleModel;
    
    self.coinLabel.text = [NSString stringWithFormat:@"¥%.2f",self.ruleModel.withdrawNum];

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
    
    UILabel *coinLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, spaceV, self.width, subV.height-(spaceV*2))];
    coinLabel.textAlignment = NSTextAlignmentCenter;
    coinLabel.font = [UIFont boldSystemFontOfSize:16];
    self.coinLabel = coinLabel;
    [subV addSubview:self.coinLabel];
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
