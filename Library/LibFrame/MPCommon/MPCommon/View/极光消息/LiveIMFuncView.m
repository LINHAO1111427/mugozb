//
//  LiveIMFuncView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/31.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveIMFuncView.h"
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjBase/LibProjBase.h>
#import <TXImKit/TXImKit.h>
#import <LibProjView/IMMessageObserver.h>

@interface LiveIMFuncView ()<IMObserverDelegate>

@property (nonatomic, weak)UIView *redIcon;

@end

@implementation LiveIMFuncView

- (void)dealloc
{
    [IMMessageObserver removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:liveRoomWillAppearNotify object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        [IMMessageObserver addDelegate:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:liveRoomWillAppearNotify object:nil];
    }
    return self;
}


- (void)viewWillAppear:(NSNotification *)notify{
    [self getAppMessageNotiReadData];
}


- (void)createUI{
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, 0, self.width, self.height);
    [btn setBackgroundImage:[UIImage imageNamed:@"live_im_message"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *redIcon = [[UIView alloc] initWithFrame:CGRectMake(self.width-12, 3, 9, 9)];
    redIcon.backgroundColor = [UIColor redColor];
    redIcon.layer.cornerRadius = 4.5;
    redIcon.layer.masksToBounds = YES;
    redIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    redIcon.layer.borderWidth = 1.0;
    [self addSubview:redIcon];
    _redIcon = redIcon;
    _redIcon.hidden = YES;
    [self getAppMessageNotiReadData];
    
}

- (void)NotificationUpdateStatusNoti:(NSNotification *)notify{
    [self getAppMessageNotiReadData];
}

- (void)messageBtnClick:(UIButton *)btn{
    [RouteManager routeForName:RN_Message_MessageList currentC:[ProjConfig currentVC]];
}

- (void)getAppMessageNotiReadData{
    [[IMSocketIns getIns] getAllUnreadMsgCount:^(int totalCount) {
        self.redIcon.hidden = (totalCount >0)?NO:YES;
    } fail:^(int code, NSString * _Nonnull desc) {
       // NSLog(@"过滤文字####【IM反馈】#### 获取所有消息未读数失败"));
    }];
}





#pragma mark  - IMObserverDelegate -
- (void)onConversationChanged:(NSArray<V2TIMConversation *> *)conversationList{
    [self getAppMessageNotiReadData];
}

@end
