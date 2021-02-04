//
//  SettingVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "SettingModel.h"
#import "VerfiyPhoneVC.h"

static NSString *SettingCell_ID = @"settingCell_ID";

@interface SettingVC ()

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [SettingModel getWithSettingViewData];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

#pragma mark 退出登录按钮点击事件
- (void)logOutBtnClick{
    
    [MBProgressHUD showMessageInWindow:@"退出登录"];
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"设置" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight);
    
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:SettingCell_ID];
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCell_ID forIndexPath:indexPath];
    
    [cell configureCellWithModel:[self.dataArray safeObjectIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingModel *model = [self.dataArray safeObjectIndex:indexPath.row];
    
    if (model.settingViewType == SettingViewType_modify) {
        dispatch_async(dispatch_get_main_queue(), ^{
            VerfiyPhoneVC *vc = [[VerfiyPhoneVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
}

/*
 * creat headView
 */
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 12)];
        _headView.backgroundColor = Color_MainGroud;
    }
    
    return _headView;
}

/*
 * creat footView
 */
- (UIView *)footView{
    
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 136+56)];
        _footView.backgroundColor = Color_MainGroud;
        
        UIButton *logOutBtn = [UIButton createButtonWithFrame:CGRectMake(0, 136, kScreen_Width, 56) titleColor:Color_MainRed font:[UIFont M_PingFang_RegularOfSize:Font_16] backgroundColor:[UIColor whiteColor] title:@"退出登录"];
        [logOutBtn addTarget:self action:@selector(logOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:logOutBtn];
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
