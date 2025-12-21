//
//  ShopAddressTableViewCell.m
//  Shopping
//
//  Created by klc on 2020/7/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopAddressTableViewCell.h"
@interface ShopAddressTableViewCell()
@property (nonatomic, strong)UIImageView *selectedImageV;
@property (nonatomic, strong)UILabel *addressTextL;
@property (nonatomic, strong)UILabel *usernameL;
@property (nonatomic, weak)UIView *bgView;

@end
@implementation ShopAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    self.bgView = bgView;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(12);
        make.right.equalTo(self.contentView).inset(12);
        make.top.bottom.equalTo(self.contentView).inset(15);
    }];
    
    _usernameL = [[UILabel alloc]init];
    _usernameL.textAlignment = NSTextAlignmentLeft;
    _usernameL.numberOfLines = 0;
    _usernameL.font = [UIFont systemFontOfSize:14];
    _usernameL.textColor = kRGB_COLOR(@"#666666");
    [_usernameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [bgView addSubview:_usernameL];
    [_usernameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
    }];
    
    UILabel *addressTextL = [[UILabel alloc] init];
    addressTextL.font = [UIFont systemFontOfSize:14];
    addressTextL.textColor = kRGB_COLOR(@"#666666");
    addressTextL.text = kLocalizationMsg(@"请添加收货地址以确保商品顺利到达");
    addressTextL.numberOfLines = 0;
    [addressTextL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [bgView addSubview:addressTextL];
    _addressTextL = addressTextL;
    [addressTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usernameL.mas_bottom).inset(10);
        make.bottom.left.right.equalTo(bgView);
    }];

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
    }];
    
    _selectedImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 30, 20, 20)];
    _selectedImageV.image = [UIImage imageNamed:@"shopCart_mark_selected"];
    _selectedImageV.hidden = YES;
    [self.contentView addSubview:_selectedImageV];
    [_selectedImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(self.contentView).inset(12);
    }];
    
}


- (void)setIsChoice:(BOOL)isChoice{
    _isChoice = isChoice;
    self.selectedImageV.hidden = !isChoice;

    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (isChoice) {
            make.left.equalTo(self.contentView).inset(44);
        }else{
            make.left.equalTo(self.contentView).inset(12);
        }
    }];
}


- (void)setModel:(ShopAddressModel *)model{
    _model = model;
    NSString *userName = [NSString stringWithFormat:@"%@",model.userName];
    NSString *phoneNum = [NSString stringWithFormat:@"%@  ",model.phoneNum];

    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",userName,phoneNum]];
    if (model.isDefault) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 16)];
        label.textColor = kRGB_COLOR(@"#FF5500");
        label.font = [UIFont systemFontOfSize:11];
        label.backgroundColor = kRGB_COLOR(@"#FFEBE0");
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        label.text = kLocalizationMsg(@"默认");
        UIImage *image = [UIImage imageConvertFromView:label];
        NSTextAttachment *attch = [[NSTextAttachment alloc]init];
        attch.image = image;
        attch.bounds = CGRectMake(0, -3, 30, 16);
        NSAttributedString *strs = [NSAttributedString  attributedStringWithAttachment:attch];
        [attri insertAttributedString:strs atIndex:model.userName.length+model.phoneNum.length+4];
    }
    
    [attri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#666666")} range:NSMakeRange(model.userName.length+2, model.phoneNum.length)];
    [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:NSMakeRange(0, model.userName.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentNatural;  
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attri.length)];
    
    self.usernameL.attributedText = attri;
    
    NSString *address  = [NSString stringWithFormat:@"%@ %@ %@ %@",model.pro,model.city,model.area,model.address];
    self.addressTextL.attributedText = [address lineSpace:2];
}


@end
