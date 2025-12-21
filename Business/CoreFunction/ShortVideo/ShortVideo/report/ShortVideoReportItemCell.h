//
//  ShortVideoReportItemCell.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const ShortVideoReportItemCellIdentifier;
@interface ShortVideoReportItemCell : UITableViewCell

@property(nonatomic,weak )UILabel *leftLabel;
@property (nonatomic,weak ,readonly)UIImageView *rightImage;

@property (nonatomic, assign)BOOL selectItem; ///是否选择了当前cell


@end
