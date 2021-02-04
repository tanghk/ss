//
//  SetNewPassVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "SetNewPassVC.h"
#import "SetNewPassCell.h"
#import "SetNewPassModel.h"
#import "LoginPassVC.h"
#import "BaseNavigationController.h"

#define ConTextFieldTag       2000

static NSString *SetNewPassCell_ID = @"setNewPassCell_ID";

@interface SetNewPassVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;
@property (nonatomic, strong) UITextField *tempField;

@property (nonatomic, strong) NSString *passStr;//输入的密码

@end

@implementation SetNewPassVC

- (void)initWithData{
    
    self.passStr = @"";
    
    self.dataArray = [SetNewPassModel getWithSetNewPassViewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark 清除按钮点击事件
- (void)clearBtnClick:(UIButton *)btn{
    
    if (btn.tag - ConTextFieldTag == 0) {
        self.passStr = @"";
    }
    [self reloadWithCellDataIndex];
}

#pragma mark 完成按钮点击事件
- (void)nextBtnClick{
    
    if (self.nextBtn.hidden) {
        return;
    }
    
    NSString *msgString = @"\n您已修改密码成功，请重新登录";
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"设置成功" message:msgString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetLoginBtnClick];
    }];
    
    // 修改message字体及颜色
    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc] initWithString:msgString];
    [messageStr addAttribute:NSFontAttributeName value:[UIFont M_PingFang_RegularOfSize:Font_14] range:NSMakeRange(0, messageStr.length)];
    [messageStr addAttribute:NSForegroundColorAttributeName value:Color_MainGray range:NSMakeRange(0, messageStr.length)];
    [alertVC setValue:messageStr forKey:@"attributedMessage"];
    
    [sureAction setValue:Color_MainBlue forKey:@"titleTextColor"];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark 重新登录按钮点击事件
- (void)resetLoginBtnClick{
    
    //登录页面忘记密码入口
    for (UIViewController *ctrl in self.navigationController.viewControllers) {
        if ([ctrl isKindOfClass:[LoginPassVC class]]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            return;;
        }
    }
    
    //设置页面修改密码入口
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_Login_name object:self.phoneStr];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.tempField = textField;
    return YES;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag - ConTextFieldTag == 0) {
        if (textField.text.length >= 16 ) {//输入完成
            textField.text = [textField.text substringToIndex:16];
        }
        self.passStr = textField.text;
    }else{
        //不做处理
    }
    
    [self reloadWithCellDataIndex];
}

#pragma mark 刷新cell的显示
- (void)reloadWithCellDataIndex{
    
    BOOL passState = NO;
    
    for (SetNewPassModel *model in self.dataArray) {
        if (model.setNewPassType == SetNewPassType_new) {
            model.conStr = self.passStr;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            SetNewPassCell *cell = (SetNewPassCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configureCellWithModel:model];
            
            if (self.passStr.length >= 1) {
                passState = YES;
            }else{
                passState = NO;
            }
        }
    }
    
    if (passState) {
        self.nextBtn.hidden = NO;
        self.nextUnBtn.hidden = YES;
    }else{
        self.nextBtn.hidden = YES;
        self.nextUnBtn.hidden = NO;
    }
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:[SetNewPassCell class] forCellReuseIdentifier:SetNewPassCell_ID];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetNewPassModel *model = [self.dataArray safeObjectIndex:indexPath.row];
    
    SetNewPassCell *cell = [tableView dequeueReusableCellWithIdentifier:SetNewPassCell_ID forIndexPath:indexPath];
    
    cell.phoneField.tag = indexPath.row + ConTextFieldTag;
    cell.phoneField.delegate = self;
    [cell.phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    cell.clearBtn.tag = indexPath.row + ConTextFieldTag;
    [cell.clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell configureCellWithModel:model];
    
    return cell;
}

/*
 * creat headView
 */
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 8+33+8)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(25, 8, 150, 33) font:[UIFont M_PingFang_MediumOfSize:Font_24] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"设置新密码"];
        [_headView addSubview:titleLabel];
    }
    
    return _headView;
}

/*
 * creat footView
 */
- (UIView *)footView{
    
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 27+52)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        //
        UIButton *nextBtn = [UIButton createButtonWithFrame:CGRectMake(24, 27, kScreen_Width-2*24, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainBlue title:@"完成"];
        ViewShadow(nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        nextBtn.layer.cornerRadius = 8.0;
        [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.hidden = YES;
        [_footView addSubview:nextBtn];
        self.nextBtn = nextBtn;
        
        NSArray *colorArray = @[(id)[HEXACOLOR(0x36A8FF, 1.0) CGColor],
                                (id)[HEXACOLOR(0x2A71FF, 1.0) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:8.0];
        [nextBtn.layer addSublayer:nextBtnLayer];
        [nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
        
        //
        UIButton *nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(24, 27, kScreen_Width-2*24, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainGray_one title:@"完成"];
        ViewRadius(nextUnBtn, 8.0);
        [nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextUnBtn.hidden = NO;
        [_footView addSubview:nextUnBtn];
        self.nextUnBtn = nextUnBtn;
    }
    
    return _footView;
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
