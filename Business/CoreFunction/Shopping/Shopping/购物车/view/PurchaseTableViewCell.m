//
//  PurchaseTableViewCell.m
//  Shopping
//
//  Created by klc on 2020/7/9.
//  Copyright © 2020 klc. All rights reserved.
//

#import "PurchaseTableViewCell.h"
#import "KeyboardToolBar.h"
#import <LibProjModel/ShopCarModel.h>

@interface PurchaseSelectNumView : UIView<UITextFieldDelegate>

@property (nonatomic, assign)int showNum;
@property (nonatomic, copy)void(^selectOneNum)(int num);

@property (nonatomic, weak)UIButton *subtractionBtn;
@property (nonatomic, weak)UIButton *addBtn;
@property (nonatomic, weak)UITextField *commodityNumTextField;//商品数目

@end

@implementation PurchaseSelectNumView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.borderColor = kRGB_COLOR(@"#EAEAEA").CGColor;
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 0.5;
        
        UIButton *subtractionBtn = [UIButton buttonWithType:0];
        [subtractionBtn setTitle:@"-" forState:UIControlStateNormal];
        subtractionBtn.backgroundColor = [UIColor clearColor];
        [subtractionBtn addTarget:self action:@selector(subtractionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [subtractionBtn setTitleColor:kRGB_COLOR(@"#EAEAEA") forState:UIControlStateNormal];
        [self addSubview:subtractionBtn];
        self.subtractionBtn = subtractionBtn;
        [subtractionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(35);
            make.left.top.bottom.equalTo(self);
        }];
        
        UIButton *addBtn = [UIButton buttonWithType:0];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        addBtn.backgroundColor = [UIColor clearColor];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [self addSubview:addBtn];
        self.addBtn = addBtn;
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(35);
            make.right.top.bottom.equalTo(self);
        }];
        
        UITextField *textField = [[UITextField alloc]init];
        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = kRGB_COLOR(@"#333333");
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:14];
        textField.layer.borderWidth = 0.5;
        textField.text = @"1";
        textField.layer.borderColor = kRGB_COLOR(@"#EAEAEA").CGColor;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.inputAccessoryView = [[KeyboardToolBar alloc]initWithArray:@[textField]];
        [self addSubview:textField];
        self.commodityNumTextField = textField;
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(subtractionBtn.mas_right);
            make.right.equalTo(addBtn.mas_left);
        }];
    }
    return self;
}



- (void)setShowNum:(int)showNum{
    _showNum = showNum;
    self.commodityNumTextField.text = [NSString stringWithFormat:@"%d",showNum];
    [self.subtractionBtn setTitleColor:(showNum <=1)?kRGB_COLOR(@"#EAEAEA"):kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    [self.addBtn setTitleColor:(showNum >= 1000)?kRGB_COLOR(@"#EAEAEA"):kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
}

- (void)addBtnClick:(UIButton *)btn{
    self.showNum += 1;
    self.selectOneNum?self.selectOneNum(self.showNum):nil;
}

- (void)subtractionBtnClick:(UIButton *)btn{
    self.showNum = MAX(self.showNum-1, 1);
    self.selectOneNum?self.selectOneNum(self.showNum):nil;
}


#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger showNum =  [textField.text integerValue];
    if (showNum == 0) {
        self.commodityNumTextField.text = [NSString stringWithFormat:@"%d",_showNum];
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"商品数量不能为0")];
    }else if (showNum > 1000){
        self.showNum = 1000;
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"数量修改失败，超出数量或限购限制!")];
        self.selectOneNum?self.selectOneNum(self.showNum):nil;
    }else{
        self.showNum = [textField.text intValue];
        self.selectOneNum?self.selectOneNum(self.showNum):nil;
    }
}



@end





@interface PurchaseTableViewCell()

@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIView *lineV;
@property (nonatomic, strong)CAShapeLayer *maskLayer;
@property (nonatomic, strong)UIButton *selectedBtn;
@property (nonatomic, strong)UIButton *commodityImageBtn;//商品图片
@property (nonatomic, strong)UILabel *commodityTitleLabel;//商品名称
@property (nonatomic, strong)UILabel *commodityPriceLabel;//商品价格
@property (nonatomic, strong)UIButton *commodityAttBtn;

@property (nonatomic, strong)PurchaseSelectNumView *numView; ///数量

@end

