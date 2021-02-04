//
//  BaseView.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

- (void)initWithData;

//添加子视图
- (void)configSubView;

//布局子视图
- (void)layout;

//赋值
- (void)configureViewWithModel:(id)contentModel;

@end

NS_ASSUME_NONNULL_END
