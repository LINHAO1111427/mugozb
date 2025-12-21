//
//  MessageModel.m
//  TCDemo
//
//  Created by CH on 2019/11/13.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MessageModel.h"
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibTools/LibTools.h>
#import "CustomEmojiObj.h"

@implementation MessageItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = 0;
        self.content = @"";
        self.fontSize = 12;
        self.textColor = @"#ff0000";
        self.clickId = @"";
        
        self.imageWidth = 20;
        self.imageHeight = 12;
        
    }
    return self;
}

@end

@implementation MessageModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (MessageModel *)convertWithApiSimpleMsgRoomModel:(ApiSimpleMsgRoomModel *)model {
    if ([model.content stringByTrimmingWhitespace].length == 0) {
        return nil;
    }
    
    MessageModel *newModel = [[MessageModel alloc] init];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"yyyyMMddHHmmssff"];
    newModel.uname = model.userName;
    newModel.msgId = [dateFormate stringFromDate:date];
    newModel.content = [NSMutableArray array];
    newModel.type = model.type;
    newModel.avatar = model.avatar;
    newModel.role = model.role;
    newModel.anchorAvatar = model.anchorAvatar;
    newModel.userId = model.userId;
    newModel.nobleGrade = model.nobleGrade;
    newModel.nobleBorder = model.nobleAvatarFrame;
    newModel.msgModel = model;
    
    NSString *msgBgImage = @"live_msg_normalBg";
    switch (model.nobleGrade) {
        case 1:  msgBgImage = @"live_msg_bg1"; break;
        case 2:  msgBgImage = @"live_msg_bg2"; break;
        case 3:  msgBgImage = @"live_msg_bg3"; break;
        case 4:  msgBgImage = @"live_msg_bg4"; break;
        case 5:  msgBgImage = @"live_msg_bg5"; break;
        default:
        {
            if (model.guardType > 0) {
                msgBgImage = @"live_msg_guardBg";
            }
        }
            break;
    }
    newModel.msgBgImageStr = msgBgImage;
    
    
    switch (model.type) {
             
        case 1:{// 进场消息
            
        }
            break;
            //             case 2://退场消息
            //             break;
        case 3:{//礼物消息
            [self addUserInfo:newModel simpleMesModel:model];
            //内容
            MessageItemModel *contentModel1 = [[MessageItemModel alloc] init];
            contentModel1.textColor = @"#ffffff";
            contentModel1.content = [model.content substringToIndex:3];
            contentModel1.type = 0;
            [newModel.content addObject:contentModel1];
            
            MessageItemModel *contentModel2 = [[MessageItemModel alloc] init];
            contentModel2.textColor = @"#FFD176";
            contentModel2.content = model.anchorName;
            contentModel2.type = 0;
            [newModel.content addObject:contentModel2];
            
            MessageItemModel *contentModel3 = [[MessageItemModel alloc] init];
            contentModel3.textColor = @"#ffffff";
            contentModel3.content = [model.content substringFromIndex:3];
            contentModel3.type = 0;
            [newModel.content addObject:contentModel3];
        }
            break;
        case 4://点亮
        {
            [self addUserInfo:newModel simpleMesModel:model];
            //内容
            MessageItemModel *contentModel = [[MessageItemModel alloc] init];
            contentModel.textColor = @"#ffffff";
            contentModel.content = model.content;
            contentModel.type = 0;
            [newModel.content addObject:contentModel];
            
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"plane_heart_cyan.png",@"plane_heart_pink.png",@"plane_heart_red.png",@"plane_heart_yellow.png",@"plane_heart_heart.png", nil];
            
            MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
            imageItemModel.type = 1;
            imageItemModel.imageX = -2;
            imageItemModel.imageY = 0;
            imageItemModel.imageWidth = 13;
            imageItemModel.imageHeight = 13;
            imageItemModel.iconImage = [UIImage imageNamed:array[arc4random_uniform((uint32_t)array.count)]];
            [newModel.content addObject:imageItemModel];
            
        }
            break;
             
        case 11:{//文字聊天消息
            [self addUserInfo:newModel simpleMesModel:model];
            //内容
            MessageItemModel *contentModel = [[MessageItemModel alloc] init];
            contentModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            //           // NSLog(@"过滤文字item color === %d"),model.fontDiscoloration);
            contentModel.textColor = @"#ffffff";
            contentModel.content = model.content;
            contentModel.type = 0;
            [newModel.content addObject:contentModel];
        }
            break;
            
        case 12:{//主播离开/回来
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.type = 0;
            //contentModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            itemModel.textColor = @"#ffff00";
            itemModel.content = model.content;
            [newModel.content addObject:itemModel];
        }
            break;
            
        case 13:{// 系统消息
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            //contentModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            itemModel.textColor = @"#FFD176";
            itemModel.type = 0;
            itemModel.content = model.content;
            [newModel.content addObject:itemModel];
        }
            break;
        case 14://弹幕消息
            break;
        case 15://骰子消息
        {
            
            [self addUserInfo:newModel simpleMesModel:model];
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.type = 0;
            itemModel.content = @"\n";
            [newModel.content addObject:itemModel];
            
            if ([model.content validPureInt] && model.content.length == 1) {
                
                MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
                imageItemModel.type = 2;
                imageItemModel.imageX = 0;
                imageItemModel.imageY = 0;
                imageItemModel.imageWidth = 50;
                imageItemModel.imageHeight = 50;
                imageItemModel.iconImage = [UIImage imageNamed:[NSString stringWithFormat:@"mg_audio_dice_%@",model.content]];
                [newModel.content addObject:imageItemModel];
                
            }
        }
            break;
        case 17://老虎机消息
        {
            [self addUserInfo:newModel simpleMesModel:model];
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.type = 0;
            itemModel.content = @"\n";
            [newModel.content addObject:itemModel];
            if ([model.content validPureInt] && model.content.length == 3) {
                MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
                imageItemModel.type = 2;
                imageItemModel.imageX = 0;
                imageItemModel.imageY = 0;
                imageItemModel.imageWidth = 70;
                imageItemModel.imageHeight = 70;
                imageItemModel.iconImage = [CustomEmojiObj getSlotMachineView:model.content];
                [newModel.content addObject:imageItemModel];
            }
        }
            break;
        case 18://麦序机消息
        {
            [self addUserInfo:newModel simpleMesModel:model];
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.type = 0;
            itemModel.content = @"\n";
            [newModel.content addObject:itemModel];
            if ([model.content validPureInt] && model.content.length == 1) {
                MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
                imageItemModel.type = 2;
                imageItemModel.imageX = 0;
                imageItemModel.imageY = 0;
                imageItemModel.imageWidth = 70;
                imageItemModel.imageHeight = 70;
                imageItemModel.iconImage = [CustomEmojiObj getMicOrderView:model.content];
                [newModel.content addObject:imageItemModel];
            }
        }
            break;
        case 19://求赏
        {
            [self addUserInfo:newModel simpleMesModel:model];
            
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.type = 0;
            itemModel.content = @"\n";
            [newModel.content addObject:itemModel];

            MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
            imageItemModel.type = 1;
            imageItemModel.imageX = 0;
            imageItemModel.imageY = -20;
            imageItemModel.imageWidth = 50;
            imageItemModel.imageHeight = 50;
            imageItemModel.imageUrl = model.giftIcon;
            [newModel.content addObject:imageItemModel];
            
            MessageItemModel *askItemlModel = [[MessageItemModel alloc] init];
            askItemlModel.textColor = @"#ffffff";
//            askItemlModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            askItemlModel.type = 0;
            askItemlModel.content = model.content;
            [newModel.content addObject:askItemlModel];
        }
            break;
        case 99://房间公告
        {
            MessageItemModel *itemModel = [[MessageItemModel alloc] init];
            itemModel.textColor = @"#E9C573";
            //contentModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            itemModel.type = 0;
            itemModel.content = model.content;
            [newModel.content addObject:itemModel];
        }
            break;
            
            
        case 5://红包
        case 6://禁言解禁消息
        case 7://设置取消管理员
        case 8://踢人消息
        case 9://购买守护
        case 10://关注和取消关注
        default:{
            [self addUserInfo:newModel simpleMesModel:model];
            //内容
            MessageItemModel *contentModel = [[MessageItemModel alloc] init];
            //            contentModel.specialColor = model.fontDiscoloration == 1?YES:NO;
            //           // NSLog(@"过滤文字item color === %d"),model.fontDiscoloration);
            contentModel.textColor = @"#ffffff";
            contentModel.content = model.content;
            contentModel.type = 0;
            [newModel.content addObject:contentModel];
        }
            break;
    }
    
    return newModel;
    
}


