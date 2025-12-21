//
//  LiveGiftCell.h
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NobLiveGiftModel;

@interface LiveGiftCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIImageView *border;

@property (weak, nonatomic) IBOutlet UIView *pageNumBgV;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgV;
@property (weak, nonatomic) IBOutlet UILabel *packNumL;

@property (weak, nonatomic) IBOutlet UILabel *hotL;


- (void)showGift:(NobLiveGiftModel *)giftModel type:(int)type;

- (void)selectItem:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
