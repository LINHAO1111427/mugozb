//
//  PkStartView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/25.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "PkStartView.h"
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>

@interface PkStartView ()

@end

@implementation PkStartView

+ (void)startWithSuperView:(UIView *)superV{
    __block BOOL hasSelf = NO;
    [superV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@"PkStartView" isEqualToString:NSStringFromClass([obj class])]) {
            hasSelf = YES;
            *stop = YES;
        }
    }];
    if (!hasSelf) {
        PkStartView *startV = [[PkStartView alloc] initWithFrame:superV.bounds];
        [startV createUI];
        [superV addSubview:startV];
    }
}


- (void)createUI{
    self.userInteractionEnabled = NO;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"Pk_start"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(284, 61));
    }];
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself removeSelf];
    });
}

- (void)removeSelf{
    [self removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return nil;
}

@end
