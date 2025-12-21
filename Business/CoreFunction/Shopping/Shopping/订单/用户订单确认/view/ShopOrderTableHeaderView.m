//
//  ShopOrderTableHeaderView.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderTableHeaderView.h"

@interface ShopOrderTableHeaderView()

@property (nonatomic, strong)UILabel *addressTextL;

@property (nonatomic, strong)UILabel *selectNameLabel;

@property (nonatomic, weak)UIButton *addressBtn;

@property (nonatomic, copy)UIImage *defaultImg;

@end


@implementation ShopOrderTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (UIImage *)defaultImg{
    if (!_defaultImg) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 16)];
        label.textColor = kRGB_COLOR(@"#FF5500");
        label.font = [UIFont systemFontOfSize:11];
        label.backgroundColor = kRGB_COLOR(@"#FFEBE0");
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.text = kLocalizationMsg(@"默认");
        _defaultImg = [UIImage imageConvertFromView:label];
    }
    return _defaultImg;
}

- (void)createUI{
    
//    self.backgroundColor = [kRGB_COLOR(@"#F6F6F6")];
    UIButton *addressBtn = [UIButton buttonWithType:0];
    addressBtn.backgroundColor = [UIColor whiteColor];
    addressBtn.layer.cornerRadius = 10;
    addressBtn.clipsToBounds = YES;
    [addressBtn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    addressBtn.clipsToBounds = YES;
    [self addSubview:addressBtn];
    _addressBtn = addressBtn;
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(10);
        make.height.mas_equalTo(90);
        make.right.left.equalTo(self).inset(12);
    }];
    
    UIButton *localBtn = [UIButton buttonWithType:0];
    [localBtn setImage:[UIImage imageNamed:@"userinfo_location_white"] forState:UIControlStateNormal];
    localBtn.layer.cornerRadius = 18;
    localBtn.userInteractionEnabled = NO;
    localBtn.clipsToBounds = YES;;
    localBtn.backgroundColor= kRGB_COLOR(@"#FF5500");
    localBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [addressBtn addSubview:localBtn];
    [localBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.left.equalTo(addressBtn).offset(12);
        make.top.equalTo(addressBtn).inset(90/2-18);
    }];

    UIImageView *moreImageV = [[UIImageView alloc] init];
    moreImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    [addressBtn addSubview:moreImageV];
    [moreImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 14));
        make.right.equalTo(addressBtn).inset(12);
        make.centerY.equalTo(localBtn);
    }];
    
    UIView *centerV = [[UIView alloc] init];
    centerV.userInteractionEnabled = NO;
    [addressBtn addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressBtn);
        make.left.equalTo(localBtn.mas_right).inset(12);
        make.right.equalTo(moreImageV.mas_left).inset(12);
    }];
    
    _selectNameLabel = [[UILabel alloc]init];
    _selectNameLabel.textAlignment = NSTextAlignmentLeft;
    _selectNameLabel.numberOfLines = 0;
    _selectNameLabel.font = [UIFont systemFontOfSize:14];
    [_selectNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _selectNameLabel.textColor = kRGB_COLOR(@"#666666");
    [centerV addSubview:_selectNameLabel];
    [_selectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(centerV);
    }];
    
    _addressTextL = [[UILabel alloc] init];
    _addressTextL.font = [UIFont systemFontOfSize:14];
    _addressTextL.textColor = kRGB_COLOR(@"#666666");
    _addressTextL.text = kLocalizationMsg(@"请添加收货地址以确保商品顺利到达");
    _addressTextL.numberOfLines = 2;
    [_addressTextL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [centerV addSubview:_addressTextL];
    [_addressTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectNameLabel.mas_bottom).inset(3);
        make.left.right.bottom.equalTo(centerV);
    }];
    
}


- (void)setAddressModel:(ShopAddressModel *)addressModel{
    _addressModel = addressModel;

    if (addressModel.id_field) {
        
        NSString *userName = [NSString stringWithFormat:@"%@",addressModel.userName];
        NSString *phoneNum = [NSString stringWithFormat:@"%@  ",addressModel.phoneNum];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",userName,phoneNum]];

        if (addressModel.isDefault) {
            NSTextAttachment *attch = [[NSTextAttachment alloc]init];
            attch.image = self.defaultImg;
            attch.bounds = CGRectMake(0, -3, 30, 16);
            NSAttributedString *strs = [NSAttributedString attributedStringWithAttachment:attch];
            [attri appendAttributedString:strs];
        }
        
        [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, addressModel.userName.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3.0; // 设置行间距
        paragraphStyle.alignment = NSTextAlignmentNatural;
        [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attri.length)];
        self.selectNameLabel.attributedText = attri;
        
        
        NSString *address  = [NSString stringWithFormat:@"%@ %@ %@ %@",addressModel.pro,addressModel.city,addressModel.area,addressModel.address];
        self.addressTextL.text = address;
    }else{
        self.selectNameLabel.text = @"";
        self.addressTextL.text = kLocalizationMsg(@"请添加收货地址以确保商品顺利到达");
    }
}

- (void)addressBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopOrderTableHeaderViewAddressBtnClick:)]) {
        [self.delegate ShopOrderTableHeaderViewAddressBtnClick:self];
    }
}


@end
