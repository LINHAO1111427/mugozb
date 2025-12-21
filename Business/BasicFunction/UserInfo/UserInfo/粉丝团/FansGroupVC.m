//
//  FansGroupVC.m
//  Fans
//
//  Created by klc on 2020/3/18.
//

#import "FansGroupVC.h"

#import "FansGroupCell.h"
#import "FansGroupHeaderView.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjView/ZQAlterField.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/HttpApiAPPFinance.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/CustomCameraController.h>
#import <LibProjView/SendIMMessageObj.h>

@interface FansGroupVC ()<UITableViewDelegate,UITableViewDataSource,FansGroupHeaderViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)FansGroupHeaderView *headerView;
@property(nonatomic,strong)FansInfoDtoModel *fansInfoModel;
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *coinStr;
@property (nonatomic, copy)NSString *avatarStr;
@end

@implementation FansGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ///我的粉丝团
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatSubView];
}


-(void)creatSubView{
    
    self.nameStr = @"";
    self.coinStr = @"";
    self.avatarStr = @"";
    
    _headerView = [[FansGroupHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 378-22+kStatusBarHeight)];
    _headerView.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    [self.view addSubview:self.tableView];
    
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadFansTeamInfo];
        [weakself loadData:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData:NO];
    }];
    
    [self loadFansTeamInfo];
    [self loadData:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else{
        return 70;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:@"titleDetaileCellID"];
        if (!defaultCell) {
            defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleDetaileCellID"];
            UILabel *textL = [[UILabel alloc] init];
            textL.text = kLocalizationMsg(@"排行榜");
            textL.textColor = kRGBA_COLOR(@"#333333", 1.0);
            textL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
            [defaultCell addSubview:textL];
            [textL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(defaultCell);
                make.top.equalTo(defaultCell).offset(15);
            }];
        }
        return defaultCell;
    }else{
        FansGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FansGroupCellID" forIndexPath:indexPath];
        cell.ranksModel = self.dataArr[indexPath.row-1];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 16.0+kSafeAreaBottom;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.cornerRadius = 10;
        _tableView.enableCornerRadiusCell = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.cornerRadiusMaskInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        _tableView.cornerRadiusStyle = KYTableViewCornerRadiusStyleSectionTopAndBottom;
        _tableView.dataSource = self;
        [_tableView registerClass:[FansGroupCell class] forCellReuseIdentifier:@"FansGroupCellID"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCellID"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



//粉丝团信息
-(void)loadFansTeamInfo{
    [HttpApiAnchorController fansTeamInfo:[self.idStr longLongValue] callback:^(int code, NSString *strMsg, FansInfoDtoModel *model) {
        if (code == 1) {
            self.fansInfoModel = model;
            self.headerView.fansInfoModel = model;
            self.nameStr =  self.fansInfoModel.fansTeamName;
            self.coinStr = [NSString stringWithFormat:@"%.0f",self.fansInfoModel.coin] ;
            self.avatarStr = model.fansTeamAvatar;
            [self.tableView reloadData];
            
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



//粉丝团 排行
- (void)loadData:(BOOL)refresh{
    int pageSize = kPageSize;
    int pageIndex = refresh?0:(int)self.dataArr.count/pageSize + (self.dataArr.count%pageSize?1:0);
    kWeakSelf(self);
    [HttpApiAPPFinance getFansTeamRank:[self.idStr intValue] pageIndex:pageIndex pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<RanksDtoModel *> *arr) {
        if (code == 1) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (arr.count > 0) {
                if (refresh) {
                    [weakself.dataArr removeAllObjects];
                }
                [weakself.dataArr addObjectsFromArray:arr];
                
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (weakself.dataArr.count == 0 ) {
                self.headerView.rankTitleLable.hidden = YES;
            }
            
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        
    }];
}


//设置粉丝图名称或者加入粉丝团的金币数
-(void)setFansNameOrCoinData:(int)type{
    kWeakSelf(self);
    [HttpApiAnchorController setFansTeamInfo:self.avatarStr coin:[self.coinStr intValue] name:self.nameStr callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"设置成功")];
            switch (type) {
                case 0:
                    self.fansInfoModel.fansTeamName = self.nameStr;
                    break;
                case 1:
                    self.fansInfoModel.coin = [self.coinStr doubleValue];
                    break;
                case 2:
                    self.fansInfoModel.fansTeamAvatar = weakself.avatarStr;
                    break;
                default:
                    break;
            }
            self.headerView.fansInfoModel = self.fansInfoModel;
            [weakself deleteFansInfo];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

- (void)deleteFansInfo{
    [IMInfoManager deleteFansGroupExtraInfo:[self.idStr longLongValue]];
}

- (void)setFansGroupIconClick{
    [self doUploadPicture];
}

- (void)setFansGroupNameClick:(NSString *)nameStr{
    
    self.nameStr = nameStr;
    [self showEditView:0];
    
}
- (void)setFansGroupCoinClick:(NSString *)CoinStr{
    
    self.coinStr = CoinStr;
    [self showEditView:1];
}

- (void)showEditView:(int)type{
    
    for(UIView * view in [[UIApplication sharedApplication].keyWindow subviews]){
        if([view isKindOfClass:[ZQAlterField class]]){
            [[[UIApplication sharedApplication].keyWindow viewWithTag:10300] removeFromSuperview];
            //            [[[UIApplication sharedApplication].keyWindow viewWithTag:10301] removeFromSuperview];
        }
    }
    
    ZQAlterField *ZQAlertView = [ZQAlterField alertView];
    ZQAlertView.tag = 10300;
    switch (type) {
        case 0:
            ZQAlertView.placeholder = self.nameStr;
            ZQAlertView.title = kLocalizationMsg(@"设置粉丝团名称");
            break;
        case 1:
            ZQAlertView.placeholder = self.coinStr;
            ZQAlertView.title = kStringFormat(kLocalizationMsg(@"设置入团%@"),[KLCAppConfig unitStr]);
            ZQAlertView.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        default:
            break;
    }
    ZQAlertView.Maxlength = 20;
    kWeakSelf(ZQAlertView);
    [ZQAlertView ensureClickBlock:^(NSString *inputString) {
        
        if (inputString.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"未设置成功")];
        }else{
            switch (type) {
                case 0:
                    self.nameStr = inputString;
                    break;
                case 1:
                    self.coinStr = inputString;
                    break;
                default:
                    break;
            }
            [self setFansNameOrCoinData:type];
        }
        [weakZQAlertView dismiss];
    }];
    [ZQAlertView show];
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:[UIColor whiteColor]];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:target action:action]];
    
}



#pragma  mark - 图片 选择和上传
///相册选择
- (void)doUploadPicture{
    
    kWeakSelf(self);
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertContro addAction:photoAction];
    [alertContro addAction:picAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    [self presentViewController:alertContro animated:NO completion:nil];
}


- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {
        
        CustomCameraController *camera = [[CustomCameraController alloc] init] ;
        camera.showPhotoAlbum = NO;
        camera.functionType = CameraFunction_onlyCamera;
        [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
            [cameraVC dismissViewControllerAnimated:NO completion:nil];
            [weakself uploadImage:images.firstObject];
        }];
        [self presentViewController:camera animated:YES completion:nil];
        
    }else{
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.maxImagesCount = 1;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = NO;
        imagePickerVc.showSelectBtn = NO;
        imagePickerVc.allowCrop = YES;
        imagePickerVc.cropRect = CGRectMake(10, (kScreenHeight- kScreenWidth-20)/2.0, kScreenWidth-20, kScreenWidth-20);
        
        imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviBgColor = [UIColor whiteColor];
        [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
            [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        }];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            UIImage* image = photos.firstObject;
            [weakself uploadImage:image];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}

- (void)uploadImage:(UIImage *)image{
    kWeakSelf(self);
    __block UIImage *uploadImage = [UIImage imageWithData:[image compressWithMaxLength:1024*100]];
    [SkyDriveTool uploadImageFormScene:1 image:uploadImage complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传成功")];
            weakself.avatarStr = imageUrl;
            [weakself setFansNameOrCoinData:2];
            
        }else{
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}

- (void)setFansIcon{
    
}

@end
