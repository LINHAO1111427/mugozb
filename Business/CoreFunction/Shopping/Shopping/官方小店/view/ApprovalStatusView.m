//
//  ApprovalStatusView.m
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ApprovalStatusView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface ApprovalStatusView ()
@property(nonatomic,strong)UIScrollView *scrol;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)UILabel *contentL;
@end
@implementation ApprovalStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  kRGB_COLOR(@"#FFEBE0");
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    [self addSubview:self.scrol];
    [self.scrol addSubview:self.iconImage];
    [self.scrol addSubview:self.contentL];  
}


-(UIScrollView *)scrol{
    if (!_scrol) {
        _scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        _scrol.contentSize = self.frame.size;
    }
    return _scrol;
}

-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 14, 14)];
        _iconImage.image = nil;
    }
    return _iconImage;
}
-(UILabel *)contentL{
    if (!_contentL) {
        _contentL = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, kScreenWidth - 35, 30)];
        _contentL.textColor = kRGB_COLOR(@"#FF5500");
        _contentL.font = [UIFont systemFontOfSize:13];
        _contentL.text = @"";
    }
    
    return _contentL;
}


////// status 0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.被冻结
- (void)showContentStr:(NSString *)contentStr status:(int)status{
    NSString *stateStr = @"";
    switch (status) {
        case 1:
            _iconImage.image = [UIImage imageNamed:@"shop_shenhezhong"];
            stateStr = @"";
            break;
        case 3:
            _iconImage.image = [UIImage imageNamed:@"shop_weitongguo"];
            stateStr = @"";
            break;
        case 4:
            _iconImage.image = [UIImage imageNamed:@"shop_weitongguo"];
            stateStr = @"";
            break;
        default:
            break;
    }
    
    NSString *showStr = kStringFormat(@"%@%@",stateStr,contentStr);
    CGFloat contentLW = [showStr widthWithFont:[UIFont systemFontOfSize:13] constrainedToHeight:30];
    self.contentL.text = showStr;
    if (contentLW > kScreenWidth - 35) {
        self.contentL.frame = CGRectMake(35, 0, contentLW, 30);
        self.scrol.contentSize = CGSizeMake(contentLW + 35 + 12, 30);
    }
}

@end
