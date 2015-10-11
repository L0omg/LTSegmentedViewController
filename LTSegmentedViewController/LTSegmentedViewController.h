//
//  LTSegmentedViewController.h
//  LTSegmentedViewController
//
//  Created by LIYINGPENG on 15/10/10.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSegmentedViewProtocol.h"

@class LTSegmentedViewController;
@protocol LTSegmentedViewControllerDataSource <NSObject>

- (UIViewController*) segmentedViewController:(LTSegmentedViewController*) segmentedViewController viewControllerAtIndex:(NSInteger) index;
- (NSInteger) segmentedViewController:(LTSegmentedViewController*) segmentedViewController indexAtViewController:(UIViewController*) viewController;

@end

@interface LTSegmentedViewController : UIViewController
@property (nonatomic, assign) CGFloat segmentViewHeight;/**< default 44.f*/
@property (nonatomic, weak) id<LTSegmentedViewControllerDataSource> dataSource;

/**
 *  dataSource不为nil
 */
- (instancetype) initWithSegmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView dataSource:(id<LTSegmentedViewControllerDataSource>) dataSource NS_DESIGNATED_INITIALIZER;
- (instancetype) initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
/**
 *  dataSource不为nil
 */
- (instancetype) initWithDataSource:(id<LTSegmentedViewControllerDataSource>) dataSource;

- (instancetype) init  __attribute__((unavailable("Invoke the designated initalizer")));
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil __attribute__((unavailable("Invoke the designated initalizer")));
@end
