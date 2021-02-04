//
//  CourseListVC.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "BaseTableController.h"
#import "CourseListCell.h"
#import "CourseListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CourseListVC : BaseTableController
@property (nonatomic, copy) void(^listScrollViewDidScroll)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
