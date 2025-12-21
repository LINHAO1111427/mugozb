//
//  MineFansGroupItemCell.m
//  MessageInfo
//
//  Created by shirley on 2022/2/10.
//

#import "MineFansGroupItemCell.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibTools/LibTools.h>
#import <LibProjView/PopView.h>

@interface MineFansGroupItemCell()

@property(nonatomic,strong)UIImageView *fansGroupIconV;
@property(nonatomic,strong)UILabel *userNameL;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)UILabel *signatureL;

@end
@implementation MineFansGroupItemCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
     
}
- (void)creatUI{
    
    self.fansGroupIconV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 50, 50)];
    self.fansGroupIconV.contentMode = UIViewContentModeScaleAspectFill;
    self.fansGroupIconV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.fansGroupIconV];


    //昵称
    self.userNameL = [[UILabel alloc]initWithFrame:CGRectMake(self.fansGroupIconV.maxX+10, self.fansGroupIconV.y, kScreenWidth-self.fansGroupIconV.maxX-12, self.fansGroupIconV.height)];
    self.userNameL.textAlignment = NSTextAlignmentLeft;
    self.userNameL.textColor =kRGB_COLOR(@"#333333");
    self.userNameL.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.userNameL];
    
    
    self.fansGroupIconV.image = [ProjConfig getAppIcon];
    self.userNameL.text = kLocalizationMsg(@"粉丝团名称123");
    
}

- (void)setNoMoreBtn:(BOOL)noMoreBtn{
    self.moreBtn.hidden = noMoreBtn;
}


@end
