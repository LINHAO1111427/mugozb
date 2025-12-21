//
//  UserInfoGroupDetailView.m
//  UserInfo
//
//  Created by shirley on 2021/12/17.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "UserInfoGroupDetailView.h"

@implementation UserInfoGroupDetailView
@end




@implementation UserInfoGroupTitleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    }
    return self;
}


+ (CGFloat)viewHeight{
    return 30.0;
}

- (UILabel *)sectionL{
    if (!_sectionL) {
        UILabel *sectionL = [[UILabel alloc] init];
        sectionL.textColor = kRGB_COLOR(@"#333333");
        sectionL.textAlignment = NSTextAlignmentLeft;
        sectionL.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:sectionL];
        _sectionL = sectionL;
        [sectionL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self).inset(15);
            make.centerY.equalTo(self);
        }];
    }
    return _sectionL;
}


@end






@implementation EditUserInfoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *moreImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_contentL.maxX+7, 20, 7, 13)];
    moreImageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    moreImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:moreImageV];
    _moreImageV = moreImageV;
    [moreImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 13));
        make.right.equalTo(self.contentView).inset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 140, 20)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.font = [UIFont systemFontOfSize:15];
    [titleL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [titleL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    titleL.textColor = kRGB_COLOR(@"#666666");
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(15);
        make.centerY.equalTo(self.contentView);
    }];
    
    UITextField *contentL = [[UITextField alloc]initWithFrame:CGRectMake(_titleL.maxX, 5, kScreenWidth-180, 40)];
    contentL.textAlignment = NSTextAlignmentRight;
    contentL.font = [UIFont systemFontOfSize:14];
    contentL.enabled = NO;
    [contentL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [contentL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    contentL.textColor = kRGB_COLOR(@"#333333");
    [self.contentView addSubview:contentL];
    _contentL = contentL;
    [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleL.mas_right).inset(10);
        make.right.equalTo(_moreImageV).inset(moreImageV.width+5);
        make.centerY.equalTo(_moreImageV);
    }];
    
    UILabel *requiredStar = [[UILabel alloc] init];
    requiredStar.hidden = YES;
    requiredStar.font = [UIFont systemFontOfSize:15];
    requiredStar.text = @"*";
    requiredStar.textColor = [ProjConfig normalColors];
    requiredStar.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:requiredStar];
    _requiredStar = requiredStar;
    [requiredStar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleL).inset(0);
        make.right.equalTo(titleL.mas_left).inset(2);
    }];
}


- (void)setModel:(EditUserInfoListModel *)model{
    _model = model;
    self.titleL.text = model.title;
    self.contentL.placeholder = model.placeHolder;
    self.contentL.text = model.content;
    self.isRequired = model.isReauired;
}

- (void)setIsRequired:(BOOL)isRequired{
    _isRequired = isRequired;
    self.requiredStar.hidden = !isRequired;
}


+ (CGFloat)cellHeight{
    return 40.0;
}

@end







@implementation  EditUserInfoListModel
@end


@implementation  EditUserListSectionModel
@end