+ (void)addUserInfo:(MessageModel *)newModel simpleMesModel:(ApiSimpleMsgRoomModel *)model{
    //用户身份
    if (model.nobleGrade > 0) {
        newModel.identityType = 3;
    }else if (model.guardType > 0){
        newModel.identityType = 2;
    }else if (model.isFans){
        newModel.identityType = 1;
    }else{
        newModel.identityType = 0;
    }
    
    BOOL hasBefore = NO;
    //    {
    //        //用户/主播等级
    //        MessageItemModel *grandeModel = [[MessageItemModel alloc] init];
    //        grandeModel.type = 1;
    //        grandeModel.imageX = 0;
    //        grandeModel.imageY = -2;
    //        grandeModel.imageWidth = 30;
    //        grandeModel.imageHeight = 15.0;
    //        NSString *grandeImageStr;
    //        if (model.role == 1) {
    //            grandeImageStr = model.anchorGradeImg;
    //        }else{
    //            grandeImageStr = model.userGradeImg;
    //        }
    //        grandeModel.imageUrl = grandeImageStr;
    //        [newModel.content addObject:grandeModel];
    //
    //        hasBefore = YES;
    //    }
    
    if (model.guardType) {

        if (hasBefore == YES) {
            MessageItemModel *space = [[MessageItemModel alloc] init];
            space.content = @" ";
            [newModel.content addObject:space];
        }
        
        MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
        imageItemModel.type = 1;
        imageItemModel.imageX = 0;
        imageItemModel.imageY = -3;
        imageItemModel.imageWidth = (70*19)/60.0;
        imageItemModel.imageHeight = 19;
        imageItemModel.iconImage = [UIImage imageNamed:@"live_shouhu_medal"];
        [newModel.content addObject:imageItemModel];
        
        hasBefore = YES;
    }
    
    
    //财富等级
    if (model.wealthGradeImg.length > 0) {
        
        if (hasBefore == YES) {
            MessageItemModel *space = [[MessageItemModel alloc] init];
            space.content = @" ";
            [newModel.content addObject:space];
        }
        
        MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
        imageItemModel.type = 1;
        imageItemModel.imageX = 0;
        imageItemModel.imageY = -2;
        imageItemModel.imageWidth = 30;
        imageItemModel.imageHeight = 15.0;
        imageItemModel.imageUrl = model.wealthGradeImg;
        [newModel.content addObject:imageItemModel];
        
        hasBefore = YES;
    }
    
    //贵族等级
    if (model.nobleGradeImg.length > 0) {
        
        if (hasBefore == YES) {
            MessageItemModel *space = [[MessageItemModel alloc] init];
            space.content = @" ";
            [newModel.content addObject:space];
        }
        
        MessageItemModel *imageItemModel = [[MessageItemModel alloc] init];
        imageItemModel.type = 1;
        imageItemModel.imageX = 0;
        imageItemModel.imageY = -2;
        imageItemModel.imageWidth = 30;
        imageItemModel.imageHeight = 15.0;
        imageItemModel.imageUrl = model.nobleGradeImg;
        [newModel.content addObject:imageItemModel];
    }
    
    // 昵称
    MessageItemModel *usernameModel = [[MessageItemModel alloc] init];
    usernameModel.type = 0;
    usernameModel.textColor = @"#FFD176";
    usernameModel.content = [@" " stringByAppendingString:[model.userName stringByAppendingFormat:@"："]];
    [newModel.content addObject:usernameModel];
    
}

@end
