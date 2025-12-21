//
//  SetGoodsShowView.h
//  Shopping
//
//  Created by klc_sl on 2020/7/3.
//  Copyright © 2020 klc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetGoodsShowView : UIView


- (instancetype)initWithFrame:(CGRect)frame isAdd:(BOOL)isAdd;

//属性id
@property (nonatomic, assign)int64_t attrValueId;
//属性名称
@property (nonatomic, copy)NSString *attrStr;

@property (nonatomic, copy)void(^delBtnClick)(void);

@property (nonatomic, copy)void(^addBtnClick)(void);

@property (nonatomic, copy)void(^textFShouldBeginEditing)(SetGoodsShowView *subView);


@end

NS_ASSUME_NONNULL_END
