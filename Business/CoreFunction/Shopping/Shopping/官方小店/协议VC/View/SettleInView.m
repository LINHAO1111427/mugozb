//
//  SettleInView.m
//  Shopping
//
//  Created by kalacheng on 2020/6/23.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SettleInView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface SettleInView ()
@property(nonatomic,strong)UIScrollView *scrol;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UILabel *contentL;
@end
@implementation SettleInView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatSubView];
  
    }
    return self;
}

-(void)creatSubView{
    [self addSubview:self.scrol];
    [self.scrol addSubview:self.iconImage];
    [self.scrol addSubview:self.titleL];
    [self.scrol addSubview:self.contentL];
}



-(UIScrollView *)scrol{
    if (!_scrol) {
        _scrol = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrol.contentSize = self.frame.size;
    }
    return _scrol;
}


-(UIImageView *)iconImage{
    
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2, 20, 200, 140)];
        _iconImage.image = [UIImage imageNamed:@"shop_guanfangxiaodian"];
    }
    
    return _iconImage;
}

-(UILabel *)titleL{
    
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, 0)];
        _titleL.font = [UIFont systemFontOfSize:16];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = kRGB_COLOR(@"#444444");
//        _titleL.text = kLocalizationMsg(@"官方小店入驻协议");
    }
    
    return _titleL;
}


-(UILabel *)contentL{
    
    if (!_contentL) {
        _contentL = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleL.maxY + 0, kScreenWidth-20, self.height  - 180 - 20)];
        _contentL.textColor = kRGB_COLOR(@"#666666");
        _contentL.font = [UIFont systemFontOfSize:14];
        _contentL.numberOfLines = 0;

    }
    return _contentL;
}


-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
//    _titleL.text =_titleStr;
//    NSAttributedString *attStr = [[NSAttributedString alloc] initWithData:[_titleStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    _titleL.attributedText = attStr;
}

-(void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;

    NSAttributedString *attStr = [[NSAttributedString alloc] initWithData:[_contentStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
     
    _contentL.attributedText = attStr;
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_contentStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
     
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
     
    CGSize textSize = [htmlString boundingRectWithSize:(CGSize){kScreenWidth - 20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    _contentL.frame = CGRectMake(10, self.titleL.maxY + 10, kScreenWidth-20, textSize.height);
    
    if (textSize.height <  self.height -  200) {
        _scrol.contentSize = self.frame.size;
    }else{
        _scrol.contentSize = CGSizeMake(kScreenWidth, 200 + textSize.height);
    }
    
    
    
}


-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 2; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 2;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    CGSize size =   [str boundingRectWithSize:CGSizeMake(width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
@end
