//
//  LTSegmentedViewProtocol.h
//  LTSegmentedViewController
//
//  Created by LIYINGPENG on 15/10/10.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LTSegmentedViewProtocol <NSObject>
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView didSelectedItemAtIndex:(NSInteger) index;
- (void) segmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView willScrollToItemAtIndex:(NSInteger) index percent:(CGFloat) percent;
@end
