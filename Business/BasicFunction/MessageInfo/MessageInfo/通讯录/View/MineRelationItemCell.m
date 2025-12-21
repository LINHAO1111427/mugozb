//
//  MineRelationItemCell.m
//  MessageInfo
//
//  Created by shirley on 2022/2/10.
//

#import "MineRelationItemCell.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibTools/LibTools.h>
#import <LibProjView/PopView.h>
#import <LibProjView/SWHTapImageView.h>

@interface MineRelationItemCell()
@property (nonatomic, assign)NSInteger type;//1:密友 2:备注 3:粉丝 4:我关注的人 5:我的群组
@property(nonatomic,strong)NSIndexPath *indexpath;

@property(nonatomic,strong)KlcAvatarView *headImageV;//头像
@property(nonatomic,strong)UILabel *userNameL;//昵称
@property(nonatomic,strong)UILabel *signatureL;//签名
@property(nonatomic,strong)UIButton *followBtn; //跟随按钮
@property(nonatomic,strong)UIButton *moreBtn;//更多
@property(nonatomic,strong)UIImageView *topImageV;//置顶
@property(nonatomic,strong)SWHTapImageView *roleImageView;//角色

@end
@implementation MineRelationItemCell

- (instancetype)initWithFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath type:(NSInteger)type{
    if (self = [super initWithFrame:frame]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexpath = indexPath;
        self.type = type;
        [self creatUI];
    }
    return self;
}
 

 
- (void)creatUI{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.top.mas_equalTo(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
     
    //头像
    [bgView addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.equalTo(bgView);
        make.height.equalTo(bgView);
        make.width.equalTo(self.headImageV.mas_height);
    }];
    
    //更多
    [bgView addSubview:self.moreBtn];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView).offset(-5);
        make.centerY.equalTo(self.headImageV);
        make.width.height.mas_equalTo(30);
    }];
    
    //置顶
    [bgView addSubview:self.topImageV];
    [self.topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreBtn.mas_left).offset(-2);
        make.centerY.equalTo(self.headImageV);
        make.width.height.mas_equalTo(15);
    }];
    
    //跟随
    [bgView addSubview:self.followBtn];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topImageV.mas_left).offset(-5);
        make.top.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.width.mas_equalTo(60);
    }];
    
    //用户昵称
    [bgView addSubview:self.userNameL];
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageV.mas_right).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreenWidth-220);
        make.height.mas_equalTo(20);
        if (self.type == 5) {
            make.centerY.equalTo(self.headImageV);
        }else{
            make.top.equalTo(bgView);
        }
    }];
    
    //role
    [bgView addSubview:self.roleImageView];
    [self.roleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameL.mas_right);
        make.centerY.equalTo(self.userNameL);
        make.width.height.mas_equalTo(20);
    }];
    
    if (self.type != 5) {
        //用户签名
        [bgView addSubview:self.signatureL];
        [self.signatureL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userNameL);
            make.top.equalTo(self.userNameL.mas_bottom);
            make.width.mas_lessThanOrEqualTo(kScreenWidth-200);
            make.height.mas_equalTo(30);
        }];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:self.model.userSex age:self.model.userAge role:self.model.userRole];
    if (image && self.roleImageView.width > 0) {
        self.roleImageView.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:weakself.model.userRole];
        };
    }
}
- (void)setModel:(AppBookShowInfoVOModel *)model{
    _model = model;
    [self.headImageV showUserIconUrl:model.showIcon vipBorderUrl:@""];
    self.userNameL.text = model.showName;
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:model.userSex age:model.userAge role:model.userRole];
    if (image) {
        self.roleImageView.image = image;
    }else{
        [self.roleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    self.signatureL.text = model.showWord;
    [self.topImageV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(model.isTop?15:0);
    }];
    [self.followBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(model.roomId > 0?60:0);
    }];
    
}
 

- (void)moreBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
    if (self.model.isTop) {
        [itemArr addObject:@{@"title":kLocalizationMsg(@"取消置顶"),@"type":@"2"}];
    }else{
        [itemArr addObject:@{@"title":kLocalizationMsg(@"置顶"),@"type":@"1"}];
    }

    [itemArr addObject:@{@"title":kLocalizationMsg(@"备注"),@"type":@"3"}];
    
    
    CGFloat itemHeight = 36;
    UIView *popListV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, itemArr.count*itemHeight+20)];
    popListV.backgroundColor = [UIColor whiteColor];
    popListV.layer.cornerRadius = 5;
    for (int i = 0; i< itemArr.count; i++) {
        NSDictionary *subDic = itemArr[i];
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 10+i*itemHeight, popListV.width, itemHeight);
        [popListV addSubview:btn];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, btn.width-20, btn.height)];
        titleL.text = subDic[@"title"];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor blackColor];
        [btn addSubview:titleL];
        
        [btn klc_whenTapped:^{
            switch ([subDic[@"type"] intValue]) {
                case 1:
                {
                    if (weakself.callBack) {
                        weakself.callBack(1, YES, weakself.model);
                    }
                }
                    break;
                case 2:
                {
                    if (weakself.callBack) {
                        weakself.callBack(1, NO, weakself.model);
                    }
                }
                    break;
                case 3:
                {
                    if (weakself.callBack) {
                        weakself.callBack(2, YES, weakself.model);
                    }
                }
                    break;
             
                default:
                    break;
            }
            [PopView hidenPopView];
        }];
    }

    
    PopView *popView = [PopView popUpContentView:popListV direct:PopViewDirection_PopUpBottom onView:btn];
    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
}
- (void)joinLiveRoom{
    if (self.callBack) {
        self.callBack(3, YES, self.model);
    }
}
- (void)avaterBtnClick{
    if (self.callBack) {
        self.callBack(0, YES, self.model);
    }
}
#pragma mark - 懒加载
- (KlcAvatarView *)headImageV{
    if (!_headImageV) {
        _headImageV = [[KlcAvatarView alloc]init];
        [_headImageV addTarget:self action:@selector(avaterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headImageV;
}
- (UILabel *)userNameL{
    if (!_userNameL) {
        _userNameL = [[UILabel alloc]init];
        _userNameL.textColor = kRGB_COLOR(@"#333333");
        _userNameL.font = [UIFont boldSystemFontOfSize:14];
        _userNameL.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameL;
}
- (UILabel *)signatureL{
    if (!_signatureL) {
        _signatureL = [UILabel new];
        _signatureL.textColor = [UIColor darkGrayColor];
        _signatureL.font = kFont(12);
        _signatureL.numberOfLines = 0;
        _signatureL.textAlignment = NSTextAlignmentLeft;
    }
    return _signatureL;
}
- (UIButton *)followBtn{
    if (!_followBtn) {
        _followBtn = [UIButton buttonWithType:0];
        [_followBtn setBackgroundImage:[UIImage imageNamed:@"live_person_follow"] forState:UIControlStateNormal];
        [_followBtn addTarget:self action:@selector(joinLiveRoom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followBtn;
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:0];
        [_moreBtn setImage:[UIImage imageNamed:@"message_liaotian_gengduo"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
- (UIImageView *)topImageV{
    if (!_topImageV) {
        _topImageV = [UIImageView new];
        _topImageV.image = [UIImage imageNamed:@"icon_relation_top"];
    }
    return _topImageV;
}
- (SWHTapImageView *)roleImageView{
    if (!_roleImageView) {
        _roleImageView = [[SWHTapImageView alloc]init];
    }
    return _roleImageView;
}
 
@end
