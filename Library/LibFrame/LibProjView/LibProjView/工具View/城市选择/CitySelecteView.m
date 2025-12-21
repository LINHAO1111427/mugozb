//
//  CitySelecteView.m
//  LibProjView
//
//  Created by ssssssss on 2020/1/11.
//  Copyright © 2020 . All rights reserved.
//

#import "CitySelecteView.h"
#import <LibTools/LibTools.h>
#import <LibProjModel/HttpApiHome.h>
#import <LibProjModel/AppAreaModel.h>
#import <LibProjModel/AppTabInfoModel.h>
#import <LibProjModel/KeyValueDtoModel.h>
#import "CityModel.h"
#import <LibProjView/LibProjViewRes.h>
#import <LibProjBase/TXMapManager.h>

@interface CitySelecteView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)citySelectedCallBack back;
@property(nonatomic,assign)CitySelecteType viewType;

//data
@property(nonatomic,strong)NSArray *citys;
@property(nonatomic,strong)NSArray *hotCitys;
@property(nonatomic,strong)NSArray *genders;
@property(nonatomic,strong)NSArray *tags;

//view
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UILabel *mylocationLabel;
@property(nonatomic,strong)UIView *hotView;
@property(nonatomic,strong)UIView *genderView;
@property(nonatomic,strong)UIView *tagView;

//selected
@property(nonatomic,copy)NSString *myCity;//城市
@property(nonatomic,copy)NSString *selectedCity;
@property(nonatomic,strong)KeyValueDtoModel *selectedGenderModel;//性别
@property(nonatomic,strong)NSMutableArray *selectedTags;//标签
@property(nonatomic,strong)UIButton *allSelectedBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *clearAllBtn;
 
@property(nonatomic,copy)NSString *selectedGenderStr;
 
@end

@implementation CitySelecteView
- (NSArray *)hotCitys{
    if (!_hotCitys) {
        _hotCitys = [NSArray array];
    }
    return _hotCitys;
}
- (NSMutableArray *)selectedTags{
    if (!_selectedTags) {
        _selectedTags = [NSMutableArray array];
    }
    return _selectedTags;
}

- (NSArray *)citys {
    if(!_citys) {
        
        NSArray *dataArr = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[LibProjViewRes getNibFullName:@"locationCity"] ofType:@"plist"]];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSArray *subArr in dataArr) {
            NSString *city = subArr.firstObject;
            NSString *fistChar = [self firstCharactor:city];
            CityModel *model = [[CityModel alloc]init];
            model.firstChar = fistChar;
            model.subCitys = subArr;
            [mArray addObject:model];
        }
        _citys = mArray;
    }
    return _citys;
}
 
- (NSString *)firstCharactor:(NSString *)aString{
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *pinYin = [str capitalizedString];
    
    NSString *firatCharactors = [NSMutableString string];
    unichar charStr = [pinYin characterAtIndex:0];
    if (charStr >= 'A' && charStr <= 'Z') {
        firatCharactors = [NSString stringWithFormat:@"%C",charStr];
    }
    return firatCharactors;
}
 
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)showInView:(UIView*)view withType:(CitySelecteType)viewType callBack:(citySelectedCallBack)callBack{
    if (!view) {
        return;
    }
    self.viewType = viewType;
    self.back = callBack;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [view addSubview:self];
    
    [self createUI];
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    } completion:nil];
}



- (void)showInView:(UIView*)view withType:(CitySelecteType)viewType andSetSeleCityName:(NSString *)cityName andGenderStr:(NSString *)genderStr andTagsArr:(NSArray *)TagsArr callBack:(citySelectedCallBack)callBack{
    if (!view) {
        return;
    }
    self.viewType = viewType;
    self.back = callBack;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    [view addSubview:self];
    self.selectedCity = cityName;
    self.selectedGenderStr = genderStr;
    [self.selectedTags addObjectsFromArray:TagsArr];
    
    [self createUI];
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    } completion:nil];
    
}



