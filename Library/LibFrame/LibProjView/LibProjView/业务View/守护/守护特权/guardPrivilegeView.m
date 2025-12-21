//
//  guardPrivilegeView.m
//  LibProjView
//
//  Created by ssssssss on 2020/12/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "guardPrivilegeView.h"


@interface guardPrivilegeView()
@property (nonatomic, assign)BOOL fromUserInfo;
@property (nonatomic, assign)CGFloat contentY;
@property (nonatomic, strong)UIView *contentV;
@end

@implementation guardPrivilegeView
- (instancetype)initWithFrame:(CGRect)frame from:(BOOL)fromUserInfo contentY:(CGFloat)contentY{
    self = [super initWithFrame:frame];
    if (self) {
        self.fromUserInfo = fromUserInfo;
        self.contentY = contentY;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, self.contentY, kScreenWidth, 2)];
    self.contentV = contentV;
    contentV.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentV];
    CGFloat y = self.contentY;
    CGFloat pt = kScreenWidth/375.0;
    if (self.fromUserInfo) {//从个人主页
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(20, y+10, kScreenWidth-40, 20)];
        titleL.textColor = kRGB_COLOR(@"#333333");
        titleL.font = [UIFont boldSystemFontOfSize:16];
        titleL.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:kLocalizationMsg(@"守护特权")];
        //右
        NSTextAttachment *leftAttach = [[NSTextAttachment alloc]init];
        leftAttach.image = [UIImage imageNamed:@"icon_guard_privilege_right"];
        leftAttach.bounds = CGRectMake(0, -2, 16, 16);
        NSAttributedString *leftStringImage = [NSAttributedString attributedStringWithAttachment:leftAttach];
        [att insertAttributedString:leftStringImage atIndex:4];
        //左
        NSTextAttachment *rightAttach = [[NSTextAttachment alloc]init];
        rightAttach.image = [UIImage imageNamed:@"icon_guard_privilege_left"];
        rightAttach.bounds = CGRectMake(0, -2, 16, 16);
        NSAttributedString *rightStringImage = [NSAttributedString attributedStringWithAttachment:rightAttach];
        [att insertAttributedString:rightStringImage atIndex:0];
        
        titleL.attributedText = att;
        [self addSubview:titleL];
        y += 40;
    }
    
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    [itemArr addObject:@{@"title":kLocalizationMsg(@"获得守护专属勋章"),@"imageName":@"icon_guard_privilege_0",@"scale":@(300.0/650.0)}];
    if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
        [itemArr addObject:@{@"title":kLocalizationMsg(@"获得守护专属进场标识"),@"imageName":@"icon_guard_privilege_1",@"scale":@(400.0/650.0)}];
    }
    [itemArr addObject:@{@"title":kLocalizationMsg(@"赠送守护专属礼物"),@"imageName":@"icon_guard_privilege_2",@"scale":@(725.0/650.0)}];
    if ([ProjConfig isContainMPVideo] || [ProjConfig isContainMPVoice]) {
        [itemArr addObject:@{@"title":kLocalizationMsg(@"获得守护专属聊天皮肤"),@"imageName":@"icon_guard_privilege_3",@"scale":@(344.0/650.0)}];
    }

    for (int i = 0; i < itemArr.count; i++) {
        
        NSDictionary *dic = itemArr[i];
        
        UILabel *partL = [[UILabel alloc]initWithFrame:CGRectMake(25, y+10, kScreenWidth-50, 20)];
        partL.textAlignment = NSTextAlignmentLeft;
        partL.font = [UIFont boldSystemFontOfSize:18];
        partL.textColor = [ProjConfig normalColors];
        partL.text = [NSString stringWithFormat:@"Part.%d",i+1];
        [self addSubview:partL];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(25, partL.maxY+10, kScreenWidth-50, 20)];
        titleL.textAlignment = NSTextAlignmentLeft;
        titleL.font = [UIFont systemFontOfSize:18];
        titleL.textColor = kRGB_COLOR(@"#333333");
        [self addSubview:titleL];
        y += 70;
        CGFloat scale = [dic[@"scale"] floatValue];
        titleL.text = dic[@"title"];
        
        CGFloat imageH = (kScreenWidth-50)*scale*pt;
        UIImageView *contentImageV = [[UIImageView alloc]initWithFrame:CGRectMake(25, titleL.maxY+10, kScreenWidth-50, imageH)];
        contentImageV.layer.cornerRadius = 10;
        contentImageV.image = [UIImage imageNamed:dic[@"imageName"]];
        contentImageV.clipsToBounds = YES;
        contentImageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:contentImageV];
        y += imageH;
        y += 50;
    }
    contentV.height = y - self.contentY;
    
    self.contentSize = CGSizeMake(kScreenWidth, y+kSafeAreaBottom);
    
    if (self.fromUserInfo) {
        [contentV cornerRadii:CGSizeMake(12,12) byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft)];
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self.contentV) {
        return self.contentV;
    }
    if(hitView == self ){
        return nil;
    }
    return hitView;
}

@end
