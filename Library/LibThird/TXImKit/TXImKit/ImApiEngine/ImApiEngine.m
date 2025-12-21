//
//  ImApiEngine.m
//  IMSocket
//
//  Created by wy on 2020/7/15.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ImApiEngine.h"
#import "NSDictionary+Json.h"
#import "IMReceiver.h"
#import <LibTools/LibTools.h> 
 
static ImApiEngine* _apiEngine = nil;

@interface ImApiEngine ()
@property (nonatomic, assign)int64_t  userId;
@property (nonatomic, strong)NSMutableDictionary *dictNameRcv;//消息类型
@property (nonatomic, strong)NSMutableDictionary *dictGroupRcv;//消息分组
@end

@implementation ImApiEngine

+ (ImApiEngine*)getIns{
    return _apiEngine;
}

- (void)initIns:(int64_t)uid{
    _apiEngine = self;
    self.userId=uid;
    self.dictNameRcv =[NSMutableDictionary new];
    self.dictGroupRcv =[NSMutableDictionary new];
}



- (void)onReceivedMsg:(V2TIMMessage*)dicMsg{
    NSDictionary *custom = dicMsg.customElem.data.jsonValue;
    NSString* subType = [custom getStr:@"subType"];
    NSString* type = [custom getStr:@"type"];
    NSDictionary* divCont=  [custom getNSDictionary:@"content"];
    if ([type isEqualToString:@"command"] ) {//其他指令
        if ([subType isEqualToString:@"leaveRoom"]) {
            NSInteger roomId = [divCont[@"roomId"] longLongValue];
            if (roomId > 0) {
                [[V2TIMManager sharedInstance]quitGroup:[NSString stringWithFormat:@"%ld",(long)roomId] succ:^{
                   // NSLog(@"过滤文字####【TXImKit】####  退出群组成功 roomId == %ld"),(long)roomId);
                } fail:^(int code, NSString *desc) {
                   // NSLog(@"过滤文字####【TXImKit】####  退出群组失败 desc == %@"),desc);
                }];
            }
        }
    }else{
        NSMutableArray* arrName=[self.dictNameRcv objectForKey:type];
        if(arrName!=nil)
        {
            for(int i=0;i<[arrName count];i++)
            {
                id<IMReceiver> rcv=  [arrName objectAtIndex:i];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [rcv onMsg:subType content:divCont];
                });
            }
        }
    }
}


 
 
-(void)addReceiver:(NSString*)groupID  receiver:(id<IMReceiver>)receiver{
    if(receiver ==nil)
    {
        return;
    }
    if(groupID!=nil && groupID.length>0)
    {
        NSMutableArray* arrGroup=[self.dictGroupRcv objectForKey:groupID];
        if(arrGroup==nil)
        {
            arrGroup=[ [NSMutableArray alloc] init];
            [self.dictGroupRcv setObject:arrGroup forKey:groupID];
        }
        [arrGroup addObject:receiver];
        //////////
        NSString * rcvName=[receiver getMsgType];
        NSMutableArray* arrName=[self.dictNameRcv objectForKey:rcvName];
        if(arrName==nil)
        {
            arrName=[ [NSMutableArray alloc] init];
            [self.dictNameRcv setObject:arrName forKey:rcvName];
        }
        [arrName addObject:receiver];
        
    }
    
    
}

///删除本组所有的消息监听，注：会删除本组所有IMReceiver 及其它组与本组IMReceiver的MsgType相同的监听。
-(void)removeReceiverByGroupID:(NSString*)groupID{
    if(groupID!=nil && groupID.length>0)
    {
        NSMutableArray* arrGroup=[self.dictGroupRcv objectForKey:groupID];
        if(arrGroup!=nil)
        {
            for(int i=0;i<[arrGroup count];i++)
            {
                id<IMReceiver> receiver =  [arrGroup objectAtIndex:i];
                NSString *msgType= [receiver getMsgType];
                
                NSMutableArray* arrName= [self.dictNameRcv objectForKey:msgType];
                if(arrName!=nil)
                {
                    [arrName removeObject:receiver];
                }
            }
            [self.dictGroupRcv removeObjectForKey:groupID];
        }
        
        
    }
}
-(void)removeAllReceiver{
    self.dictNameRcv =[NSMutableDictionary new];
    self.dictGroupRcv =[NSMutableDictionary new];
}


@end
