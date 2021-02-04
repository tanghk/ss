//
//  CourseListVC.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "CourseListVC.h"
static NSString *CourseListTableCell_ID = @"courseListTableCell_ID";

@interface CourseListVC ()

@end

@implementation CourseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *titleOneArr = @[@"培训服务",@"大课交付",@"咨询服务"];
    self.dataArray =[NSMutableArray arrayWithArray:titleOneArr];
    [self.tableView reloadData];
    
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = CGRectMake(0, 0, kScreen_Width, kScreen_Height-kTabBarHeight-kTopHeight-40);
    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CourseListCell class] forCellReuseIdentifier:CourseListTableCell_ID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //  NSArray *arr = [self.dataArray safeObjectIndex:section];
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40.0)];
    sectionHeadView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-2*20, CGRectGetHeight(sectionHeadView.bounds))];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeadView addSubview:titleLabel];
    
    [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    titleLabel.text =self.dataArray[section];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20);
        make.centerY.equalTo(sectionHeadView.mas_centerY);
        make.height.mas_equalTo(40);
        
    }];
    
    
    UILabel*mustLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-2*20, CGRectGetHeight(sectionHeadView.bounds))];
    
    mustLabel.font = [UIFont systemFontOfSize:13];
    mustLabel.textAlignment = NSTextAlignmentLeft;
    [sectionHeadView addSubview:mustLabel];
    mustLabel.textColor  =  Color_MainBlack;
    [mustLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [mustLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(titleLabel.mas_right).offset(5);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.height.mas_equalTo(40);
        
    }];
    
    return sectionHeadView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = [self.dataArray safeObjectIndex:indexPath.section];
//    HomeModel *model = [arr safeObjectIndex:indexPath.row];
    
    CourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseListTableCell_ID forIndexPath:indexPath];
    
    //   [cell configureCellWithModel:model withIndexPath:indexPath withArray:arr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CourseDetailVC *detail =[CourseDetailVC new];
    [self.navigationController pushViewController:detail animated:YES];
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
