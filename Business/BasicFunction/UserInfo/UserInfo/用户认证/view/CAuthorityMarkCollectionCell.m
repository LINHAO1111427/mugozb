//
//  CAuthorityMarkCollectionCell.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/4.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityMarkCollectionCell.h"
#import <LibProjModel/TabInfoDtoModel.h>

@interface CAuthorityMarkCollectionCell()
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation CAuthorityMarkCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
     if (self = [super initWithFrame:frame]) {
         [self creatUI];
     }
     return self;
 }
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    if (self.isSelected) {
        self.titleLabel.layer.borderColor =kRGB_COLOR(self.model.fontColor).CGColor;
        self.titleLabel.textColor =kRGB_COLOR(self.model.fontColor);
    }else{
        self.titleLabel.layer.borderColor =kRGB_COLOR(@"#CCCCCC").CGColor;
        self.titleLabel.textColor =kRGB_COLOR(@"#CCCCCC");
    }
}
- (void)creatUI{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.layer.cornerRadius = 14;
    titleLabel.clipsToBounds = YES;
    titleLabel.layer.borderWidth = 1.0;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:self.titleLabel];
}
- (void)setModel:(TabInfoDtoModel *)model{
    _model = model;
    self.titleLabel.text = model.name;
    [self setNeedsLayout];
}
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self setNeedsLayout];
}
@end
