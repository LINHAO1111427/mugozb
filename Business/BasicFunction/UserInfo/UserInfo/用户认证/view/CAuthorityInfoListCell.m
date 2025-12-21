//
//  CAuthorityInfoListCell.m
//  MineCenter
//
//  Created by klc_sl on 2021/11/9.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "CAuthorityInfoListCell.h"


@implementation  CAuthorityInfoListModel

@end


@implementation  CAuthorityInfoListSectionModel

@end


@implementation CAuthorityInfoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.requiredStar];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.contentL];
    [self.contentView addSubview:self.moreImageV];
    
}
- (void)setModel:(CAuthorityInfoListModel *)model{
    _model = model;
    self.requiredStar.hidden = YES;
    if (model.isReauired) {
        self.requiredStar.hidden = NO;
    }
    self.titleL.text = model.title;
    self.contentL.placeholder = model.placeHolder;
    self.contentL.text = model.content;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 140, 20)];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textColor = kRGB_COLOR(@"#666666");
    }
    return _titleL;
}
- (UITextField *)contentL{
    if (!_contentL) {
        _contentL = [[UITextField alloc]initWithFrame:CGRectMake(_titleL.maxX, 0, kScreenWidth-180, 40)];
        _contentL.textAlignment = NSTextAlignmentRight;
        _contentL.font = [UIFont systemFontOfSize:13];
        _contentL.enabled = NO;
        _contentL.textColor = kRGB_COLOR(@"#333333");
    }
    return _contentL;
}
- (UILabel *)requiredStar{
    if (!_requiredStar) {
        _requiredStar = [[UILabel alloc]initWithFrame:CGRectMake(8, 10, 7, 20)];
        _requiredStar.hidden = YES;
        _requiredStar.font = [UIFont systemFontOfSize:15];
        _requiredStar.text = @"*";
        _requiredStar.textColor = [ProjConfig normalColors];
        _requiredStar.textAlignment = NSTextAlignmentCenter;
    }
    return _requiredStar;
}
- (UIImageView *)moreImageV{
    if (!_moreImageV) {
        _moreImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_contentL.maxX+7, 13, 8, 14)];
        _moreImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    }
    return _moreImageV;
}
@end
