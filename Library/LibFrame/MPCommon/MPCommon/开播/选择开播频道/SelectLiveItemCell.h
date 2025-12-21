//
//  SelectLiveItemCell.h
//  LiveCommon
//
//  Created by klc_sl on 2020/3/18.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectLiveItemCell : UICollectionViewCell

@property (nonatomic, weak)UILabel *titleL;

- (void)selectItem:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
