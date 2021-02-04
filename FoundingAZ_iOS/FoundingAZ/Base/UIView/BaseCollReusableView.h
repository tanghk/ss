//
//  BaseCollReusableView.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollReusableView : UICollectionReusableView

#pragma mark 添加子视图
- (void)configSubView;

#pragma mark 布局子视图
- (void)layout;

- (void)configureCellWithModel:(id)tempModel;

@end

NS_ASSUME_NONNULL_END
