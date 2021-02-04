//
//  ConnectUsCell.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "BaseTableCell.h"
@class ConnectUsModel;

NS_ASSUME_NONNULL_BEGIN

@interface ConnectUsCell : BaseTableCell

- (void)configureCellWithModel:(ConnectUsModel *)contentModel withIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array;
@end
NS_ASSUME_NONNULL_END
