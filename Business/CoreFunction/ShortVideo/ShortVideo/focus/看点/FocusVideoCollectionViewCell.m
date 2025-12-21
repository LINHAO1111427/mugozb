//
//  FocusVideoCollectionViewCell.m
//  ShortVideo
//
//  Created by KLC on 2020/6/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FocusVideoCollectionViewCell.h"
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
@interface FocusVideoCollectionViewCell()

@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIButton *numTitleBtn;

@end

@implementation FocusVideoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.bounds];
    imgV.clipsToBounds = YES;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView = imgV;
    [self.contentView addSubview:self.bgImageView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(1, 1);
    gradient.endPoint = CGPointMake(1, 0.3);
    gradient.frame = self.bgImageView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id) kRGBA_COLOR(@"#696969", 0.5).CGColor,(id) kRGBA_COLOR(@"#696969", 0.0).CGColor,nil];
    [self.bgImageView.layer insertSublayer:gradient atIndex:0];
    
    self.numTitleBtn = [UIButton buttonWithType:0];
    [self.bgImageView addSubview:self.numTitleBtn];
    self.numTitleBtn.backgroundColor = kRGB_COLOR(@"#E065F0");
    self.numTitleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.numTitleBtn.layer.masksToBounds = YES;
    self.numTitleBtn.layer.cornerRadius = 3.0;
    self.numTitleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.numTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numTitleBtn setTitle:@"0" forState:UIControlStateNormal];
    [self.numTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView).offset(6);
        make.right.equalTo(self.bgImageView).offset(-6);
        make.height.mas_equalTo(20);
    }];
}


- (void)setModel:(AppHotSortModel *)model{
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    [self.numTitleBtn setTitle:[NSString stringWithFormat:@"%@ #%@#",[NSString stringForCompressNum:model.number],model.name] forState:UIControlStateNormal];
}

@end
