//
//  GoodNumItemCell.h
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodNumItemCell : UICollectionViewCell

@property (nonatomic, weak)UIView *centerView;

@property (nonatomic, weak)UILabel *titleL;  ///标题

@property (nonatomic, weak)UILabel *contentL;  ///内容


@end

NS_ASSUME_NONNULL_END
