//
//  SANavHeaderView.m
//  LibProjView
//
//  Created by klc on 2020/7/21.
//  Copyright © 2020 . All rights reserved.
//

#import "SANavHeaderView.h"
#import "SAProvinceModel.h"

@interface SANavHeaderView()<UITextViewDelegate>
@property (nonatomic, copy)NSString *str_one;
@property (nonatomic, copy)NSString *str_two;
@property (nonatomic, copy)NSString *str_three;

@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIButton *str_oneBtn;
@property (nonatomic, strong)UIButton *str_twoBtn;
@property (nonatomic, strong)UIButton *str_threeBtn;
@end

@implementation SANavHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.str_oneBtn];
    [self addSubview:self.str_twoBtn];
    [self addSubview:self.str_threeBtn];
    self.line.centerX = self.str_oneBtn.centerX;
    [self addSubview:self.line];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1.0, self.width, 0.5)];
    line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
    [self addSubview:line];
}
- (void)updateDataWith:(SASelctedModel *)model selectedIndex:(NSInteger)index{
    self.str_one = kLocalizationMsg(@"请选择");
    self.str_two = @"";
    self.str_three = @"";
    CGFloat x2 = 60,x3 = 0,x = 12;
    if (model.areaName_one.length > 0) {
        self.str_one = model.areaName_one;
    }
    if (model.areaName_two.length > 0) {
        self.str_two = model.areaName_two;
    }
    if (model.areaName_three.length > 0) {
        self.str_three = model.areaName_three;
    }
     
    if (self.str_one.length > 0) {
        CGSize size = [self.str_one boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        self.str_oneBtn.width = size.width+10;
    }
    x += self.str_oneBtn.width;
    x2 = x;
    if (self.str_two.length > 0) {
        CGSize size = [self.str_two boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        self.str_twoBtn.width = size.width+10;
    }
    x += self.str_twoBtn.width;
    x3 = x;
    if (self.str_three.length > 0) {
        CGSize size = [self.str_three boundingRectWithSize:CGSizeMake(kScreenWidth-24, 20) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        self.str_threeBtn.width = size.width+10;
    }
    
    if (index == 0) {
        self.str_oneBtn.selected = YES;
        self.str_twoBtn.selected = NO;
        self.str_threeBtn.selected = NO;
        self.line.centerX = self.str_oneBtn.centerX;
    }else if (index == 1){
        self.str_oneBtn.selected = NO;
        self.str_twoBtn.selected = YES;
        self.str_threeBtn.selected = NO;
        self.line.centerX = self.str_twoBtn.centerX;
    }else if (index == 2){
        self.str_oneBtn.selected = NO;
        self.str_twoBtn.selected = NO;
        self.str_threeBtn.selected = YES;
        self.line.centerX = self.str_threeBtn.centerX;
    }
    self.str_twoBtn.x = x2;
    self.str_threeBtn.x = x3;
    [self.str_oneBtn setTitle:self.str_one forState:UIControlStateNormal];
    [self.str_twoBtn setTitle:self.str_two forState:UIControlStateNormal];
    [self.str_threeBtn setTitle:self.str_three forState:UIControlStateNormal];
}
 
- (void)selectedBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SANavHeaderView:didSelectedAt:)]) {
        [self.delegate SANavHeaderView:self didSelectedAt:btn.tag];
    }
}
 
#pragma mark - 懒加载
- (UIButton *)str_oneBtn{
    if (!_str_oneBtn) {
        _str_oneBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, 5, 60, 30)];
        _str_oneBtn.backgroundColor = [UIColor whiteColor];
        _str_oneBtn.tag = 0;
        [_str_oneBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_str_oneBtn setTitle:kLocalizationMsg(@"请选择") forState:UIControlStateNormal];
        [_str_oneBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [_str_oneBtn setTitleColor:kRGB_COLOR(@"#FF5500") forState:UIControlStateSelected];
        _str_oneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _str_oneBtn;;
}
- (UIButton *)str_twoBtn{
    if (!_str_twoBtn) {
        _str_twoBtn = [[UIButton alloc]initWithFrame:CGRectMake(_str_oneBtn.maxX, 5, 60, 30)];
        _str_twoBtn.backgroundColor = [UIColor whiteColor];
        _str_twoBtn.tag = 1;
        [_str_twoBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_str_twoBtn setTitle:@"" forState:UIControlStateNormal];
        [_str_twoBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [_str_twoBtn setTitleColor:kRGB_COLOR(@"#FF5500") forState:UIControlStateSelected];
        _str_twoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _str_twoBtn;
}
- (UIButton *)str_threeBtn{
    if (!_str_threeBtn) {
        _str_threeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_str_twoBtn.maxX, 5, 60, 30)];
        _str_threeBtn.backgroundColor = [UIColor whiteColor];
        _str_threeBtn.tag = 2;
        [_str_threeBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_str_threeBtn setTitle:@"" forState:UIControlStateNormal];
        [_str_threeBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [_str_threeBtn setTitleColor:kRGB_COLOR(@"#FF5500") forState:UIControlStateSelected];
        _str_threeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _str_threeBtn;;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, 36, 30, 3.0)];
        _line.backgroundColor = kRGB_COLOR(@"#FF5500");
    }
    return _line;
}
@end
