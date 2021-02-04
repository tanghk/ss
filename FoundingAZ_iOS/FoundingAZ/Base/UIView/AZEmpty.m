//
//  AZEmpty.m
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import "AZEmpty.h"

@implementation AZEmpty

+ (instancetype)diyNoDataEmpty{
    return [AZEmpty emptyViewWithImageStr:@"NoData"
                                 titleStr:@"当前网络不可用，请检查网络设置"
                                detailStr:@"点击重试"];
}
+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action{
 
    AZEmpty *emptyView = [AZEmpty emptyActionViewWithImageStr:@"NoData"
                                               titleStr:@"当前网络不可用，请检查网络设置"
                                              detailStr:@""
                                            btnTitleStr:@"重新加载"
                                                 target:target
                                                   action:action];
  //  diy.autoShowEmptyView = NO;
    emptyView.subViewMargin = 0;
//    emptyView.contentViewOffset = - 50;
    
    emptyView.titleLabFont = [UIFont systemFontOfSize:14.f];
    emptyView.titleLabTextColor = rgba(153, 153, 153, 1);
    emptyView.titleLabMargin =-10.f;
    emptyView.actionBtnFont = [UIFont boldSystemFontOfSize:13.f];
    emptyView.actionBtnTitleColor = rgba(229, 187, 159, 1);
    emptyView.actionBtnWidth = 80.f;
    emptyView.actionBtnHeight = 28.f;
    emptyView.actionBtnHorizontalMargin = 30.f;
    emptyView.actionBtnCornerRadius = 2.f;
    emptyView.actionBtnBorderColor = rgba(229, 187, 159, 1);
    emptyView.actionBtnBorderWidth = 0.5;
    emptyView.actionBtnBackGroundColor = Color_Whitle;
   //diy.imageSize = CGSizeMake(150, 150);
    
    return emptyView;
}

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action{
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"暂无数据，请稍后再试！";
    [customView addSubview:titleLab];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 80, 30)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"重试" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"加载" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:15];
    [button2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:button2];
    
    AZEmpty *diy = [AZEmpty emptyViewWithCustomView:customView];
    return diy;
}

- (void)prepare{
    [super prepare];
    
    self.subViewMargin = 20.f;
    
    self.titleLabFont = [UIFont systemFontOfSize:25];
    self.titleLabTextColor = MainColor(90, 180, 160);
    
    self.detailLabFont = [UIFont systemFontOfSize:17];
    self.detailLabTextColor = MainColor(180, 120, 90);
    self.detailLabMaxLines = 5;
    
    self.actionBtnBackGroundColor = MainColor(90, 180, 160);
    self.actionBtnTitleColor = [UIColor whiteColor];
}
@end
