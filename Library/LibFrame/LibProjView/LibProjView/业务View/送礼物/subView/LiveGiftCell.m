//
//  LiveGiftCell.m
//  MPVideoLive
//
//  Created by admin on 2019/8/5.
//  Copyright © 2019 cat. All rights reserved.
//

#import "LiveGiftCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/KLCAppConfig.h>
@implementation LiveGiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)showGift:(NobLiveGiftModel *)giftModel type:(int)type{
   
    [_icon sd_setImageWithURL:[NSURL URLWithString:giftModel.gifticon] placeholderImage:[UIImage imageNamed:@"mr"]];
    _giftName.text = giftModel.giftname;
    _price.attributedText = [[NSString stringWithFormat:@"%.0lf",giftModel.needcoin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1.5, 10, 10) before:NO];
    _packNumL.text = [NSString stringWithFormat:@"%d",giftModel.number];
    _pageNumBgV.hidden = ((type == 4)?NO:YES);
    _hotL.hidden = (giftModel.mark == 1)?NO:YES;
    
    [self setNeedsLayout];
    
}


- (void)selectItem:(BOOL)isSelect{
    _border.hidden = !isSelect;
    _selectImgV.image = [UIImage imageNamed:isSelect?@"gift_pack_select":@"gift_pack_unselect"];
}


@end
