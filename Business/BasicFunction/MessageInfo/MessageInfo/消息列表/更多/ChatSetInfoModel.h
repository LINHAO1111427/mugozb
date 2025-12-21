//
//  ChatSetInfoModel.h
//  Message
//
//  Created by klc_sl on 2021/3/18.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatSetInfoModel : NSObject

///类型0全部1语音2视频3举报    111粉丝团110消息免打扰
@property(nonatomic,assign)int typeId;

///显示标题
@property(nonatomic,copy)NSString *title;

///显示样式 0-更多  1-switch
@property(nonatomic,assign)int showType;

///是否被拉黑
@property(nonatomic,assign)BOOL isBlack;


@end

NS_ASSUME_NONNULL_END
