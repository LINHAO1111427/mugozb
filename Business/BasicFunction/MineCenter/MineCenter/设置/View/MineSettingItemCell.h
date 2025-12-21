//
//  MineSettingItemCell.h
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MineSettingItemCell;

@protocol MineSettingItemCellDelegate <NSObject>
@optional

- (void)MineSettingItemCell:(MineSettingItemCell *)cell switchBarStatus:(BOOL)isOpen;

@end

@interface MineSettingItemCell : UITableViewCell

///switch开关
@property (nonatomic, assign)BOOL swithStatus;
@property (nonatomic, assign)int funcTag;

@property (nonatomic, weak)id<MineSettingItemCellDelegate> delegate;


/// 设置显示的样式和显示的文字
/// @param type //0退出 1更多 2 开关 3更多带值
/// @param titleStr 文字标题
/// @param contentStr 相应内容
- (void)showInfoType:(int)type titleStr:(NSString *)titleStr contentStr:(NSString *)contentStr;

@end

NS_ASSUME_NONNULL_END
