//
//  SettleAccountsView.m
//  Shopping
//
//  Created by klc on 2020/7/18.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SettleAccountsView.h"
@interface SettleAccountsView()

@property (nonatomic, strong)UIButton *selectedBtn;//选择
@property (nonatomic, strong)UIButton *settleBtn;//结算
@property (nonatomic, strong)UILabel *amountLabel;//金额
@end

@implementation SettleAccountsView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];

    UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-kSafeAreaBottom)];
    [self addSubview:bgV];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1.0)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self addSubview:line];
    
    _selectedBtn = [UIButton buttonWithType:0];
    [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_normal"] forState:UIControlStateNormal];
    _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _selectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_selectedBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedBtn setTitle:kLocalizationMsg(@" 全选") forState:UIControlStateNormal];
    [bgV addSubview:_selectedBtn];
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 44));
        make.left.equalTo(bgV).inset(12);
        make.centerY.equalTo(bgV);
    }];
    
    _settleBtn = [[UIButton alloc]init];
    _settleBtn.layer.cornerRadius = 20;
    _settleBtn.clipsToBounds = YES;
    _settleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_settleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_settleBtn setTitle:kLocalizationMsg(@"结算") forState:UIControlStateNormal];
    [_settleBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FF5500")] forState:UIControlStateNormal];
    [_settleBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#DEDEDE")] forState:UIControlStateDisabled];
    [_settleBtn addTarget:self action:@selector(settleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgV addSubview:_settleBtn];
    [_settleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.right.equalTo(bgV).inset(12);
        make.centerY.equalTo(bgV);
    }];
    
    _amountLabel = [[UILabel alloc]init];
    _amountLabel.textAlignment = NSTextAlignmentRight;
    _amountLabel.font = [UIFont systemFontOfSize:14];
    _amountLabel.textColor = kRGB_COLOR(@"#666666");
    [bgV addSubview:_amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_settleBtn);
        make.right.equalTo(_settleBtn.mas_left).inset(15);
    }];
}

- (void)changeAmountMoney:(CGFloat)amount commodityNum:(NSInteger)num allSelected:(BOOL)allSelected{
    self.settleBtn.enabled = num;
    self.selectedBtn.selected = allSelected;
    if (allSelected) {
        [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_selected"] forState:UIControlStateNormal];
    }else{
        [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_normal"] forState:UIControlStateNormal];
    }
    [self.settleBtn setTitle:[NSString stringWithFormat:kLocalizationMsg(@"结算(%ld)"),(long)num] forState:UIControlStateNormal];
    NSMutableAttributedString *attri;
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
    attach.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
    NSString *moeny = [NSString stringWithFormat:@"%.2f",amount];
    NSString *str = [NSString stringWithFormat:kLocalizationMsg(@"合计：%@"),moeny];
    attri = [[NSMutableAttributedString alloc]initWithString:str];
    [attri insertAttributedString:attImg atIndex:3];
    [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(4, moeny.length)];
    self.amountLabel.attributedText = attri;
}

- (void)selectedBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(SettleAccountsViewSelectedBtnClick:)]) {
        [self.delegate SettleAccountsViewSelectedBtnClick:btn.selected];
    }
}
- (void)settleBtnClick:(UIButton*)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SettleAccountsViewSettleBtnClick)]) {
        [self.delegate SettleAccountsViewSettleBtnClick];
    }
}
#pragma mark - 懒加载

@end