- (void)createUI{
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, kNavBarHeight-42, 40, 40)];
    [closeBtn setImage:[UIImage imageNamed:@"present_close"] forState:UIControlStateNormal];
    closeBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    if (self.viewType == CitySelecteTypeNearby) {
        UIButton *allSelectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-66, kNavBarHeight-42, 50, 40)];
        [allSelectedBtn setTitle:kLocalizationMsg(@"全部") forState:UIControlStateNormal];
        [allSelectedBtn setTitleColor: kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [allSelectedBtn addTarget:self action:@selector(allSelectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        allSelectedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.allSelectedBtn = allSelectedBtn;
        [self addSubview:self.allSelectedBtn];
    }else{
        UIButton *clearAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-66, kNavBarHeight-42, 50, 40)];
        [clearAllBtn setTitle:kLocalizationMsg(@"清空") forState:UIControlStateNormal];
        [clearAllBtn setTitleColor: kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        [clearAllBtn addTarget:self action:@selector(clearAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        clearAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.clearAllBtn = clearAllBtn;
        [self addSubview:self.clearAllBtn];
    }
     
     
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16+40, kNavBarHeight-32, kScreenWidth-56*2, 20)];
    titleLabel.textColor =kRGB_COLOR(@"#2B2C2C");
    titleLabel.font = [UIFont systemFontOfSize:17];
    if (self.viewType == CitySelecteTypeNearby) {
        NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"location_city"];
        if (city.length > 0) {
             titleLabel.text = city;
            self.allSelectedBtn.hidden = NO;
        }else{
            titleLabel.text = kLocalizationMsg(@"选择城市");
            self.allSelectedBtn.hidden = YES;
        }
        
    }else{
        titleLabel.text = kLocalizationMsg(@"选择");
    }
     
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight-0.5, kScreenWidth, 0.5)];
    line.backgroundColor =kRGBA_COLOR(@"#DEDEDE",0.5);
    [self addSubview:line];
    [self addSubview:self.tableView];
    if (self.viewType == CitySelecteTypeNearby) {
        self.tableView.sectionIndexColor = [UIColor blackColor];
        self.tableView.sectionIndexBackgroundColor =[UIColor clearColor];
        self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
     
    kWeakSelf(self);
    [[TXMapManager shareInstance] startSingleLocation:^(BOOL success, LocationInfoModel * _Nonnull infoModel) {
        if (success) {
            NSString *cityStr = infoModel.city;
            if ([cityStr containsString:kLocalizationMsg(@"市")]) {
                cityStr =[cityStr substringToIndex:cityStr.length-1];
            }
            weakself.myCity = cityStr;
            weakself.mylocationLabel.text = cityStr;
        }else{
            weakself.mylocationLabel.text = kLocalizationMsg(@"定位失败");
        }
    }];
    
    //加载热门城市
    [self loadSelectedData];
}


