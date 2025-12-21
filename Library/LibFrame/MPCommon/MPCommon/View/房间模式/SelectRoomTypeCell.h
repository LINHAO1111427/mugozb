//
//  SelectRoomTypeCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RoomTypeModel;

@interface SelectRoomTypeCell : UITableViewCell

///占位视图
@property (nonatomic, weak) UIView *bgView;

@property (weak, nonatomic) UILabel *titleL;

@property (weak, nonatomic) UIButton *selectBtn;

@property (weak, nonatomic) UITextField *textFV;

@property (weak, nonatomic) UILabel *unitL;  ///单位名称

///选择某一项
@property (nonatomic, copy)void (^selectItem)(void);

@property (nonatomic, copy)void (^selectItemValueDidChange)(NSString *value);

- (void)selectItems:(BOOL)selected;



@end

NS_ASSUME_NONNULL_END
