//
//  SpectrumView.h
//  Message
//
//  Created by klc_tqd on 2020/5/19.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpectrumView : UIView

@property (nonatomic, copy) void (^itemLevelCallback)(void);

@property (nonatomic, assign) NSUInteger numberOfItems;

@property (nonatomic,strong) UIColor * itemColor;

@property (nonatomic,assign) CGFloat level;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,assign) CGFloat middleInterval;

@property (nonatomic,assign) BOOL hiddenLabel;

- (void)start;

- (void)stop;


@end

NS_ASSUME_NONNULL_END