- (void)loadSelectedData{
    kWeakSelf(self);
    [HttpApiHome getO2OSearchCondition:^(int code, NSString *strMsg, SearchConditionDtoModel *model) {
        if (code == 1) {
            weakself.hotCitys = model.hotCitys;
            ///如果是广场
            if (self.viewType == CitySelecteTypeSquare) {
               NSArray *sexes = [[ProjConfig shareInstence].baseConfig getSexSelectedArray];
                if (sexes) {
                    weakself.genders = [self getLocalGneders:sexes];
                }else{
                    weakself.genders = model.sexs;
                }
                 
                weakself.tags = model.allTabInfoList;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self addHeaderView];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (NSArray *)getLocalGneders:(NSArray *)array{
    NSMutableArray *genders = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSString *value = dic[@"title"];
        NSString *key = dic[@"sex"];
        KeyValueDtoModel *model = [[KeyValueDtoModel alloc]init];
        model.value = value;
        model.key = key;
        [genders addObject:model];
    }
    return (NSArray*)genders;
}
- (void)addHeaderView{
     
    NSInteger hotNum = 0,tagNum = 0;
    if (self.hotCitys.count > 0) {
        hotNum  = (self.hotCitys.count-1)/4+1;
    }
    CGFloat maginVspace = 110;
    if (hotNum == 0) {
        maginVspace = 60;
    }
    if (self.viewType == CitySelecteTypeSquare) {
        if (self.genders.count > 0) {
            maginVspace += 100;
        }
        if (self.tags.count > 0) {
            maginVspace += 50;
            tagNum = (self.tags.count-1)/4+1;
        }
    }
    CGFloat height = maginVspace+hotNum*40+tagNum*40+40;
    if (self.viewType == CitySelecteTypeSquare) {
        height = kScreenHeight-40;
    }
    
    CGFloat headerMaxH = 20;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headerMaxH)];
    headerView.backgroundColor = [UIColor whiteColor];
    //定位
    UIImageView *locationImageV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, 20, 20)];
    locationImageV.image = [UIImage imageNamed:@"userInfo_location"];
    [headerView addSubview:locationImageV];
    UILabel *myLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(37, 20, kScreenWidth-55, 20)];
    myLocationLabel.textAlignment = NSTextAlignmentLeft;
    myLocationLabel.text = self.myCity;
    self.mylocationLabel = myLocationLabel;
    [headerView addSubview:self.mylocationLabel];
    
    if (self.viewType == CitySelecteTypeNearby) {
        UIControl *locationControl = [[UIControl alloc]initWithFrame:CGRectMake(12, 10, 150, 40)];
        [locationControl addTarget:self action:@selector(locationCitySelected) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:locationControl];
    }
     
    //热门城市
    if (hotNum > 0) {
        UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 60, kScreenWidth-24, 20)];
        hotLabel.textAlignment = NSTextAlignmentLeft;
        hotLabel.text = kLocalizationMsg(@"热门城市");
        hotLabel.font = [UIFont systemFontOfSize:15];
        hotLabel.textColor =kRGB_COLOR(@"#AAAAAA");
        [headerView addSubview:hotLabel];
        
        UIView *hotView =[[UIView alloc]initWithFrame:CGRectMake(12, hotLabel.maxY+10, kScreenWidth-24, 20+hotNum*40)];
        hotView.backgroundColor = [UIColor clearColor];
        self.hotView = hotView;
        [headerView addSubview:self.hotView];
        
        CGFloat width = 72*kScreenWidth/360.0;
        CGFloat space = (kScreenWidth-24-4*width)/3.0;
        NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:@"location_city"];
        for (int i = 0; i < self.hotCitys.count; i++) {
            AppAreaModel *model = self.hotCitys[i];
            NSInteger row = i/4;
            NSInteger col = i%4;
            UIButton *btn = [UIButton buttonWithType:0];
            btn.frame = CGRectMake(col*(width+space), 10+row*40, width, 32);
            btn.layer.borderColor =kRGB_COLOR(@"#CCCCCC").CGColor;
            btn.layer.borderWidth = 1.0;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor: kRGB_COLOR(@"#EEEEEE")] forState:UIControlStateSelected];
            btn.tag = i;
            btn.titleLabel.text = model.name;
            btn.titleLabel.hidden = YES;
            [btn addTarget:self action:@selector(hotCityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.hotView addSubview:btn];
            
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, btn.width-2, btn.height-2)];
            [btn addSubview:titleL];
            titleL.font = [UIFont systemFontOfSize:14];
            titleL.minimumScaleFactor = 0.7;
            titleL.adjustsFontSizeToFitWidth = YES;
            titleL.text = model.name;
            titleL.textColor = kRGB_COLOR(@"#333333");
            titleL.numberOfLines = 0;
            titleL.textAlignment = NSTextAlignmentCenter;

            if (self.viewType == CitySelecteTypeNearby) {
                if ([city isEqualToString:model.name]) {
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
            }else{
                
                if ([self.selectedCity isEqualToString:model.name]) {
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
            }
        }
        headerMaxH = hotView.maxY+20;
    }
    if (self.viewType == CitySelecteTypeSquare) {
        //性别
        if (self.genders.count > 0) {
            UILabel *genderLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, headerMaxH+10, kScreenWidth-24, 20)];
            genderLabel.textAlignment = NSTextAlignmentLeft;
            NSArray *array = [[ProjConfig shareInstence].baseConfig getSexSelectedArray];
            if (array) {
                NSString *tip = array.firstObject[@"tip"];
                genderLabel.text = tip;
            }else{
                genderLabel.text = kLocalizationMsg(@"选择性别");
            }
            genderLabel.font = [UIFont systemFontOfSize:15];
            genderLabel.textColor =kRGB_COLOR(@"#AAAAAA");
            [headerView addSubview:genderLabel];
            
            UIView *genderView =[[UIView alloc]initWithFrame:CGRectMake(12, genderLabel.maxY+10, kScreenWidth-24, 50)];
            genderView.backgroundColor = [UIColor clearColor];
            self.genderView = genderView;
            [headerView addSubview:self.genderView];
            
            CGFloat width = 72*kScreenWidth/360.0;
            CGFloat space = (kScreenWidth-24-4*width)/3.0;
            for (int i = 0; i < self.genders.count; i++) {
                KeyValueDtoModel *model = self.genders[i];
                NSInteger row = i/4;
                NSInteger col = i%4;
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(col*(width+space), 10+row*40, width, 32)];
                btn.layer.borderColor =kRGB_COLOR(@"#CCCCCC").CGColor;
                btn.layer.borderWidth = 1.0;
                [btn setTitle:model.value forState:UIControlStateNormal];
                btn.titleLabel.font = kFont(14);
                btn.titleLabel.hidden = YES;
                [btn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageWithColor: kRGB_COLOR(@"#EEEEEE")] forState:UIControlStateSelected];
                btn.tag = i;
                [btn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.genderView addSubview:btn];
                
                if ([model.key isEqualToString:self.selectedGenderStr]) {
                    btn.selected = YES;
                     self.selectedGenderModel = model;
                }else{
                    btn.selected = NO;
                }
                
                
            }
            
            headerMaxH = genderView.maxY+20;
        }
         
        //标签
        if (self.tags.count > 0) {
            UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, headerMaxH+10, kScreenWidth-24, 20)];
            tagLabel.textAlignment = NSTextAlignmentLeft;
            tagLabel.text = kLocalizationMsg(@"选择兴趣标签");
            tagLabel.font = [UIFont systemFontOfSize:15];
            tagLabel.textColor =kRGB_COLOR(@"#AAAAAA");
            [headerView addSubview:tagLabel];
            
            UIView *tagView =[[UIView alloc]initWithFrame:CGRectMake(12, tagLabel.maxY+10, kScreenWidth-24, 10+tagNum*40)];
            tagView.backgroundColor = [UIColor clearColor];
            self.tagView = tagView;
            [headerView addSubview:self.tagView];
            
            CGFloat width = 72*kScreenWidth/360.0;
            CGFloat space = (kScreenWidth-24-4*width)/3.0;
            for (int i = 0; i < self.tags.count; i++) {
                AppTabInfoModel *model = self.tags[i];
                NSInteger row = i/4;
                NSInteger col = i%4;
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(col*(width+space), 10+row*40, width, 32)];
                btn.layer.borderColor =kRGB_COLOR(@"#CCCCCC").CGColor;
                btn.layer.borderWidth = 1.0;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageWithColor: kRGB_COLOR(@"#EEEEEE")] forState:UIControlStateSelected];
                btn.tag = i;
                btn.titleLabel.text = model.name;
                btn.titleLabel.hidden = YES;
                [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.tagView addSubview:btn];
                
                UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, btn.width-2, btn.height-2)];
                [btn addSubview:titleL];
                titleL.font = [UIFont systemFontOfSize:14];
                titleL.minimumScaleFactor = 0.7;
                titleL.adjustsFontSizeToFitWidth = YES;
                titleL.text = model.name;
                titleL.textColor = kRGB_COLOR(@"#333333");
                titleL.numberOfLines = 0;
                titleL.textAlignment = NSTextAlignmentCenter;
                
                for (AppTabInfoModel *seleModel in self.selectedTags) {
                     if (model.id_field  == seleModel.id_field) {
                         btn.selected = YES;
                     }
                }

            }
            
            headerMaxH = self.tagView.maxY+20;
        }
        
        //确定按钮
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, headerMaxH+60, 160, 40)];
        sureBtn.backgroundColor = [ProjConfig normalColors];
        [sureBtn setTitle:kLocalizationMsg(@"确定") forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        sureBtn.layer.cornerRadius = 20;
        sureBtn.clipsToBounds = YES;
        sureBtn.centerX = headerView.centerX;
        [sureBtn addTarget:self action:@selector(sureBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:sureBtn];
        
        headerMaxH = sureBtn.maxY + 40;
    }
    if (self.viewType == CitySelecteTypeNearby) {
        
        UIView *botttomV = [[UIView alloc]initWithFrame:CGRectMake(0, headerMaxH, kScreenWidth, 10)];
        botttomV.backgroundColor = kRGB_COLOR(@"#F4F4F4");
        [headerView addSubview:botttomV];
        
        headerMaxH = botttomV.maxY+20;
    }
    
    headerView.height = headerMaxH;
    self.tableView.tableHeaderView = headerView;
}

