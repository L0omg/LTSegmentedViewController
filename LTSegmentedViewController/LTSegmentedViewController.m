//
//  LTSegmentedViewController.m
//  LTSegmentedViewController
//
//  Created by LIYINGPENG on 15/10/10.
//  Copyright © 2015年 LYP. All rights reserved.
//

#import "LTSegmentedViewController.h"
#import "LTPageViewController.h"
#import "NSLayoutConstraint+ActiveConstraint.h"

static const CGFloat LTSegmentedViewControllerSegmentedViewHeight = 44.f;

@interface LTSegmentedViewController ()<LTPageViewControllerDataSource, LTPageViewControllerDelegate>
@property (nonatomic, strong) LTPageViewController *pageViewController;
@property (nonatomic, strong) UIView<LTSegmentedViewProtocol>* segmentedView;
@property (nonatomic, strong) NSLayoutConstraint *segmentedViewHeightConstraint;
@end

@implementation LTSegmentedViewController
#pragma mark -Life Cycle
- (instancetype) initWithSegmentedView:(UIView<LTSegmentedViewProtocol>*) segmentedView dataSource:(id<LTSegmentedViewControllerDataSource>) dataSource{
    
    if (!dataSource) {
        
        return nil;
    }
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        _segmentedView = segmentedView;
        _dataSource = dataSource;
        _segmentViewHeight = LTSegmentedViewControllerSegmentedViewHeight;
        _embedSegmentedView = YES;
    }
    return self;
}

- (instancetype) initWithDataSource:(id<LTSegmentedViewControllerDataSource>)dataSource{
    
    return [self initWithSegmentedView:nil dataSource:dataSource];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    
    return [super initWithCoder:aDecoder];
}

#pragma mark -View LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) makeLayout{
    
    UIView *segmentView = self.segmentedView;
    UIView *pageView = self.pageViewController.view;
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *v_VFL = @"[pageView]|";
    NSDictionary *dicView = nil;
    if (segmentView && self.isEmbedSegmentedView) {
        
        segmentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:segmentView];
        NSLayoutConstraint *heightSegmentedViewConstraint = [NSLayoutConstraint constraintWithItem:segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:self.segmentViewHeight];
        [heightSegmentedViewConstraint fm_ActiveToView:self.view];
        self.segmentedViewHeightConstraint = heightSegmentedViewConstraint;
        
        v_VFL = [NSString stringWithFormat:@"V:|[segmentView]%@", v_VFL];
        dicView = NSDictionaryOfVariableBindings(segmentView, pageView);
    }else{
        
        v_VFL = [NSString stringWithFormat:@"V:|%@", v_VFL];
        dicView = NSDictionaryOfVariableBindings(pageView);
    }
    
    NSArray *v_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:v_VFL options:(NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing) metrics:nil views:dicView];
    NSArray *h_Constarints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageView)];
    [NSLayoutConstraint fm_ActiveConstraints:v_Constraints toView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:h_Constarints toView:self.view];
}

#pragma mark -Public Methods
/**
 *  跳转至指定页
 *
 *  @param pageIndex pageIndex
 */
- (void) jumpToPage:(NSInteger) pageIndex{
    
    [self.pageViewController jumpToPage:pageIndex];
}

#pragma mark -Protocol
#pragma mark LTPageViewControllerDataSource<NSObject>
- (UIViewController*) pageViewController:(LTPageViewController*) pageViewController viewControllerAtIndex:(NSInteger) index{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentedViewController:viewControllerAtIndex:)]) {
        
        return [self.dataSource segmentedViewController:self viewControllerAtIndex:index];
    }
    return nil;
}

- (NSInteger) pageViewController:(LTPageViewController*) pageViewController indexAtViewController:(UIViewController*) viewController{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentedViewController:indexAtViewController:)]) {
        
        return [self.dataSource segmentedViewController:self indexAtViewController:viewController];
    }
    return 0;
}
#pragma mark LTPageViewControllerDelegate <NSObject>
- (void) pageViewController:(LTPageViewController *)pageViewController willTransitionToViewControllers:(NSArray/*<UIViewController *>*/ *)pendingViewControllers{
    
}

- (void) pageViewController:(LTPageViewController*) pageViewController didTransitionToViewController:(UIViewController*) viewController{
    
    NSInteger index = [self.dataSource segmentedViewController:self indexAtViewController:viewController];
    
    if (self.segmentedView && [self.segmentedView respondsToSelector:@selector(segmentedView:didSelectedItemAtIndex:)]) {
        
        [self.segmentedView segmentedView:self.segmentedView didSelectedItemAtIndex:index];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedViewController:didTransitionToViewController:)]) {
        
        [self.delegate segmentedViewController:self didTransitionToViewController:viewController];
    }
}

- (void) pageViewController:(LTPageViewController*) pageViewController currentIndex:(NSInteger) currentIndex scrollDirection:(LTPageViewControllerScrollDirection) direction didScrollToPercent:(CGFloat)percent{
    
    if (self.segmentedView && [self.segmentedView respondsToSelector:@selector(segmentedView:willScrollToItemAtIndex:percent:)]) {
        
        NSInteger index = currentIndex + (direction == LTPageViewControllerScrollDirectionLeft ? -1 : 1);
        [self.segmentedView segmentedView:self.segmentedView willScrollToItemAtIndex:index percent:percent];
    }
}

#pragma mark -Accessor
- (LTPageViewController*) pageViewController{
    
    if (!_pageViewController) {
        
        _pageViewController = [[LTPageViewController alloc] init];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self willMoveToParentViewController:_pageViewController];
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
}

- (void) setSegmentViewHeight:(CGFloat)segmentViewHeight{
    
    if (self.segmentedViewHeightConstraint) {
        
        self.segmentedViewHeightConstraint.constant = segmentViewHeight;
    }
    _segmentViewHeight = segmentViewHeight;
}
@end
