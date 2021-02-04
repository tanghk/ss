//
//  IntegUploadLiceView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegUploadLiceView.h"
#import "XZPhotoImagePicker.h"

#define IntegUploadLiceGroudHeight      (246+68)

@interface IntegUploadLiceView ()

@property (nonatomic, strong) UIView *backGroudView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *exampleBtn;
@property (nonatomic, strong) UIButton *licenseBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation IntegUploadLiceView

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backGroudView.frame = CGRectMake(0, kScreen_Height-kBottomHeight-IntegUploadLiceGroudHeight, kScreen_Width, IntegUploadLiceGroudHeight+kBottomHeight);
    } completion:^(BOOL finished) {
        self.nextBtn.hidden = NO;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    // Do any additional setup after loading the view.
}

#pragma mark 关闭点击事件
- (void)closeBtnClick{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backGroudView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, IntegUploadLiceGroudHeight+kBottomHeight);
        self.nextBtn.hidden = YES;
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark 示例点击事件
- (void)exampleBtnClick{
    
    [MBProgressHUD showMessageInWindow:@"示例"];
}

#pragma mark 上传按钮点击事件
- (void)licenseBtnClick{
    
    @weakify(self);
    [XZPhotoImagePicker showPhotoPickerConfig:^(XZPhotoImagePickerConfiger *config) {
        config.presentViewController = self;
        config.maxImagesCount = 1;
        config.pickerType = XZPhotoImagePickerTypeAlbum;
        config.allowPickingImage = YES;
        config.allowTakePicture = YES;
        config.allowPickingVideo = NO;
        config.allowTakeVideo = NO;
        config.allowPickingOriginalPhoto = YES;
    } onSuccess:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, BOOL isCamera,NSString *videoPatch) {
        @strongify(self);
        
    } onCancel:^{
        
    }];
}

#pragma mark 提交按钮点击事件
- (void)nextBtnClick{
    
    [MBProgressHUD showMessageInWindow:@"提交"];
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
//    [self setNavigationTitle:@"集成商入驻" isShowBack:YES hasLine:YES];

}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.backGroudView];
    [self.backGroudView addSubview:self.lineImageV];
    [self.backGroudView addSubview:self.titleLabel];
    [self.backGroudView addSubview:self.cancleBtn];
    [self.backGroudView addSubview:self.tipLabel];
    [self.backGroudView addSubview:self.exampleBtn];
    [self.backGroudView addSubview:self.licenseBtn];
    [self.view addSubview:self.nextBtn];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.backGroudView.mas_top).with.offset(57);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.backGroudView.mas_top).with.offset(16);
        make.centerX.equalTo(self.backGroudView);
        make.height.mas_equalTo(25);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(44, 44));//24*24
        make.right.mas_equalTo(-12+10);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.backGroudView.mas_left).with.offset(16);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(24);
        make.height.mas_equalTo(20);
    }];
    
    [self.exampleBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.backGroudView.mas_left).with.offset(16);
        make.top.equalTo(self.tipLabel.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.licenseBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.exampleBtn.mas_right).with.offset(20);
        make.top.equalTo(self.exampleBtn);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

/*
 * creat closeBtn
 */
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [UIButton createButtonWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-IntegUploadLiceGroudHeight-kBottomHeight) normalImage:@""];
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
        _backGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, IntegUploadLiceGroudHeight+kBottomHeight)];
        [_backGroudView roundCorner:UIRectCornerTopLeft | UIRectCornerTopRight radius:12.0];
        _backGroudView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backGroudView;
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
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_18] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"上传营业执照"];
    }
    
    return _titleLabel;
}

/*
 * creat cancleBtn
 */
- (UIButton *)cancleBtn{
    
    if (!_cancleBtn) {
        _cancleBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_close_24"];
        [_cancleBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _cancleBtn;
}

/*
 * creat tipLabel
 */
- (UILabel *)tipLabel{
    
    if (!_tipLabel) {
        
        NSString *textStr = @"请确保证件完整，标号、印章、文字、照片均清楚可见";
        
        _tipLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainGray_one textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
        
        NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:textStr];
        [messageStr addAttribute:NSForegroundColorAttributeName value:Color_MainBlue range:NSMakeRange(3, textStr.length-3)];
        _tipLabel.attributedText = messageStr;
        
    }
    
    return _tipLabel;
}

/*
 * creat exampleBtn
 */
- (UIButton *)exampleBtn{
    
    if (!_exampleBtn) {
        _exampleBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"license_example"];
        [_exampleBtn setImage:[UIImage imageNamed:@"license_example"] forState:UIControlStateHighlighted];
        [_exampleBtn addTarget:self action:@selector(exampleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _exampleBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _exampleBtn;
}

/*
 * creat licenseBtn
 */
- (UIButton *)licenseBtn{
    
    if (!_licenseBtn) {
        _licenseBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"upload_photo_place"];
        [_licenseBtn setImage:[UIImage imageNamed:@"upload_photo_place"] forState:UIControlStateHighlighted];
        [_licenseBtn addTarget:self action:@selector(licenseBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _licenseBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _licenseBtn;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(16, kScreen_Height-kBottomHeight-10-48, kScreen_Width-2*16, 48) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_RegularOfSize:Font_18] backgroundColor:Color_MainBlue title:@"提交"];
        ViewShadow(_nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        _nextBtn.layer.cornerRadius = 8.0;
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
        
        NSArray *colorArray = @[(id)[HEXACOLOR(0x36A8FF, 1.0) CGColor],
                                (id)[HEXACOLOR(0x2A71FF, 1.0) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:8.0];
        [_nextBtn.layer addSublayer:nextBtnLayer];
        [_nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
    }
    
    return _nextBtn;
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
