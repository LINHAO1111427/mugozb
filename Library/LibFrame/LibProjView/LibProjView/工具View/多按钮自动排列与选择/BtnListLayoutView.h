//
//  BtnsLayoutView.h
//  LibProjView
//
//  Created by klc on 2020/6/15.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BtnListLayoutView;
@protocol BtnListLayoutViewDelegate<NSObject>

@required
- (UIButton *)listLayoutView:(BtnListLayoutView *)listView btnForItemAtIndex:(NSInteger)index;

@optional
- (void)list:(BtnListLayoutView *)listView selecteIndex:(NSUInteger)index isSlected:(BOOL)isSelected;

@end

typedef void(^_Nullable ReturnBtnArrBlock)(NSArray<NSNumber *> *_Nullable itemArr);

@interface BtnListLayoutView : UIView

///显示item前设置，否则使用默认值
@property (nonatomic, assign)CGFloat itemHeight;  ///每一项的高度
@property (nonatomic, assign)CGFloat marginWidth; ///item左右间距
@property (nonatomic, assign)CGFloat marginHeight; ///item上下间距
@property (nonatomic, assign)NSUInteger maxSelectedNum;//最多选多少个


@property(nonatomic, weak) id <BtnListLayoutViewDelegate> delegate;




/// 初始化
/// @param frame frame
/// @param delegate 代理
- (instancetype)initWithFrame:(CGRect)frame delegate:(id <BtnListLayoutViewDelegate>)delegate;



/// 显示选项
/// @param titleArr 文字数据
/// @param selectIndexArr 默认选择的数据 (根据maxSelectedNum留最大值)
/// @param returnBack 回调
- (void)showTagsWithTitles:(NSArray<NSString *> *)titleArr selectIndexArr:(NSArray<NSNumber *> *)selectIndexArr callBack:(ReturnBtnArrBlock)returnBack;



///// 设置字符串数组
///// 返回值是viewHeight 视图的高度
//- (CGFloat)setTagViewWithTitles:(NSArray *)titleArr callBack:(ReturnBtnArrBlock)returnBack;
//

@end
 
NS_ASSUME_NONNULL_END
