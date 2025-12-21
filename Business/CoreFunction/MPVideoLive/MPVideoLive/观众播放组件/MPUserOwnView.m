//
//  MPUserOwnView.m
//  MPVideoLive
//
//  Created by admin on 2020/5/11.
//  Copyright © 2020 Orely. All rights reserved.
//

#import "MPUserOwnView.h"
#import <AVFoundation/AVFoundation.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>

@implementation MPUserOwnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self alertPermissions];
        [self createUI];
    }
    return self;
}


- (void)alertPermissions{
    //弹出相机权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    }];
    //弹出麦克风权限
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
    }];
}


- (void)createUI{
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgV];
    _userImage = imgV;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.userInteractionEnabled = YES;
    
    kWeakSelf(self);
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(6, 6, 32, 32)];
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_white_mini"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [self addSubview:closeBtn];
    [closeBtn klc_whenTapped:^{
        if (weakself.closeLinkMic) {
            weakself.closeLinkMic();
        }
    }];
    _closeBtn = closeBtn;
    UIButton *cameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-38, 6, 32, 32)];
    [cameraBtn setImage:[UIImage imageNamed:@"live_fanzhuan_camera"] forState:UIControlStateNormal];
    [cameraBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    [self addSubview:cameraBtn];
    [cameraBtn klc_whenTapped:^{
        if (weakself.rotateCamera) {
            weakself.rotateCamera();
        }
    }];
    _cameraBtn = cameraBtn;
}



@end
