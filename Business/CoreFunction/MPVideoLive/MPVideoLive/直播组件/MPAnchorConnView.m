//
//  MPAnchorConnView.m
//  MPVideoLive
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "MPAnchorConnView.h"

@interface MPAnchorConnView ()

@property (nonatomic, weak)UIView *superV;

@end

@implementation MPAnchorConnView

- (void)dealloc
{
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

- (instancetype)initWithFrame:(CGRect)frame btnSuperView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {
        _superV = superView;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *userCoverV = [[UIImageView alloc] initWithFrame:self.bounds];
    userCoverV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userCoverV];
    _userCoverImgV = userCoverV;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgV];
    _userImageV = imgV;
    
    
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled = YES;
    
    kWeakSelf(self);
    ///关闭按钮
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.maxX-38, self.y+6, 32, 32)];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_grey"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [_superV addSubview:closeBtn];
    _closeBtn = closeBtn;
    [closeBtn klc_whenTapped:^{
        if (weakself.closeLinkMic) {
            weakself.closeLinkMic();
        }
    }];
}

@end