@implementation PurchaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentView addSubview:self.contentV];
    ///选择btn
    _selectedBtn = [[UIButton alloc] init];
    [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_normal"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"shopCart_mark_selected"] forState:UIControlStateSelected];
    [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _selectedBtn.selected = YES;
    [self.contentV addSubview:_selectedBtn];
    
    UIControl *control = [[UIControl alloc] init];
    [control addTarget:self action:@selector(showGoodInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentV addSubview:control];
    {
        ///商品图片
        _commodityImageBtn = [[UIButton alloc] init];
        [_commodityImageBtn addTarget:self action:@selector(commodityImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _commodityImageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _commodityImageBtn.layer.cornerRadius = 5;
        _commodityImageBtn.clipsToBounds = YES;
        [control addSubview:_commodityImageBtn];
        ///商品名称
        _commodityTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_commodityImageBtn.maxX+12, _commodityImageBtn.y, _contentV.width-_commodityImageBtn.maxX-24, 40)];
        _commodityTitleLabel.textColor = kRGB_COLOR(@"#333333");
        _commodityTitleLabel.font = [UIFont systemFontOfSize:14];
        _commodityTitleLabel.textAlignment = NSTextAlignmentLeft;
        _commodityTitleLabel.numberOfLines = 2;
        [control addSubview:_commodityTitleLabel];
        
        _commodityAttBtn  = [UIButton buttonWithType:0];
        _commodityAttBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        _commodityAttBtn.backgroundColor = kRGB_COLOR(@"#F6F6F6");
        _commodityAttBtn.layer.cornerRadius = 5;
        _commodityAttBtn.clipsToBounds = YES;
        [_commodityAttBtn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
        _commodityAttBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_commodityAttBtn addTarget:self action:@selector(commodityAttBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:_commodityAttBtn];
        
        [_commodityImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.top.left.equalTo(control);
        }];
        [_commodityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(control);
            make.left.equalTo(self.commodityImageBtn.mas_right).inset(12);
        }];

        [_commodityAttBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
            make.left.equalTo(self.commodityTitleLabel);
            make.top.mas_equalTo(self.commodityTitleLabel.mas_bottom).inset(7);
        }];
    }
    
    
    _commodityPriceLabel = [[UILabel alloc] init];
    _commodityPriceLabel.font = [UIFont systemFontOfSize:16];
    _commodityPriceLabel.textAlignment = NSTextAlignmentLeft;
    _commodityPriceLabel.textColor = kRGB_COLOR(@"#FB0035");
    [self.contentV addSubview:_commodityPriceLabel];
    
    kWeakSelf(self);
    _numView = [[PurchaseSelectNumView alloc] init];
    [self.contentView addSubview:_numView];
    _numView.selectOneNum = ^(int num) {
        weakself.commodityModel.goodsNum = num;
        if (weakself.delegate) {
            [weakself.delegate PurchaseTableViewCell:weakself buyNumChange:num];
        }
    };
    
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(self.contentV);
        make.centerY.equalTo(control);
    }];
    
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
        make.top.equalTo(self.contentV).inset(16);
        make.left.equalTo(self.selectedBtn.mas_right);
        make.right.equalTo(self.contentV).inset(12);
    }];
    
    [_commodityPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.commodityImageBtn).offset(20);
        make.left.equalTo(self.commodityTitleLabel);
        make.right.equalTo(self.numView.mas_left);
    }];
    
    [_numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentV).inset(12);
        make.centerY.equalTo(self.commodityPriceLabel);
        make.size.mas_equalTo(CGSizeMake(120, 25));
    }];
    
    
    ///线
    self.lineV = [[UIView alloc] init];
    self.lineV .backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self.contentV addSubview:self.lineV];
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentV).inset(12);
        make.height.mas_equalTo(1.0);
        make.bottom.right.equalTo(self.contentV);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setLastOne:(BOOL)lastOne{
    _lastOne = lastOne;
    if (lastOne) {
        self.contentV.layer.mask = self.maskLayer;
        self.lineV.hidden = YES;
    }else{
        [self.maskLayer removeFromSuperlayer];
        self.lineV.hidden = NO;
    }
}

- (void)setIsSelectGoods:(BOOL)isSelectGoods{
    _isSelectGoods = isSelectGoods;
    self.selectedBtn.selected = isSelectGoods;
}

- (void)setCommodityModel:(ShopCarModel *)commodityModel{
    _commodityModel = commodityModel;

    NSArray *arr = [commodityModel.goodsPicture componentsSeparatedByString:@","];
    [self.commodityImageBtn sd_setImageWithURL:[NSURL URLWithString:arr.firstObject] forState:UIControlStateNormal placeholderImage:[ProjConfig getDefaultImage]];
    self.commodityTitleLabel.text = commodityModel.goodsName;
    if (commodityModel.skuName.length > 0) {
        [self.commodityAttBtn setAttributedTitle:[commodityModel.skuName attachmentForImage:[UIImage imageNamed:@"shopCart_arrow_down"] bounds:CGRectMake(0, 0, 10, 10) before:NO textFont:self.commodityAttBtn.titleLabel.font textColor:kRGB_COLOR(@"#999999")] forState:UIControlStateNormal];
        self.commodityAttBtn.hidden = NO;
    }else{
        self.commodityAttBtn.hidden = YES;
    }

    NSString *str = [NSString stringWithFormat:@"%.2f",commodityModel.goodsPrice];
    self.commodityPriceLabel.attributedText = [str attachmentForImage:[UIImage imageNamed:@"shop_icon_rmb"] bounds:CGRectMake(0, 0, 10, 10) before:YES];
    
    if (commodityModel.goodsNum > 0) {
        self.numView.showNum = commodityModel.goodsNum;
    }
    [self setNeedsLayout];
}

- (void)selectedBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseTableViewCell:selectedClick:)]) {
        [self.delegate PurchaseTableViewCell:self selectedClick:!self.isSelectGoods];
    }
}

- (void)commodityImageBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseTableViewCellCommodityClick:)]) {
        [self.delegate PurchaseTableViewCellCommodityClick:self];
    }
}

- (void)commodityAttBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseTableViewCellAttributeBtnClick:)]) {
        [self.delegate PurchaseTableViewCellAttributeBtnClick:self];
    }
}

- (void)showGoodInfo:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PurchaseTableViewCellCommodityClick:)]) {
        [self.delegate PurchaseTableViewCellCommodityClick:self];
    }
}

#pragma mark - 懒加载

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.frame = _contentV.bounds;
        _maskLayer.path = maskPath.CGPath;
    }
    return _maskLayer;
}

- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 134)];
        _contentV.backgroundColor = [UIColor whiteColor];
    }
    return _contentV;
}


@end


