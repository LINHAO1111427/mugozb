//
//  TrySeeCountDownView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/11/5.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "TrySeeCountDownView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>

@implementation TrySeeCountDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI{
    
    UIView *cover = [[UIView alloc] init];
    cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addSubview:cover];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    cover.layer.masksToBounds = YES;
    cover.layer.cornerRadius = 10;
    
    UIView *headerCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cover.width, 40)];
    headerCover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [cover addSubview:headerCover];
    [headerCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    ///标题
    UILabel *titleL = [[UILabel alloc] init];
    [self addSubview:titleL];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.attributedText = [kLocalizationMsg(@"试看倒计时") attachmentForImage:[UIImage imageNamed:@"live_trySee_clock"] bounds:CGRectMake(0, -4, 18, 18) before:YES];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = [UIColor whiteColor];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(headerCover.mas_height);
    }];
    
    UILabel *detailL = [[UILabel alloc] init];
    [self addSubview:detailL];
    detailL.textAlignment = NSTextAlignmentCenter;
    detailL.font = [UIFont systemFontOfSize:50];
    detailL.textColor = [UIColor whiteColor];
    _lastTimeL = detailL;
    [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(titleL.mas_bottom);
    }];

}

@end
