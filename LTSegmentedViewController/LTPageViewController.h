//
//  LTPageViewController.h
//  FormaxCopyMaster
//
//  Created by LIYINGPENG on 15/9/14.
//  Copyright (c) 2015年 Formax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LTPageViewControllerScrollDirection) {
    LTPageViewControllerScrollDirectionLeft,
    LTPageViewControllerScrollDirectionRight,
};

@class LTPageViewController;
@protocol  LTPageViewControllerDataSource<NSObject>

@required
- (UIViewController*) pageViewController:(LTPageViewController*) pageViewController viewControllerAtIndex:(NSInteger) index;
- (NSInteger) pageViewController:(LTPageViewController*) pageViewController indexAtViewController:(UIViewController*) viewController;
@end

@protocol LTPageViewControllerDelegate <NSObject>

@optional
- (void) pageViewController:(LTPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers;
- (void) pageViewController:(LTPageViewController*) pageViewController didTransitionToViewController:(UIViewController*) viewController;
- (void) pageViewController:(LTPageViewController*) pageViewController currentIndex:(NSInteger) currentIndex scrollDirection:(LTPageViewControllerScrollDirection) direction didScrollToPercent:(CGFloat) percent;
@end

@interface LTPageViewController : UIViewController
@property (nonatomic, weak) id<LTPageViewControllerDataSource> dataSource; /**< dataSource*/
@property (nonatomic, weak) id<LTPageViewControllerDelegate> delegate; /**< delegate*/
/**
 *  跳转至指定页
 *
 *  @param pageIndex pageIndex
 */
- (void) jumpToPage:(NSInteger) pageIndex;
@end
