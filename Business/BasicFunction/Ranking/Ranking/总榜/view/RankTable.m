//
//  RankTable.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RankTable.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface RankTable()
 
@end

@implementation RankTable
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerHeight:(CGFloat)height{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self addVisable:height];
    }
    return self;
}
- (void)addVisable:(CGFloat)height{
    CALayer *whiteLayer = [[CALayer alloc]init];
    whiteLayer.frame = CGRectMake(0,60 ,kScreenWidth,height);
    whiteLayer.backgroundColor = [UIColor whiteColor].CGColor;
    whiteLayer.zPosition = -1;
    [self.layer addSublayer:whiteLayer];
    
    
    CATextLayer * noDataTextLayer = [CATextLayer layer];
    noDataTextLayer.frame = CGRectMake(15,110, kScreenWidth-30, 20);
    noDataTextLayer.backgroundColor = [UIColor whiteColor].CGColor;
    noDataTextLayer.string = kLocalizationMsg(@"没有更多数据哦~");
    noDataTextLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:14]);
    noDataTextLayer.fontSize = 14.f;
    noDataTextLayer.contentsScale = 2;
    noDataTextLayer.alignmentMode = kCAAlignmentCenter;
    noDataTextLayer.foregroundColor = kRGB_COLOR(@"#666666").CGColor;
    self.textLayer = noDataTextLayer;
    [self.layer insertSublayer:noDataTextLayer atIndex:0];
 
}
- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView* tmpView = [super hitTest:point withEvent:event];
    if (tmpView == self) {
        return nil;
    }
    return tmpView;
}

@end
