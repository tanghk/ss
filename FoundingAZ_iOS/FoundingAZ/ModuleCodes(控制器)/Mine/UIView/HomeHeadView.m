//
//  HomeHeadView.m
//  FoundingAZ
//
//  Created by mark on 2021/1/27.
//

#import "HomeHeadView.h"
#import "HomeItemsView.h"
@interface HomeHeadView (){
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
}

@property (nonatomic, strong) SDCycleScrollView *customCellScrollViewDemo;
@property (nonatomic, strong) HomeItemsView *homeItemsView;

@end
@implementation HomeHeadView

- (void)configSubView{
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
        @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
        @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
        @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
    ];
    _imagesURLStrings = imagesURLStrings;
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"disableScrollGesture可以设置禁止拖动",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
    ];
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.frame];
    demoContainerView.frame = CGRectMake(0, 0, kScreen_Width, 180);
    demoContainerView.contentSize = CGSizeMake(self.frame.size.width, 180);
    [self addSubview:demoContainerView];
    

    CGFloat w = self.bounds.size.width;
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    [demoContainerView addSubview:cycleScrollView3];
    
   
    HomeItemsView *homeItemsView = [[HomeItemsView alloc] initWithFrame:CGRectZero];
    [self addSubview:homeItemsView];
    self.homeItemsView = homeItemsView;
}

- (void)layout{
    
 
    
    [self.homeItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(97);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)configureViewWithModel:(id)contentModel{
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