- (void)sureBtnCLick:(UIButton *)btn{
  
    self.back(NO, self.selectedCity, self.selectedGenderModel?self.selectedGenderModel.key:@"-1", self.selectedTags);
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)clearAllBtnClick:(UIButton *)btn{
    self.selectedCity = nil;
    self.selectedGenderModel = nil;
    [self.selectedTags removeAllObjects];
    [self addHeaderView];
 
}
- (void)closeBtnClick:(UIButton *)btn{
    self.back(YES,nil,nil,nil);
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)hotCityBtnClick:(UIButton *)btn{
    for (UIButton *subBtn in self.hotView.subviews) {
        subBtn.selected = NO;
    }
    AppAreaModel *model = self.hotCitys[btn.tag];
    if (self.viewType == CitySelecteTypeNearby) {
        NSString *city = model.name;
        btn.selected = YES;
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"location_city"];
        self.back(NO,city,nil,nil);
        [UIView animateWithDuration:0.3f animations:^{
            [self setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        if ([self.selectedCity isEqualToString:model.name]) {
            btn.selected = NO;
            self.selectedCity = nil;
        }else{
            btn.selected = YES;
            self.selectedCity = model.name;
        }
    }
}
- (void)genderBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    for (UIButton *subBtn in self.genderView.subviews) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    if (btn.selected) {
        KeyValueDtoModel *model = self.genders[btn.tag];
        self.selectedGenderModel = model;
    }else{
        self.selectedGenderModel = nil;
    }
}
- (void)allSelectedBtnClick:(UIButton *)btn{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"location_city"];
    self.allSelectedBtn.hidden = YES;
    self.titleLabel.text = kLocalizationMsg(@"选择城市");
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    self.back(NO, @"",nil,nil);
}
- (void)tagBtnClick:(UIButton *)btn{
    AppTabInfoModel *model = self.tags[btn.tag];
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.selectedTags addObject:model];
    }else{
        for (int i = 0; i< self.selectedTags.count; i++) {
            AppTabInfoModel *seleModel = self.selectedTags[i];
            if (model.id_field  == seleModel.id_field) {
//                  [self.selectedTags removeObject:model];
                [self.selectedTags removeObjectAtIndex:i];
            }
        }
    }
}
 
