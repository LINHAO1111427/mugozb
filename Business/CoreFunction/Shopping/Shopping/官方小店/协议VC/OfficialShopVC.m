//
//  OfficialShopVC.m
//  Shopping
//
//  Created by kalacheng on 2020/6/22.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OfficialShopVC.h"
#import "SettleInView.h"
#import "AgreementView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "SubmitShopInfoVC.h"
@interface OfficialShopVC ()
@property(nonatomic,strong)SettleInView *settleInView;///协议View
@property(nonatomic,strong)AgreementView *agreementView;///协议按钮
@end

@implementation OfficialShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"官方小店");
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubView];
}

-(void)creatSubView{
    
    [self.view addSubview:self.settleInView];
    [self.view addSubview:self.agreementView];
}


-(SettleInView *)settleInView{
    if (!_settleInView) {
       _settleInView = [[SettleInView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSafeAreaBottom - kNavBarHeight - 100)];
//        _settleInView.titleStr = self.postTitle;
        _settleInView.contentStr = self.postExcerpt;
        
    }
    return _settleInView;
}

-(AgreementView *)agreementView{
    if (!_agreementView) {
       _agreementView = [[AgreementView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100 - kSafeAreaBottom- kNavBarHeight,kScreenWidth, 100+kSafeAreaBottom)];
        kWeakSelf(self);
        _agreementView.agreeBtnBlock = ^{
            [weakself jumpVC];
        };
    }
    return _agreementView;
}


-(void)jumpVC{
    [RouteManager routeForName:RN_Shopping_SubmitShopInfoVC currentC:self parameters:@{@"vcType":@(0)}];
}


@end
