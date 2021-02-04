//
//  WorkPickerVC.m
//  TuoTuoWeiBao
//
//  Created by 创业酵母 on 2020/6/23.
//  Copyright © 2020 tuotuojia. All rights reserved.
//

#import "WorkPickerVC.h"
#import "WorkPickerModel.h"

@interface WorkPickerVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backGroudView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UIPickerView *pickerVIew;

@property (nonatomic, assign) CGFloat groudViewHeight;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger selectedIndex_First;
@property (nonatomic, assign) NSInteger selectedIndex_Second;
@property (nonatomic, assign) NSInteger selectedIndex_Third;

@end

@implementation WorkPickerVC

- (void)initWithData{
    [super initWithData];
    
    self.groudViewHeight = (54+220)+kBottomHeight;
    
    self.selectedIndex_First = 0;
    self.selectedIndex_Second = 0;
    self.selectedIndex_Third = 0;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backGroudView.frame = CGRectMake(0, kScreen_Height-self.groudViewHeight, kScreen_Width, self.groudViewHeight);
        [self reloadWithPickerView];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    // Do any additional setup after loading the view.
}

- (void)reloadWithPickerView{
    
    if (self.numberOfSection > 0) {
        [self.pickerVIew reloadComponent:0];
        [self.pickerVIew selectRow:self.selectedIndex_First inComponent:0 animated:NO];
    }
    if (self.numberOfSection > 1) {
        [self.pickerVIew reloadComponent:1];
        [self.pickerVIew selectRow:self.selectedIndex_Second inComponent:1 animated:NO];
    }
    if (self.numberOfSection > 2) {
        [self.pickerVIew reloadComponent:2];
        [self.pickerVIew selectRow:self.selectedIndex_Third inComponent:2 animated:NO];
    }
}

- (void)setDataArr:(NSArray *)dataArr{
    
    if (self.fromType == 1) {
        [self getWithAdressViewData:dataArr];
    }else if (self.fromType == 2){
        [self getWithViewData:dataArr];
    }
}

- (void)getWithViewData:(NSArray *)arr {
    
    [self.dataArray removeAllObjects];
        
    for (NSDictionary *provinceJson in arr) {
        WorkPickerModel *pickerModel = [[WorkPickerModel alloc] initWithDictionary:provinceJson];
        pickerModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)self.dataArray.count];
        if (provinceJson[@"sub"] && [provinceJson[@"sub"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *cityJson in provinceJson[@"sub"]) {
                WorkPickerSecondModel *pickerSecondModel = [[WorkPickerSecondModel alloc] initWithDictionary:cityJson];
                pickerSecondModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)pickerModel.list.count];
                [pickerModel.list addObject:pickerSecondModel];
                if (cityJson[@"sub"] && [cityJson[@"sub"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *districtJson in cityJson[@"sub"]) {
                        WorkPickerThirdModel *pickerThirdModel = [[WorkPickerThirdModel alloc] initWithDictionary:districtJson];
                        pickerThirdModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)pickerSecondModel.list.count];
                        [pickerSecondModel.list addObject:pickerThirdModel];
                    }
                }
            }
        }
        [self.dataArray addObject:pickerModel];
    }
}

