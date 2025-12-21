//
//  SASelectedTableViewCell.m
//  LibProjView
//
//  Created by klc on 2020/7/21.
//  Copyright © 2020 . All rights reserved.
//

#import "SASelectedTableViewCell.h"
@interface SASelectedTableViewCell()
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIImageView *markImgV;
@end
@implementation SASelectedTableViewCell
- (UIImageView *)markImgV{
    if (!_markImgV) {
        _markImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-52, 0, 20, 20)];
        _markImgV.image = [UIImage imageNamed:@"shop_address_selected"];
        _markImgV.hidden = YES;
    }
    return _markImgV;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, 20, kScreenWidth-50, 30)];
        _titleL.textColor = kRGB_COLOR(@"#444444");
        _titleL.font = [UIFont systemFontOfSize:15];
        _titleL.textAlignment = NSTextAlignmentLeft;
    }
    return _titleL;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleL];
    self.markImgV.centerY = self.titleL.centerY;
    [self.contentView addSubview:self.markImgV];
}
- (void)setIsChoice:(BOOL)isChoice{
    _isChoice = isChoice;
    self.markImgV.hidden = !isChoice;
    if (isChoice) {
        self.titleL.textColor = kRGB_COLOR(@"#FF5500");
    }else{
        self.titleL.textColor = kRGB_COLOR(@"#333333");
    }
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleL.text = title;
}
@end
