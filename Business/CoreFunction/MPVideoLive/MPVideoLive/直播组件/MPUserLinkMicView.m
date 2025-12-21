//
//  MPUserLinkMicView.m
//  MPVideoLive
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "MPUserLinkMicView.h"

@implementation MPUserLinkMicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgV];
    _userImage = imgV;
    
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled = YES;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;

    
    kWeakSelf(self);
    ///关闭按钮
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-32, 0, 32, 32)];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_white_mini"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [self addSubview:closeBtn];
    [closeBtn klc_whenTapped:^{
        if (weakself.closeLinkMic) {
            weakself.closeLinkMic();
        }
    }];
     _closeBtn = closeBtn;
}

@end
