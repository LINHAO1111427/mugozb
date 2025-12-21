//
//  SWHTapImage.m
//  LibProjView
//
//  Created by SWH05 on 2022/3/23.
//  Copyright © 2022 KLC. All rights reserved.
//

#import "SWHTapImageView.h"
#import <LibProjBase/ProjConfig.h>

@interface SWHTapImageView ()
@property(nonatomic,strong)UIButton *tagBtn;
@end
@implementation SWHTapImageView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (void)setBtnClick:(void (^)(int type))btnClick{
    BOOL canClick = [[ProjConfig shareInstence].baseConfig roleImageCanClick];
     if (canClick) {
         _btnClick = btnClick;
         [self removeAllSubViews];
         UIButton *btn = [[UIButton alloc]initWithFrame:self.bounds];
         btn.backgroundColor = [UIColor clearColor];
         [btn addTarget:self action:@selector(imageBtnClick) forControlEvents:UIControlEventTouchUpInside];
         [self addSubview:btn];
     }
}
 
- (void)imageBtnClick{
    if (self.btnClick) {
        self.btnClick(self.type);
    }
}
@end
