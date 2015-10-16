//
//  LTPageViewController.m
//  FormaxCopyMaster
//
//  Created by LIYINGPENG on 15/9/14.
//  Copyright (c) 2015年 Formax. All rights reserved.
//

#import "LTPageViewController.h"

void *LTPageViewControllerContentScrollViewContentOffsetKVOContext = &LTPageViewControllerContentScrollViewContentOffsetKVOContext;
static NSString *const LTPageViewControllerContentScrollViewContentOffsetKVOKeyPath = @"contentOffset";

@interface LTPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, weak) UIViewController *currentViewController;
@end

@implementation LTPageViewController

#pragma mark -LifeCycle
- (void) dealloc{
    
    UIScrollView *view = [self pageViewControllerContentScrollView];
    if (view) {
        
        [view removeObserver:self forKeyPath:LTPageViewControllerContentScrollViewContentOffsetKVOKeyPath context:LTPageViewControllerContentScrollViewContentOffsetKVOContext];
    }
}

#pragma mark -View LifeCycle
- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    if (self.dataSource) {
        
        UIViewController *viewController = [self.dataSource pageViewController:self viewControllerAtIndex:0];
        if (viewController) {
            
            [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
            [self.pageViewController willMoveToParentViewController:self];
            [self addChildViewController:self.pageViewController];
            [self.view addSubview:self.pageViewController.view];
            
            self.currentViewController = viewController;
            UIScrollView *view = [self pageViewControllerContentScrollView];
            if (view) {
                
                [view addObserver:self forKeyPath:LTPageViewControllerContentScrollViewContentOffsetKVOKeyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:LTPageViewControllerContentScrollViewContentOffsetKVOContext];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didTransitionToViewController:)]) {
                
                [self.delegate pageViewController:self didTransitionToViewController:viewController];
            }
        }
    }
}

#pragma mark -KVO
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (context == LTPageViewControllerContentScrollViewContentOffsetKVOContext) {
        
        if ([keyPath isEqualToString:LTPageViewControllerContentScrollViewContentOffsetKVOKeyPath]) {
            
            UIScrollView *scrollView = [self pageViewControllerContentScrollView];
            if (scrollView.contentSize.width > scrollView.frame.size.width) {
                
                CGFloat sWidth = CGRectGetWidth(scrollView.frame);
                if (ABS(scrollView.contentOffset.x - sWidth) > 0.000001) {
                    
                    NSInteger curIndex = [self.dataSource pageViewController:self indexAtViewController:self.currentViewController];
                    CGFloat percent = fmodf(scrollView.contentOffset.x, sWidth) / sWidth;
                    LTPageViewControllerScrollDirection direction = LTPageViewControllerScrollDirectionLeft;
                    if (scrollView.contentOffset.x > sWidth) {//由于UIPageViewController采用了重用机制，contentScrollView只会有3页
                        
                        direction = LTPageViewControllerScrollDirectionRight;
                    }
                    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:currentIndex:scrollDirection:didScrollToPercent:)]) {
                        
                        [self.delegate pageViewController:self currentIndex:curIndex scrollDirection:direction didScrollToPercent:percent];
                    }
                }
            }
        }
    }
}

#pragma mark -Public Methods
- (void) jumpToPage:(NSInteger) pageIndex{
    
    //获取滑动方向
    NSInteger curIndex = [self.dataSource pageViewController:self indexAtViewController:[self.pageViewController.viewControllers firstObject]];
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (curIndex > pageIndex) {
        
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else if (curIndex < pageIndex){
        
        direction = UIPageViewControllerNavigationDirectionForward;
    }else{
        
        return;
    }
    
    //获取将要显示的VC
    UIViewController *viewController = [self.dataSource pageViewController:self viewControllerAtIndex:pageIndex];
    if (viewController) {
        
        self.currentViewController = viewController;
        __weak typeof(self) weakSelf = self;
        __weak typeof(viewController) weakViewController = viewController;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finish){
            //TODO 解决当跳跃切换时，比较直接从pageIndex=0跳转到pageindex=5，然后左右滑动时只会显示0和5对应的两个页面。(参考链接: http://www.cnblogs.com/firefff/p/3955370.html?utm_source=tuicool&utm_medium=referral)
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (finish && weakViewController) {
                    
                    [weakSelf.pageViewController setViewControllers:@[weakViewController] direction:direction animated:NO completion:NULL];
                }
            });
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didTransitionToViewController:)]) {
            
            [self.delegate pageViewController:self didTransitionToViewController:viewController];
        }
    }
}

#pragma mark -Private methods
- (UIScrollView*) pageViewControllerContentScrollView{
    
    UIView *view = self.pageViewController.view;
    return [self getContentScrollViewInView:view];
}

- (UIScrollView*) getContentScrollViewInView:(UIView*) view{
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        return (UIScrollView*)view;
    }else{
        
        for (UIView *subview in view.subviews){
            
            UIView *tmpView = [self getContentScrollViewInView:subview];
            if (tmpView) {
                
                return (UIScrollView*)tmpView;
            }
        }
        
        return nil;
    }
}

#pragma mark -Delegate
#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger curIndex = [self.dataSource pageViewController:self indexAtViewController:viewController];
    if (curIndex <= 0) {
        
        return nil;
    }
    curIndex--;
    
    return [self.dataSource pageViewController:self viewControllerAtIndex:curIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger curIndex = [self.dataSource pageViewController:self indexAtViewController:viewController];
    curIndex ++;
    
    return [self.dataSource pageViewController:self viewControllerAtIndex:curIndex];
}

#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
        
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:willTransitionToViewControllers:)]) {
        
        [self.delegate pageViewController:self willTransitionToViewControllers:pendingViewControllers];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    self.currentViewController = [self.pageViewController.viewControllers lastObject];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didTransitionToViewController:)]) {
        
        [self.delegate pageViewController:self didTransitionToViewController:self.currentViewController];
    }
}

#pragma mark -Accessor
- (UIPageViewController*) pageViewController{
    
    if (!_pageViewController) {
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.backgroundColor = [UIColor clearColor];
    }
    
    return _pageViewController;
}
@end
