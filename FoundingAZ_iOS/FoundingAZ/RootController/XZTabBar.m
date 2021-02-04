//
//  XZTabBar.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "XZTabBar.h"
#import "XZTabBarItem.h"

@interface XZTabBar ()

@property (nonatomic, strong) NSArray *tabItemArray;
@property (nonatomic, strong) NSMutableArray *tabBtnArray;

@end

@implementation XZTabBar

- (NSMutableArray *)tabBtnArray{
    
    if (!_tabBtnArray) {
        _tabBtnArray = [NSMutableArray array];
    }
    return _tabBtnArray;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self setClipsToBounds:NO];
    }
    return self;
}

- (void)setItems:(NSArray<UITabBarItem *> *)items{
    
    self.tabItemArray = items;
    
    [self.tabBtnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tabBtnArray removeAllObjects];
    
    CGFloat w = CGRectGetWidth(self.bounds)/items.count;
    for (UITabBarItem * item in items) {
        
        NSInteger index = [items indexOfObject:item];
        
        XZTabBarItem * barItem = [[XZTabBarItem alloc] init];
        barItem.frame = CGRectMake(index * w, 0, w, CGRectGetHeight(self.bounds));
        barItem.titleLabel.text = item.title;
        barItem.barViewBtn.tag = index;
        [barItem.barViewBtn addTarget:self action:@selector(tabbarClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:barItem];
        
        [self.tabBtnArray addObject:barItem];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
        
    int index = 0;
    for (XZTabBarItem * barItem in self.tabBtnArray) {
        
        UITabBarItem * item = [self.tabItemArray objectAtIndex:index];
        
        if (index == selectedIndex) {
            barItem.titleLabel.textColor = rgba(242, 90, 0, 1);
            [barItem.iconImage setImage:item.selectedImage forState:UIControlStateNormal];
        }else{
            barItem.titleLabel.textColor = rgba(204, 204, 204, 1);
            [barItem.iconImage setImage:item.image forState:UIControlStateNormal];
        }
        index ++;
    }
}

#pragma mark tabbar按钮的点击事件
- (void)tabbarClick:(UIButton *)btn{
    
    if (self.tabDelegate && [self.tabDelegate respondsToSelector:@selector(tabBarDidClickButton:)]) {
        [self.tabDelegate tabBarDidClickButton:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
