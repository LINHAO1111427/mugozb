//
//  EmojiKeyboardView.h
//  TaiWanEight
//
//  Created by Boom on 2017/11/23.
//  Copyright © 2017年 YangBiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LibTools/LibTools.h>

#define EmojiHeight 210

typedef NS_ENUM(NSUInteger, EmojiKeyboardForKeyType) {
    EmojiKeyboardForSend,
    EmojiKeyboardForStr,
    EmojiKeyboardForDelete,
};


@interface EmojiKeyboardView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic, weak)UIButton *sendEmojiBtn;

@property (nonatomic, copy)void(^clickHandle)(EmojiKeyboardForKeyType type, NSString *emoji);

@end
