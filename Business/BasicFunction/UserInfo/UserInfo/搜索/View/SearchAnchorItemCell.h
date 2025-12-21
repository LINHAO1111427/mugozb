//
//  SearchAnchorItemCell.h
//  klc
//
//  Created by David on 16/5/21.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibProjView/SWHTapImageView.h>
@class LiveBeanModel;

FOUNDATION_EXPORT NSString *const SearchAnchorItemCellIdentifier;
@interface SearchAnchorItemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexLwidthConstraint;

@property (weak, nonatomic) IBOutlet SWHTapImageView *sexL;
@property (weak, nonatomic) IBOutlet UIView *levelBgV;

@property (weak, nonatomic) IBOutlet UILabel *signatureL;

@property (weak, nonatomic) IBOutlet UIImageView *liveImgV;



@property (nonatomic, copy)LiveBeanModel *model;

@property (nonatomic, copy)void(^followBtnBlock)(SearchAnchorItemCell *cell);


@end
