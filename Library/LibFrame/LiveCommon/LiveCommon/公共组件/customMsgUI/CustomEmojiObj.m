//
//  CustomEmojiObj.m
//  LiveCommon
//
//  Created by klc_sl on 2020/12/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CustomEmojiObj.h"
#import <LibTools/LibTools.h>

@implementation CustomEmojiObj

///num 只能是一位数
+ (UIImage *)getMicOrderView:(NSString *)numberStr{
    if ([numberStr validPureInt] && numberStr.length == 1) {
        
        UIImageView *imgBgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_emoji_bg"]];
        imgBgV.frame = CGRectMake(0, 0, 120, 120);
        
        UIImageView *numImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"img_emoji_num_%@",numberStr]]];
        numImgV.contentMode = UIViewContentModeScaleAspectFit;
        numImgV.frame = CGRectMake(0, 40, 36, 36);
        numImgV.centerX = imgBgV.width/2.0;
        [imgBgV addSubview:numImgV];
        
        UIImage *numImg = [UIImage imageConvertFromView:imgBgV];
        ///图片
        return numImg;
        
    }else{
        return nil;
    }
}

///num 只能是三位数
+ (UIImage *)getSlotMachineView:(NSString *)numberStr{
    if ([numberStr validPureInt] && numberStr.length == 3) {
        
        UIImageView *imgBgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_emoji_bg"]];
        imgBgV.frame = CGRectMake(0, 0, 120, 120);
        
        CGFloat numH = 25;
        NSMutableArray *itemNumImgVArr = [[NSMutableArray alloc] init];
        for (int i = 0; i<numberStr.length; i++) {
            NSString *oneStr = [numberStr substringWithRange:NSMakeRange(i, 1)];
            UIImageView *numImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"img_emoji_num_%@",oneStr]]];
            numImgV.contentMode = UIViewContentModeScaleAspectFit;
            numImgV.frame = CGRectMake(0, 42, 25, numH);
            [itemNumImgVArr addObject:numImgV];
        }

        UIStackView *stackV = [[UIStackView alloc] initWithArrangedSubviews:itemNumImgVArr];
        stackV.frame = CGRectMake(0, 46, 75, numH);
        stackV.centerX = imgBgV.width/2.0;
        stackV.axis = UILayoutConstraintAxisHorizontal;
        stackV.alignment = UIStackViewAlignmentCenter;
        stackV.distribution = UIStackViewDistributionFillEqually;
        stackV.spacing = 5;
        [imgBgV addSubview:stackV];
        
        UIImage *numImg = [UIImage imageConvertFromView:imgBgV];
        ///图片
        return numImg;
        
    }else{
        return nil;
    }
}


@end
