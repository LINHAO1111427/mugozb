//
//  MessageTableViewCell.m
//  TCDemo
//
//  Created by CH on 2019/11/14.
//  Copyright © 2019 CH. All rights reserved.
//

#import "MessageTableViewCell.h"
#import <SDWebImage.h>
#import "MessageModel.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibTools/LiveMacros.h>
#import <LibProjView/KlcAvatarView.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/ProjectCache.h>

@interface MessageTableViewCell ()

@property(nonatomic,strong) NSString *messageId;

@property(nonatomic,weak) KlcAvatarView *avaterImageV;
@property(nonatomic,weak) UIImageView *attachImageV;

@property(nonatomic,weak) UIView *contentBgV;
@property(nonatomic,weak) UITextView *contentTextV;
@property(nonatomic,weak) UIImageView *levelBgImgV;

@end

@implementation MessageTableViewCell


- (KlcAvatarView *)avaterImageV{
    if (!_avaterImageV) {
        KlcAvatarView *avaterImageV = [[KlcAvatarView alloc]init];
        avaterImageV.userInteractionEnabled = YES;
        [avaterImageV addTarget:self action:@selector(userAvaterBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:avaterImageV];
        _avaterImageV = avaterImageV;
        [avaterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(36, 36));
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
        }];
    }
    return _avaterImageV;
}
- (UIImageView *)attachImageV{
    if (!_attachImageV) {
        UIImageView *attachImageV = [[UIImageView alloc]init];
        attachImageV.contentMode = UIViewContentModeScaleAspectFill;
        [self.avaterImageV addSubview:attachImageV];
        _attachImageV = attachImageV;
        [attachImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.equalTo(self.contentView).offset(26);
            make.bottom.equalTo(self.avaterImageV).offset(0);
        }];
    }
    return _attachImageV;
}

- (UIView *)contentBgV{
    if (!_contentBgV) {
        UIView *bgV = [[UIView alloc] init];
//        bgV.userInteractionEnabled = NO;
        [self.contentView addSubview:bgV];
        _contentBgV = bgV;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageInfoClick)];
        [bgV addGestureRecognizer:tap];
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(5);
        }];
    }
    return _contentBgV;
}

- (UITextView *)contentTextV{
    if (!_contentTextV) {
        UITextView *contentTextV = [[UITextView alloc] init];
        contentTextV.scrollEnabled = NO;
        contentTextV.userInteractionEnabled = NO;
        contentTextV.editable = NO;
        contentTextV.bounces = NO;
        contentTextV.allowsEditingTextAttributes = NO;
        contentTextV.font = [UIFont systemFontOfSize:12];
        contentTextV.selectable = NO;
        contentTextV.backgroundColor = [UIColor clearColor];
        contentTextV.layoutManager.allowsNonContiguousLayout = NO;
        contentTextV.textContainerInset = UIEdgeInsetsMake(5, 3, 5, 3);
        [self.contentBgV addSubview:contentTextV];
        _contentTextV = contentTextV;
        [contentTextV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentBgV).offset(5);
            make.bottom.equalTo(self.contentBgV).offset(-5);
            make.left.equalTo(self.contentBgV).offset(5);
            make.right.equalTo(self.contentBgV).offset(-5);
            make.height.greaterThanOrEqualTo(@36);
        }];
    }
    return _contentTextV;
}

- (UIImageView *)levelBgImgV{
    if (!_levelBgImgV) {
        UIImageView *imgV = [[UIImageView alloc] init];
        [self.contentBgV addSubview:imgV];
        _levelBgImgV = imgV;
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentBgV);
        }];
    }
    return _levelBgImgV;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(MessageModel *)model{
    _model = model;
    /// 内容赋值
    [self parserModel:model];
}


///用户头像点一点
- (void)userAvaterBtnClick{
    self.delegate?[self.delegate userAvaterClickAtMessageTableViewCell:self]:nil;
}

