//
//  LiveGameComponent.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/21.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveGameComponent.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>


#import <LiveCommon/LiveManager.h>
#import <LiveCommon/MagicBoxView.h>

@interface LiveGameComponent ()<LiveComponentMsgListener>

@end

@implementation LiveGameComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray <UIView *>*)views{
    [LiveComponentMsgMgr addMsgListener:self];
}

// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_MagicBox:
        {
            [self showMagicBox];
        }
            break;
            
        default:
            break;
    }
    
}


- (void)showMagicBox{
    [MagicBoxView showMagicBox:[LiveManager liveInfo].anchorId];

}



@end
