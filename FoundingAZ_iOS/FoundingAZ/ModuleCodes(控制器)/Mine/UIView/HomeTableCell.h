//
//  HomeTableCell.h
//  FoundingAZ
//
//  Created by mark on 2021/1/28.
//

#import "BaseTableCell.h"
@class HomeModel;
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableCell : BaseTableCell
- (void)configureCellWithModel:(HomeModel *)contentModel withIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
