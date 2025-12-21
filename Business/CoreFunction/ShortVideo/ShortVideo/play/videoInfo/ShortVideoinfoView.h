//
//  ShortVideoinfoView.h
//  ShortVideo
//
//  Created by ssssssss on 2020/6/20.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ApiShortVideoDtoModel;



@interface ShortVideoinfoView : UIView

@property (nonatomic, copy)void(^userAvaterClick)(void);

@property (nonatomic, copy)void(^userTagClick)(NSInteger tagid, NSString *tagName);

@property (nonatomic, copy)void(^goodsClick)(void);

@property (nonatomic, copy)void(^adsClick)(void);


- (void)layerLevel:(int)level withModel:(ApiShortVideoDtoModel *)model indexP:(NSIndexPath *)indexPath dataType:(int)dataType;

@end

NS_ASSUME_NONNULL_END
