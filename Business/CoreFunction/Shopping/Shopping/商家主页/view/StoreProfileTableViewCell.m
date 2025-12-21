//
//  StoreProfileTableViewCell.m
//  Shopping
//
//  Created by yww on 2020/7/23.
//  Copyright © 2020 klc. All rights reserved.
//

#import "StoreProfileTableViewCell.h"
#pragma mark - 简介
@interface StoreProfileTableViewCell()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIView *leftLine;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *contentL;
 
@end
@implementation StoreProfileTableViewCell
 
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.sectionModel.model.present boundingRectWithSize:CGSizeMake(kScreenWidth-48, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    if (size.height+10 > 40) {
        self.contentL.height = size.height+10;
    }
    self.contentV.height = self.sectionModel.height-12;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self.contentView addSubview:self.contentV];
    [self.contentV addSubview:self.leftLine];
    [self.contentV addSubview:self.titleL];
    [self.contentV addSubview:self.contentL];
}
- (void)setSectionModel:(StoreDetailSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    for (UIView *view in self.contentV.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    self.contentL.text = sectionModel.model.present;
    for (StoreDetailImageModel *model in self.sectionModel.images) {
        [self.contentV addSubview:model.imageV];
    }
    [self setNeedsLayout];
}



#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth-24, 0)];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.layer.cornerRadius = 10;
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}
- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UIView alloc]initWithFrame:CGRectMake(12, 13, 3, 14)];
        _leftLine.backgroundColor = kRGB_COLOR(@"#FF5500");
    }
    return _leftLine;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_leftLine.maxX+2, 0, 100, 20)];
        _titleL.textColor = kRGB_COLOR(@"#333333");
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.centerY = _leftLine.centerY;
        _titleL.font = [UIFont boldSystemFontOfSize:14];
        _titleL.text = kLocalizationMsg(@"商家简介");
    }
   return _titleL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc]initWithFrame:CGRectMake(12, _leftLine.maxY+10, _contentV.width-24, 20)];
        _contentL.textColor = kRGB_COLOR(@"#666666");
        _contentL.textAlignment = NSTextAlignmentCenter;
        _contentL.font = [UIFont boldSystemFontOfSize:12];
        _contentL.numberOfLines = 0;
    }
   return _contentL;
}
 
@end









#pragma mark - 承诺
@interface StorePromiseTableViewCell()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIView *leftLine;
@property (nonatomic, strong)UILabel *titleL;
@end

@implementation StorePromiseTableViewCell
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self.contentView addSubview:self.contentV];
    [self.contentV addSubview:self.leftLine];
    [self.contentV addSubview:self.titleL];
    CGFloat width = (kScreenWidth-24-40)/2.0;
    NSArray *titleArr = @[kLocalizationMsg(@"正品保障 假一赔十"),kLocalizationMsg(@"品质认证 优选商品"),kLocalizationMsg(@"极速退款 购物无忧"),kLocalizationMsg(@"平台甄选 用心服务")];
    for ( int i = 0; i < 4; i++) {
        int row = i/2;
        int col = i%2;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20+width*col,40+ row*40+13, 14, 14)];
        imageV.image = [UIImage imageNamed:@"shop_promise"];
        [self.contentV addSubview:imageV];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX+6,40+ 10+row*40, width-20, 20)];
        label.textColor = kRGB_COLOR(@"#333333");
        label.textAlignment = NSTextAlignmentLeft;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:12];
        [self.contentV addSubview:label];
    }
    
}

#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth-24, 120)];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.layer.cornerRadius = 10;
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}
- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UIView alloc]initWithFrame:CGRectMake(12, 13, 3, 14)];
        _leftLine.backgroundColor = kRGB_COLOR(@"#FF5500");
    }
    return _leftLine;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_leftLine.maxX+2, 0, 100, 20)];
        _titleL.textColor = kRGB_COLOR(@"#333333");
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.centerY = _leftLine.centerY;
        _titleL.font = [UIFont boldSystemFontOfSize:14];
        _titleL.text = kLocalizationMsg(@"商家承诺");
    }
   return _titleL;
}
@end






//营业执照
@interface StoreLicenseTableViewCell()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)UIView *leftLine;
@property (nonatomic, strong)UILabel *titleL;
@end
@implementation StoreLicenseTableViewCell
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentV.height = self.sectionModel.height-12;
}
- (void)createUI{
    self.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    [self.contentView addSubview:self.contentV];
    [self.contentV addSubview:self.leftLine];
    [self.contentV addSubview:self.titleL];
}
- (void)setSectionModel:(StoreDetailSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    for (UIView *view in self.contentV.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    for (StoreDetailImageModel *model in self.sectionModel.images) {
        [self.contentV addSubview:model.imageV];
    }
    [self setNeedsLayout];
}
#pragma mark - lazy load
- (UIView *)contentV{
    if (!_contentV) {
        _contentV = [[UIView alloc]initWithFrame:CGRectMake(12, 12, kScreenWidth-24, 0)];
        _contentV.backgroundColor = [UIColor whiteColor];
        _contentV.layer.cornerRadius = 10;
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}
- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UIView alloc]initWithFrame:CGRectMake(12, 13, 3, 14)];
        _leftLine.backgroundColor = kRGB_COLOR(@"#FF5500");
    }
    return _leftLine;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(_leftLine.maxX+2, 0, 100, 20)];
        _titleL.textColor = kRGB_COLOR(@"#333333");
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.centerY = _leftLine.centerY;
        _titleL.font = [UIFont boldSystemFontOfSize:14];
        _titleL.text = kLocalizationMsg(@"营业执照");
    }
   return _titleL;
}
@end
 
