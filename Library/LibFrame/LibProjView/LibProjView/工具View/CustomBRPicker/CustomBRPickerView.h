//
//  CustomBRPickerView.h
//  LibProjView
//
//  Created by klc_sl on 2021/3/26.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BRPickerView.h"

@class BRStringPickerView;

NS_ASSUME_NONNULL_BEGIN

@protocol CustomPickerProtocol <NSObject>

- (void)showInSuperView:(UIView *)superView;

- (void)sureBtnClick;

@end



@interface CustomBRPickerView : UIView


@property (nonatomic, copy)NSString *showTitle;

- (void)dismiss;

///显示自定义的PickerView
- (void)showCustomView:(UIView<CustomPickerProtocol> *)view;


@end



@interface CustomStringPickerView : CustomBRPickerView

/** 完成结果的回调【单列】 */
@property (nullable, nonatomic, copy) void(^doneBlock)(BRResultModel *resultModel);
/** 选择结果的回调【单列】 */
@property (nullable, nonatomic, copy) void(^changeBlock)(BRResultModel *resultModel);
///字符串单选
- (void)showStringPicker:(NSNumber *)selectedIndex stringArr:(NSArray<NSString *> *)stringArr;




/** 完成结果的回调【多列】 */
@property (nullable, nonatomic, copy) void(^multiDoneBlock)(NSArray<BRResultModel *> *resultModelArr);
/** 选择结果的回调【多列】 */
@property (nullable, nonatomic, copy) void(^multiChangeBlock)(NSArray<BRResultModel *> *resultModelArr);
///字符串多列选择
- (void)showMultiStringPicker:(NSArray<NSNumber*> *)selectedIndex stringArr:(NSArray<NSArray<NSString *> *> *)stringListArr;


///多级联动选择
- (void)showLinkageStringPicker:(NSArray<NSNumber *> *)selectedIndex numberOfComponents:(int)num stringArr:(NSArray<BRResultModel *> *)stringListArr;


@end





@interface CustomDataPickerView : CustomBRPickerView

/** 选择结果的回调【单列】 */
@property (nullable, nonatomic, copy) void(^doneBlock)(NSDate *selectDate);

///日期选择器
- (void)showDatePicker:(NSString *)showDate limit:(int)limit dateFormatter:(NSString *)dateFormatter;


@end





NS_ASSUME_NONNULL_END
