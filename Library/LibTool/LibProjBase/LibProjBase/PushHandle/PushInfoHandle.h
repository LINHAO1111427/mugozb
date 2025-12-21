//
//  PushInfoHandle.h
//  PushKit
//
//  Created by klc_sl on 2021/11/12.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushInfoHandle : NSObject

///数据<pushID, date>
@property (nonatomic, strong)NSMutableDictionary *param;

///防止推送重复使用

///保存推送ID
- (void)savePushId:(NSString *)pushId;

///推送ID是否存在
- (BOOL)existsPushId:(NSString *)pushId;




@end

NS_ASSUME_NONNULL_END
