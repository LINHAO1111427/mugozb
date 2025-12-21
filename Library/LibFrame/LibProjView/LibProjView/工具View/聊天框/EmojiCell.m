//
//  EmojiCell.m
//  TaiWanEight
//
//  Created by Boom on 2017/11/25.
//  Copyright © 2017年 YangBiao. All rights reserved.
//

#import "EmojiCell.h"
#import <Masonry/Masonry.h>
NSString *const emojiCellIdentifier = @"emojiCellIdentifier";

@implementation EmojiCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UIImageView *)emojiImgView{
    if (_emojiImgView == nil) {
        UIImageView *emojiV = [[UIImageView alloc] init];
        [self.contentView addSubview:emojiV];
        emojiV.contentMode = UIViewContentModeScaleAspectFit;
        _emojiImgView = emojiV;
        [emojiV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).mas_offset(10);
            make.bottom.right.equalTo(self).mas_offset(-10);
        }];
    }
    return _emojiImgView;
}

@end
