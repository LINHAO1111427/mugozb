//
//  ShopManageV.m
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopManageV.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@implementation ShopManageV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 100, 30)];
    titleL.text = kLocalizationMsg(@"小店管理");
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:titleL];
    
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.width, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:linkView];
    
    
    [self updateFeaturesView];
    
}


- (void)updateFeaturesView{
    
    CGFloat width = (self.width-100)/4;
    CGFloat space = 20;
  
    NSArray *titleArr = @[
        @{@"title":kLocalizationMsg(@"我的收入"),@"item_id":@0,@"imageName":@"shop_wodeshouru"},
        @{@"title":kLocalizationMsg(@"添加商品"),@"item_id":@1,@"imageName":@"shop_tianjiashangpin"},
        @{@"title":kLocalizationMsg(@"商家简介"),@"item_id":@2,@"imageName":@"shop_shangjiajianjie"},
//        @{@"title":kLocalizationMsg(@"优惠券"),@"item_id":@3,@"imageName":@"shop_youhuiquan"},
        @{@"title":kLocalizationMsg(@"商品管理"),@"item_id":@4,@"imageName":@"shop_shangpinguanli"},
//        @{@"title":kLocalizationMsg(@"满减活动"),@"item_id":@5,@"imageName":@"shop_jianmanhuodong"},
        @{@"title":kLocalizationMsg(@"直播预告"),@"item_id":@6,@"imageName":@"shop_zhibogouwu"},
        @{@"title":kLocalizationMsg(@"小店预览"),@"item_id":@7,@"imageName":@"shop_xiaodianyulan"}
    ];
    NSInteger num = titleArr.count;

    UIView *featuresView = [[UIView alloc]initWithFrame:CGRectMake(20, 60, self.width - 40, self.height - 60)];
    featuresView.backgroundColor = [UIColor clearColor];
    [self addSubview:featuresView];
    
    for (int i = 0; i < num; i++) {
        NSDictionary *dic = titleArr[i];
        NSInteger row = i/4;
        NSInteger col = i%4;
        UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(col*(width+space), row*(width+20) , width, width + 14)];
        subV.backgroundColor = [UIColor whiteColor];
        [featuresView addSubview:subV];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 6, width - 24, width -24)];
        NSString *imageName = dic[@"imageName"];
        imageV.image = [UIImage imageNamed:imageName];
        imageV.layer.cornerRadius = 10;
        imageV.clipsToBounds = YES;
        [subV addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.maxY, width, 30)];
        titleLabel.textColor =kRGB_COLOR(@"#666666");
        titleLabel.text = dic[@"title"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        [subV addSubview:titleLabel];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:subV.bounds];
        btn.tag = 100000+[dic[@"item_id"] intValue];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(feastureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [subV addSubview:btn];
    }
}


-(void)feastureBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shopManageVFunctionBtnClick:)]) {
        [self.delegate shopManageVFunctionBtnClick:sender.tag - 100000];
    }
}

@end
