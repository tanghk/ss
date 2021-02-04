//
//  IntegrEnterSuccVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegrEnterSuccVC.h"

@interface IntegrEnterSuccVC ()

@property (nonatomic, strong) UIImageView *succImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation IntegrEnterSuccVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"集成商入驻" isShowBack:YES hasLine:YES];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.succImageV];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tipLabel];
    
    [self.succImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.top.mas_equalTo(kTopHeight+56);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(28);
        make.top.equalTo(self.succImageV.mas_bottom).with.offset(16);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(21);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(15);
    }];
}

/*
 * creat succImageV
 */
- (UIImageView *)succImageV{
    
    if (!_succImageV) {
        _succImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"success_img"];
        _succImageV.backgroundColor = [UIColor whiteColor];
    }
    
    return _succImageV;
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_20] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"提交成功"];
    }
    
    return _titleLabel;
}

/*
 * creat tipLabel
 */
- (UILabel *)tipLabel{
    
    if (!_tipLabel) {
        _tipLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainGray_one textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"审核结果我们将在3个工作日内短信通知您"];
    }
    
    return _tipLabel;
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