#pragma mark 地址的数据处理
- (void)getWithAdressViewData:(NSArray *)arr{
    
    [self.dataArray removeAllObjects];
        
    for (NSDictionary *provinceJson in arr) {
        WorkPickerModel *pickerModel = [[WorkPickerModel alloc] initWithDictionary:provinceJson];
        pickerModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)self.dataArray.count];
        if (provinceJson[@"children"] && [provinceJson[@"children"] isKindOfClass:[NSArray class]]) {
            int m = 0;
            for (NSDictionary *cityJson in provinceJson[@"children"]) {
                WorkPickerSecondModel *pickerSecondModel = [[WorkPickerSecondModel alloc] initWithDictionary:cityJson];
                pickerSecondModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)pickerModel.list.count];
                if (m == 0 && self.isAllState) {
                    WorkPickerSecondModel *tModel = [[WorkPickerSecondModel alloc] init];
                    tModel.name = @"全部";
                    [pickerModel.list addObject:tModel];
                }
                [pickerModel.list addObject:pickerSecondModel];
                m++;
                
                int y = 0;
                if (cityJson[@"children"] && [cityJson[@"children"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *districtJson in cityJson[@"children"]) {
                        WorkPickerThirdModel *pickerThirdModel = [[WorkPickerThirdModel alloc] initWithDictionary:districtJson];
                        pickerThirdModel.index = [NSString stringWithFormat:@"%lu", (unsigned long)pickerSecondModel.list.count];
                        if (y == 0 && self.isAllState) {
                            WorkPickerThirdModel *tModel = [[WorkPickerThirdModel alloc] init];
                            tModel.name = @"全部";
                            [pickerSecondModel.list addObject:tModel];
                        }
                        [pickerSecondModel.list addObject:pickerThirdModel];
                        y++;
                    }
                }
            }
        }
        [self.dataArray addObject:pickerModel];
    }
}

#pragma mark 取消按钮点击事件
- (void)cancleBtnClick{
    
    [self closeBtnClick];
}

#pragma mark 关闭点击事件
- (void)closeBtnClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backGroudView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, self.groudViewHeight);
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark 确定按钮点击事件
- (void)sureBtnClick{
    
    if (self.dataArray.count > 0) {
        WorkPickerModel *pickerModel = [self.dataArray safeObjectIndex:self.selectedIndex_First];
        WorkPickerSecondModel *pickerSecondModel;
        WorkPickerThirdModel *pickerThirdModel;
        if (pickerModel.list.count > 0) {
            pickerSecondModel = [pickerModel.list safeObjectIndex:self.selectedIndex_Second];
        }
        if (pickerSecondModel && pickerSecondModel.list.count > 0) {
            pickerThirdModel = [pickerSecondModel.list safeObjectIndex:self.selectedIndex_Third];
        }
        
        NSString *selectTotalStr;
        if (!pickerSecondModel || self.pickerVIew.numberOfComponents == 1) {
            selectTotalStr = [NSString stringWithFormat:@"%@",pickerModel.name];
        } else {
            if (!pickerThirdModel || self.pickerVIew.numberOfComponents == 2) {
                selectTotalStr = [NSString stringWithFormat:@"%@/%@",pickerModel.name,pickerSecondModel.name];
            } else {
                selectTotalStr = [NSString stringWithFormat:@"%@/%@/%@",pickerModel.name,pickerSecondModel.name,pickerThirdModel.name];
            }
        }
        
        if (self.fromType == 1 && self.isAllState) {
            if ([selectTotalStr hasSuffix:@"/全部"]) {
                selectTotalStr = [selectTotalStr substringToIndex:selectTotalStr.length-3];
            }
        }
        
        if (self.WorkPickerSelectBlock) {
            self.WorkPickerSelectBlock(selectTotalStr);
        }
        [self closeBtnClick];
    }
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.backGroudView];
    [self.backGroudView addSubview:self.sureBtn];
    [self.backGroudView addSubview:self.cancleBtn];
    [self.backGroudView addSubview:self.titleLabel];
    [self.backGroudView addSubview:self.lineImageV];
    [self.backGroudView addSubview:self.pickerVIew];

    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 54));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(80, 54));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(54);
        make.left.equalTo(self.cancleBtn.mas_right).with.offset(20);
        make.right.equalTo(self.sureBtn.mas_left).with.offset(-20);
    }];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.sureBtn.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.pickerVIew mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(0);
    }];
}

//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.numberOfSection;
}

