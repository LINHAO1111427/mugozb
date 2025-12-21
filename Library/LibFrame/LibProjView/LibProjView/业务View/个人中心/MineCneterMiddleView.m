//
//  MineCneterMiddleView.m
//  LibProjView
//
//  Created by klc_sl on 2021/2/20.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MineCneterMiddleView.h"
#import <LibTools/LibTools.h>

@implementation MineCneterMiddleView

- (void)createFunctionView:(NSArray *)funcArr{
    
    NSMutableArray *titleArray_one = [funcArr mutableCopy];
    
    if ([ProjConfig getAppType] == 2) {
        NSInteger location = -1;
        for (int t = 0; t < titleArray_one.count; t++) {
            NSDictionary *dic = titleArray_one[t];
            int index = [dic[@"item_id"] intValue];
            if (index == 1002) {
                location = t;
                break;
            }
        }
        if (location >= 0) {
            [titleArray_one removeObjectAtIndex:location];
        }
    }
    NSInteger num = (titleArray_one.count-1)/4+1;
    CGFloat height = (12*2+num*80);
    
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(12, 0, self.width-24, height)];
    shadowView.layer.shadowColor = kRGBA_COLOR(@"#666666", 0.2).CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0,0);
    shadowView.layer.shadowOpacity = 0.5;
    shadowView.layer.shadowRadius = 8;
    [self addSubview:shadowView];
    
    UIView *group_OneV = [[UIView alloc]initWithFrame:shadowView.bounds];
    group_OneV.layer.cornerRadius = 8;
    group_OneV.clipsToBounds = YES;
    group_OneV.backgroundColor = [UIColor whiteColor];
    [shadowView addSubview:group_OneV];
    
    CGFloat width = (self.width-24)/4;
    CGFloat magin = (width-40)/2.0;
    for (int i = 0; i<titleArray_one.count; i++) {
        int row = i/4;
        int col = i%4;
        
        NSDictionary *itemDic = titleArray_one[i];
        NSString *title = itemDic[@"title"];
        NSString *imageName = itemDic[@"imageName"];
        int tag = [itemDic[@"item_id"] intValue];
        UIView *itemV = [[UIView alloc]initWithFrame:CGRectMake(width*col, 10+80*row,width, 80)];
        itemV.backgroundColor = [UIColor clearColor];
        [group_OneV addSubview:itemV];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(magin,10,40, 40)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.image = [UIImage imageNamed:imageName];
        [itemV addSubview:imageV];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, width, 20)];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor = kRGB_COLOR(@"#666666");
        titleL.text = title;
        [itemV addSubview:titleL];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:itemV.bounds];
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = tag;
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [itemV addSubview:btn];
    }
    
    self.height = height;
}


- (void)itemBtnClick:(UIButton *)btn{
    NSString *title = btn.titleLabel.text;
    if (!title) {
        title = @"";
    }
    if (self.clickBtnBlock) {
        self.clickBtnBlock(title, btn.tag);
    }
}

@end
