//
//  userFaceView.h
//  ShortVideo
//
//  Created by ssssssss on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiShortVideoDtoModel;

@interface SVUserFaceView : UIView
 
@property (nonatomic, copy)void(^otoCallClick)(void);

@property (nonatomic, copy)void(^userAvaterClick)(int64_t userId);

@property (nonatomic, copy)void(^adItemClick)(NSString *url);

@property (nonatomic, copy)void(^removeBtnClick)(void);

- (void)layerLevel:(int)level withModel:(ApiShortVideoDtoModel *)model indexP:(NSIndexPath *)indexPath dataType:(int)dataType;

@end

NS_ASSUME_NONNULL_END
