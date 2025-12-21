//
//  MessageModel.h
//  TCDemo
//
//  Created by CH on 2019/11/13.
//  Copyright © 2019 CH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MessageItemModel : NSObject

/// 类型  0 - 文字， 1 - 图片   2 - 骰子
@property (nonatomic, assign) NSInteger type;


/// 图片url
@property(nonatomic,strong) NSString *imageUrl;

/// 图片数据
@property(nonatomic,strong) UIImage *iconImage;


/// 图片X
@property (nonatomic, assign) CGFloat imageX;

/// 图片Y
@property (nonatomic, assign) CGFloat imageY;

/// 图片长度
@property (nonatomic, assign) CGFloat imageWidth;

/// 图片宽度
@property (nonatomic, assign) CGFloat imageHeight;



///特别文字颜色
@property(nonatomic ,assign)BOOL specialColor;

/// 文本内容
@property(nonatomic,strong) NSString *content;

/// 字体大小
@property (nonatomic, assign) CGFloat fontSize;

/// 文本颜色
@property(nonatomic,strong) NSString *textColor;

/// 点击对应的用户id
@property(nonatomic,strong) NSString *clickId;


@end




@class ApiSimpleMsgRoomModel;

@interface MessageModel : NSObject


/// 消息id
@property(nonatomic,copy) NSString *msgId;

/// 昵称
@property(nonatomic,copy) NSString *uname;
///用户头像
@property(nonatomic,copy) NSString *avatar;
///主播头像
@property(nonatomic,copy) NSString *anchorAvatar;

//主播or普通用户
@property (nonatomic, assign) int role;

/// 消息框的背景图片
@property(nonatomic,copy) NSString *msgBgImageStr;

///身份 0普通 1粉丝团 2守护 3贵族
@property (nonatomic, assign) NSInteger identityType;

///贵族等级
@property (nonatomic, assign) NSInteger nobleGrade;

///贵族相框
@property (nonatomic, copy) NSString *nobleBorder;


///消息类型1进场消息2退场消息3礼物消息4点亮5红包6禁言解禁消息7设置取消管理员8踢人消息9购买守护10关注和取消关注11文字聊天消息12主播离开回来消息13系统消息14弹幕消息15骰子
@property (nonatomic, assign) NSInteger type;


@property(nonatomic,strong) NSMutableArray<MessageItemModel *> *content;

/// 点击跳转用户的页面，暂时放在整个cell
@property(nonatomic,assign) int64_t userId;

///原消息
@property (nonatomic, strong)ApiSimpleMsgRoomModel *msgModel;


+ (MessageModel * __nullable)convertWithApiSimpleMsgRoomModel:(ApiSimpleMsgRoomModel *)msgModel;

@end

NS_ASSUME_NONNULL_END
