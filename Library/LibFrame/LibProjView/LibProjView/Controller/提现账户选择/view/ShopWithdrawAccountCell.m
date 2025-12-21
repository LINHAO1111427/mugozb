//
//  ShopWithdrawAccountCell.m
//  Shopping
//
//  Created by ssssssss on 2020/8/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopWithdrawAccountCell.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/AppUsersCashAccountModel.h>
 
@interface ShopWithdrawAccountCell()
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) UIImageView *accountLogo;
@property (strong, nonatomic) UILabel *nameL;
@property (strong, nonatomic) UIButton *deleteBtn;
@end
NSString *const ShopWithdrawAccountCellIdentifier = @"ShopWithdrawAccountCellIdentifier";
@implementation ShopWithdrawAccountCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.topBgView.backgroundColor =kRGB_COLOR(@"#EDEDED");
    self.bottomBgView.backgroundColor =kRGB_COLOR(@"#EDEDED");
    [self.contentView addSubview:self.selectBtn];
    [self.contentView addSubview:self.accountLogo];
    [self.contentView addSubview:self.nameL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDefaultModel:(AppUsersCashAccountModel *)defaultModel showModel:(AppUsersCashAccountModel *)accountModel{
    _accountModel = accountModel;
    
    _selectBtn.selected = (defaultModel.id_field == accountModel.id_field?YES:NO);
    //1表示支付宝，2表示微信，3表示银行卡
    switch (accountModel.type) {
        case 1:{
            _nameL.text = accountModel.account;
            _accountLogo.image = [UIImage imageNamed:@"mine_center_profit_alipay"];
        }
            break;
        case 2:{
            _nameL.text = accountModel.account;
            _accountLogo.image = [UIImage imageNamed:@"mine_center_profit_wx"];
        }
            break;
        case 3:{
            _nameL.text = accountModel.account;
            _accountLogo.image = [UIImage imageNamed:@"mine_center_profit_card"];
        }
            break;
        default:
            break;
    }
    
}

- (void)deleteAccount:(UIButton *)btn {
    if (self.deleteModel) {
        self.deleteModel(self.accountModel);
    }
    
}


#pragma mark - lazy load
- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-30, 30, 20, 20)];
        [_selectBtn setImage:[UIImage imageNamed:@"mine_center_profit_nor"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"mine_center_profit_sel"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
- (UIImageView *)accountLogo{
    if (!_accountLogo) {
        _accountLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    }
    return _accountLogo;
}
- (UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc]initWithFrame:CGRectMake(_accountLogo.maxX+12, 30, self.width-150, 20)];
        _nameL.font = [UIFont systemFontOfSize:16];
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.textColor = kRGB_COLOR(@"#333333");
    }
    return _nameL;
}
 
 
@end
