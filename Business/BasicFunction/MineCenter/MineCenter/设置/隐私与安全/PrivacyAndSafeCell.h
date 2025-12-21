//
//  PrivacyAndSafeCell.h
//  MineCenter
//
//  Created by klc_sl on 2021/9/3.
//  Copyright © 2021 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrivacyAndSafeCell;

NS_ASSUME_NONNULL_BEGIN

@protocol PrivacyAndSafeCellDelegate <NSObject>
@optional

- (void)privacyAndSafeCell:(PrivacyAndSafeCell *)cell switchBarStatus:(BOOL)isOpen;

@end

@interface PrivacyAndSafeCell : UITableViewCell

@property (nonatomic, weak)id<PrivacyAndSafeCellDelegate> delegate;
@property (nonatomic, weak)UILabel *titleL;
@property (nonatomic, weak)UILabel *contentL;
@property (nonatomic, weak)UISwitch *switchBtn;

@property (nonatomic, copy)NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