- (void)messageInfoClick{
    self.delegate?[self.delegate messageInfoClickAtMessageTableViewCell:self]:nil;
}


#pragma mark 解析model
- (void)parserModel:(MessageModel *)model{
    self.messageId = model.msgId;
    self.backgroundColor = [UIColor clearColor];
    self.levelBgImgV.image = [UIImage imageNamed:model.msgBgImageStr];
    
    self.attachImageV.hidden = YES;
    self.avaterImageV.hidden = YES;
    
    BOOL haveAvater = NO;
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:@""];
    if (model.type != 13 && model.type != 14 && model.type != 12 && model.type != 99) {
        haveAvater = YES;
        self.avaterImageV.hidden = NO;
        [self.avaterImageV showUserIconUrl:model.avatar vipBorderUrl:model.nobleBorder];
        
        if (model.identityType == 3) {//贵族#FFC119
        }else if(model.identityType == 2){//守护
        }else if (model.identityType == 1){//粉丝团
            self.attachImageV.image = [UIImage imageNamed:@"live_fensituan_white"];
            self.attachImageV.hidden = NO;
        }
    }
    
    for (MessageItemModel *itemModel in model.content) {
        [attrM appendAttributedString:[self parserContextItem:itemModel]];
    }

    ///设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//以字母打断
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:12],
        NSParagraphStyleAttributeName:paragraphStyle
    };
    [attrM addAttributes:attributes range:NSMakeRange(0, attrM.length)];
    
    if (haveAvater) {
        [self.contentBgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(47);
        }];
    }else{
        [self.contentBgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(5);
        }];
    }
    
    self.contentTextV.attributedText = attrM;
    
}



#pragma mark 解析color
- (UIColor *)parserColorWithString:(NSString *)text{
    // 是否是RGBA
    // 是否是#RGBA
    // 是否是RGB
    // 是否是#RGBA
    
    NSString *red;
    NSString *green;
    NSString *blue;
    NSString *alpha;
    
    if ([[text substringToIndex:1] isEqualToString:@"#"]) { // #RGB(A)
        if (text.length == 7) {  // RGB
            red = [text substringWithRange:NSMakeRange(1, 2)];
            green = [text substringWithRange:NSMakeRange(3, 2)];
            blue = [text substringWithRange:NSMakeRange(5, 2)];
            alpha = @"ff";
        }
        else if (text.length == 9){ // RGBA
            red = [text substringWithRange:NSMakeRange(1, 2)];
            green = [text substringWithRange:NSMakeRange(3, 2)];
            blue = [text substringWithRange:NSMakeRange(5, 2)];
            alpha = [text substringWithRange:NSMakeRange(7, 2)];
        }
        else{
            NSAssert(NO, kLocalizationMsg(@"RGB格式不对"));
        }
    }
    else{   // RGB(A)
        if (text.length == 6) {  // RGB
            red = [text substringWithRange:NSMakeRange(0, 2)];
            green = [text substringWithRange:NSMakeRange(2, 2)];
            blue = [text substringWithRange:NSMakeRange(4, 2)];
            alpha = @"ff";
        }
        else if (text.length == 8){ // RGBA
            red = [text substringWithRange:NSMakeRange(0, 2)];
            green = [text substringWithRange:NSMakeRange(2, 2)];
            blue = [text substringWithRange:NSMakeRange(4, 2)];
            alpha = [text substringWithRange:NSMakeRange(6, 2)];
        }
        else{
            NSAssert(NO, kLocalizationMsg(@"RGB格式不对"));
        }
    }
    
    CGFloat redValue = strtoul([red UTF8String], 0, 16) / 255.;
    CGFloat greenValue = strtoul([green UTF8String], 0, 16) / 255.;
    CGFloat blueValue = strtoul([blue UTF8String], 0, 16) / 255.;
    CGFloat alphaValue = strtoul([alpha UTF8String], 0, 16) / 255.;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:alphaValue];
}

