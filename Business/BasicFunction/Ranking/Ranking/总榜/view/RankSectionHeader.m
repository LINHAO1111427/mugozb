//
//  RankSectionHeader.m
//  Ranking
//
//  Created by ssssssss on 2020/12/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RankSectionHeader.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface RankSelectedBtn : UIControl
@property (nonatomic, assign)BOOL isSelected;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UIView *indicateLine;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@end
@implementation RankSelectedBtn
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIWith:title];
    }
    return self;
}
- (void)createUIWith:(NSString *)title{
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.width, 20)];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = title;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.textColor = kRGB_COLOR(@"#666666");
    self.titleL = titleL;
    [self addSubview:titleL];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, titleL.maxY+5, 12, 5)];
    line.hidden = YES;
    line.backgroundColor = [ProjConfig normalColors];
    line.layer.cornerRadius = 2.5;
    line.centerX = self.width/2.0;
    line.clipsToBounds = YES;
    self.indicateLine = line;
    [self addSubview:line];
}
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleL.textColor = [ProjConfig normalColors];
        self.titleL.font = [UIFont boldSystemFontOfSize:15];
        self.indicateLine.hidden = NO;
    }else{
        self.titleL.textColor = kRGB_COLOR(@"#666666");
        self.titleL.font = [UIFont systemFontOfSize:14];
        self.indicateLine.hidden = YES;
    }
}
@end

@interface RankSectionHeader()
@property (nonatomic, strong)UIView *contentV;
@property (nonatomic, strong)NSArray *titles;
@end
@implementation RankSectionHeader
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    UIView *contentV = [[UIView alloc]initWithFrame:self.bounds];
    contentV.backgroundColor = [UIColor whiteColor];
    UIBezierPath*maskPath = [UIBezierPath bezierPathWithRoundedRect:contentV.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft) cornerRadii:CGSizeMake(12,12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = contentV.bounds;
    maskLayer.path = maskPath.CGPath;
    contentV.layer.mask = maskLayer;
    self.contentV = contentV;
    [self addSubview:contentV];
    
    //按钮
    if (self.titles.count > 0) {
        CGFloat WW = kScreenWidth/self.titles.count;
        for (int i = 0; i < self.titles.count; i++) {
            NSString *title = self.titles[i];
            RankSelectedBtn *btn = [[RankSelectedBtn alloc]initWithFrame:CGRectMake(i*WW, 0, WW, self.height) title:title];
            btn.backgroundColor = [UIColor clearColor];
            btn.tag = i+9949;
            if (i == 0) {
                btn.isSelected = YES;
            }
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [contentV addSubview:btn];
        }
    }
}

- (void)btnClick:(RankSelectedBtn *)btn{
    [self selectOneIndex:(int)(btn.tag-9949)];
}


- (void)setSelectIndex:(int)selectIndex{
    [self selectOneIndex:selectIndex];
}


///选择某一项
- (void)selectOneIndex:(int)index{
    for (UIView *subV in self.contentV.subviews) {
        if ([subV isKindOfClass:[RankSelectedBtn class]]) {
            RankSelectedBtn *btttn = (RankSelectedBtn *)subV;
            if (index != (btttn.tag-9949)) {
                btttn.isSelected = NO;
            }else{
                btttn.isSelected = YES;
            }
        }
    }
    if (self.btnClickCallBack) {
        self.btnClickCallBack(index);
    }
}



@end
