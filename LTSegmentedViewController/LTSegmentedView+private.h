//
//  LTSegmentedView+private.h
//  LTSegmentedViewController
//
//  Created by LYP on 15/10/23.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedView.h"

@interface LTSegmentedView (private)
- (LTSegmentedItem*) selectedItem;
- (CGFloat) itemWidth;
- (NSInteger) minimumIndex;
- (NSInteger) maximumIndex;
- (NSInteger) validIndexAt:(NSInteger) index;
- (NSInteger) isValidIndex:(NSInteger) index;
- (NSInteger) frontIndex:(NSInteger) theIndex another:(NSInteger) otherIndex;
- (CGFloat) minimunOffset;
- (CGFloat) maximumOffset;
- (CGFloat) validOffsetAt:(CGFloat) offSet;
@end