//MARK: 解析内容
- (NSMutableAttributedString *)parserContextItem:(MessageItemModel *)itemModel{
    
    NSMutableAttributedString *itemAttrM;
    if (itemModel.type == 0 && itemModel.content.length > 0) { // 文本
        itemAttrM = [[NSMutableAttributedString alloc] initWithString:itemModel.content];
        [itemAttrM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:itemModel.fontSize] range:NSMakeRange(0, itemModel.content.length)];
        ///文字颜色
        if (itemModel.specialColor) {
            NSArray *arr = @[@"#FF3937",@"#FFA837",@"#FFFF37",@"#6BFF37",@"#37FFEB",@"#37A2FF",@"#F837FF"];
            for (int i = 0; i<itemModel.content.length; i++) {
                NSString *colorHex = arr[i%arr.count];
                NSString *subStr = [itemModel.content substringWithRange:NSMakeRange(i, 1)];
                if (![self subStringContainsEmoji:subStr]) {
                    [itemAttrM addAttribute:NSForegroundColorAttributeName value:[self parserColorWithString:colorHex] range:NSMakeRange(i, 1)];
                }
            }
        }else{
            [itemAttrM addAttribute:NSForegroundColorAttributeName value:[self parserColorWithString:itemModel.textColor] range:NSMakeRange(0, itemModel.content.length)];
        }
    }
    else if (itemModel.type == 1){ // 图片
        kWeakSelf(self);
        itemAttrM = [[NSMutableAttributedString alloc] initWithString:itemModel.content];
        __block NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        if (itemModel.imageUrl.length) {
            
            [ProjectCache cacheFileWithFilePath:itemModel.imageUrl finishHandle:^(NSData * _Nullable data, BOOL success) {
                if (success) {
                    UIImage *img = [UIImage imageWithData:data];
                    attach.image = img;
                    NSRange range = [weakself rangeOfAttachment:attach];
                    if (range.location < weakself.contentTextV.attributedText.length) {
                        [weakself.contentTextV.layoutManager invalidateLayoutForCharacterRange:range actualCharacterRange:NULL];
                    }
                }
            }];
            
        }else{
            attach.image = itemModel.iconImage;
        }
        attach.bounds = CGRectMake(itemModel.imageX, itemModel.imageY-2, itemModel.imageWidth, itemModel.imageHeight);
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        
        //将图片插入到合适的位置
        [itemAttrM insertAttributedString:attachString atIndex:0];
    }
    else if (itemModel.type == 2){ //骰子图片（本地图片）
        itemAttrM = [[NSMutableAttributedString alloc] initWithString:itemModel.content];
        __block NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = itemModel.iconImage;
        attach.bounds = CGRectMake(itemModel.imageX, itemModel.imageY, itemModel.imageWidth, itemModel.imageHeight);
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        //将图片插入到合适的位置
        [itemAttrM insertAttributedString:attachString atIndex:0];
    }
    else{
        NSAssert(NO, kLocalizationMsg(@"新增了文本元素，非文本图片"));
    }
    
    return itemAttrM;
}

- (NSRange)rangeOfAttachment:(NSTextAttachment *)attachment {
    __block NSRange ret;
    [self.contentTextV.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                 inRange:NSMakeRange(0, self.contentTextV.attributedText.length)
                                                 options:0
                                              usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (attachment == value) {
            ret = range;
            *stop = YES;
        }
    }];
    return ret;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


//判断是否存在emoji (整个字符串判断)
-(BOOL)stringContainsEmoji:(NSString *)string
{
    NSUInteger stringUtf8Length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if(stringUtf8Length >= 4 && (stringUtf8Length / string.length != 3))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

///判断单个字符是否是emoji
-(BOOL)subStringContainsEmoji:(NSString *)string
{
    NSUInteger stringUtf8Length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if(stringUtf8Length == 0 && string.length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
