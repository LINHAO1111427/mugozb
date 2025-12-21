//
//  SV_PlayAssembly.m
//  ShortVideo
//
//  Created by tctd on 2020/6/19.
//  Copyright © 2020 tctd. All rights reserved.
//

#import "SV_PlayAssembly.h"
@interface SV_PlayAssembly()<AssemblyMsgListener,ShortV_AssemblyInterface>

@end

@implementation SV_PlayAssembly
- (void)onMsg:(AssemblyMsgListenerEnum)msgType msgDic:(NSDictionary *)msgDic{
    
}
- (void)parInitSuperV:(UIView *)superView{
    [ShortV_AssemblyMsgMgr addMsgListener:self];
}
@end
 