- (void)locationCitySelected{
    if (self.myCity.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.myCity forKey:@"location_city"];
        [UIView animateWithDuration:0.3f animations:^{
            [self setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        self.back(NO, self.myCity,nil,nil);
    }
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.viewType == CitySelecteTypeNearby) {
        return self.citys.count;
    }else{
        return 0;
    }
     
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CityModel *model = self.citys[section];
    return model.subCitys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"citySelected"];
    }
    CityModel *model = self.citys[indexPath.section];
    NSString *city = model.subCitys[indexPath.row];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
    line.backgroundColor =kRGB_COLOR(@"#DEDEDE");
    [cell addSubview:line];
    cell.textLabel.textColor =kRGB_COLOR(@"#333333");
    cell.textLabel.text = city;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([city isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"location_city"]]) {
        cell.backgroundColor =kRGB_COLOR(@"#EEEEEE");
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityModel *model = self.citys[indexPath.section];
    NSString *city = model.subCitys[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"location_city"];
    [self closeBtnClick:nil];
    self.back(NO, city,nil,nil);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CityModel *model = self.citys[section];
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 25)];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont systemFontOfSize:15];
    headerLabel.textColor =kRGBA_COLOR(@"#666666", 2.0);
    headerLabel.text = model.firstChar;
    [header addSubview:headerLabel];
    return header;
}
//索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.viewType == CitySelecteTypeNearby) {
         NSMutableArray *titleArr = [NSMutableArray array];
          for (CityModel *model in self.citys) {
              [titleArr addObject:model.firstChar];
          }
         return titleArr;
    }else{
        return nil;
    }
     
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.viewType == CitySelecteTypeNearby) {
         CityModel *model = self.citys[section];
         return model.firstChar;
    }else{
        return nil;
    }
     
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index{
    if (self.viewType == CitySelecteTypeNearby) {
        return index;
    }else{
        return 0;
    }
}




@end