//每列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    WorkPickerModel *pickerModel;
     if (self.dataArray.count > 0) {
         pickerModel = [self.dataArray safeObjectIndex:self.selectedIndex_First];
     }
    
     WorkPickerSecondModel *pickerSecondModel;
     if (pickerModel && pickerModel.list.count > 0) {
         pickerSecondModel = [pickerModel.list safeObjectIndex:self.selectedIndex_Second];
     }
     if (self.dataArray.count != 0) {
         if (component == 0) {
             return self.dataArray.count;
         } else if (component == 1) {
             return pickerModel == nil ? 0 : pickerModel.list.count;
         } else if (component == 2) {
             return pickerSecondModel == nil ? 0 : pickerSecondModel.list.count;
         } else {
             return 0;
         }
     } else {
         return 0;
     }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 44.0;
}

//title
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        WorkPickerModel *pickerModel = [self.dataArray safeObjectIndex:row];
        return pickerModel.name;
    } else if (component == 1) {
        WorkPickerModel *pickerModel = [self.dataArray safeObjectIndex:self.selectedIndex_First];
        WorkPickerSecondModel *pickerSecondModel = [pickerModel.list safeObjectIndex:row];
        return pickerSecondModel.name;
    } else if (component == 2) {
        WorkPickerModel *pickerModel = [self.dataArray safeObjectIndex:self.selectedIndex_First];
        WorkPickerSecondModel *pickerSecondModel = [pickerModel.list safeObjectIndex:self.selectedIndex_Second];
        WorkPickerThirdModel *pickerThirdModel = [pickerSecondModel.list safeObjectIndex:row];
        return pickerThirdModel.name;
    } else {
        return nil;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:17.0] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
    }
    
    NSString *textStr = [self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.text = textStr;
    
    if (@available(iOS 14.0, *)){
       //不做处理
    }else{
        UIView *topLineView = [self.pickerVIew.subviews safeObjectIndex:1];
        topLineView.backgroundColor = Color_Separator;
        
        UIView *bottomLineView = [self.pickerVIew.subviews safeObjectIndex:2];
        bottomLineView.backgroundColor = Color_Separator;
    }
    
    return pickerLabel;
}

//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            self.selectedIndex_First = row;
            self.selectedIndex_Second = 0;
            self.selectedIndex_Third = 0;
            if (self.numberOfSection > 1) {
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:NO];
            }
            if (self.numberOfSection > 2) {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];
            }
            break;
        case 1:
            self.selectedIndex_Second = row;
            self.selectedIndex_Third = 0;
            if (self.numberOfSection > 2) {
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:NO];
            }
            break;
        case 2:
            self.selectedIndex_Third = row;
            break;
        default:
            break;
    }
}

/*
 * creat closeBtn
 */
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [UIButton createButtonWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-self.groudViewHeight) normalImage:@""];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _closeBtn;
}

/*
 * creat backGroudView
 */
- (UIView *)backGroudView{
    
    if (!_backGroudView) {
        _backGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, self.groudViewHeight)];
        _backGroudView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backGroudView;
}

/*
 * creat sureBtn
 */
- (UIButton *)sureBtn{
    
    if (!_sureBtn) {
        _sureBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainBlue font:[UIFont M_PingFang_RegularOfSize:17.0] backgroundColor:[UIColor whiteColor] title:@"确定"];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sureBtn;
}

/*
 * creat cancleBtn
 */
- (UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        _cancleBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainGray font:[UIFont M_PingFang_RegularOfSize:17.0] backgroundColor:[UIColor whiteColor] title:@"取消"];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancleBtn;
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:17.0] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:self.titleStr];
    }
    
    return _titleLabel;
}

/*
 * creat lineImageV
 */
- (UIImageView *)lineImageV{
    
    if (!_lineImageV) {
        _lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _lineImageV.backgroundColor = Color_Separator;
    }
    
    return _lineImageV;
}

/*
 * creat pickerVIew
 */
- (UIPickerView *)pickerVIew{
    
    if (!_pickerVIew) {
        _pickerVIew = [[UIPickerView alloc]initWithFrame:CGRectZero];
        _pickerVIew.delegate = self;
        _pickerVIew.dataSource = self;
    }
    
    return _pickerVIew;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
