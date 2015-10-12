//
//  ViewController.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/13.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import "ViewController.h"
#import "LTUnderLineSegmentedView.h"
#import "LTWYSegmentedView.h"
#import "LTCoverSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "ContentViewController.h"
#import "LTSegmentedViewController.h"
@interface ViewController ()<LTSegmentedViewControllerDataSource>
@property (nonatomic, strong) ContentViewController *firstViewController;
@property (nonatomic, strong) ContentViewController *secondViewController;
@property (nonatomic, strong) ContentViewController *thirdViewController;
@property (nonatomic, strong) ContentViewController *fourthViewController;
@property (nonatomic, strong) ContentViewController *fifthViewController;
@property (nonatomic, strong) LTSegmentedViewController *segmentedViewController;
@property (nonatomic, strong) LTSegmentedView *segmentedView;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) BOOL animation;

@end

@implementation ViewController

- (void) loadView{
    
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.viewControllers = @[self.firstViewController, self.secondViewController, self.thirdViewController, self.fourthViewController, self.fifthViewController];
    
    UIView *pageView = self.segmentedViewController.view;
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *v_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageView)];
    NSArray *h_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pageView)];
    [NSLayoutConstraint fm_ActiveConstraints:v_Constraints toView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:h_Constraints toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Protocol
#pragma mark LTSegmentedViewControllerDataSource <NSObject>
- (UIViewController*) segmentedViewController:(LTSegmentedViewController*) segmentedViewController viewControllerAtIndex:(NSInteger) index{
    
    if (index < self.viewControllers.count) {
        
        return self.viewControllers[index];
    }
    
    return nil;
}

- (NSInteger) segmentedViewController:(LTSegmentedViewController*) segmentedViewController indexAtViewController:(UIViewController*) viewController{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        
        index = 0;
    }
    
    return index;
}
#pragma mark -Accessor
- (LTSegmentedViewController*) segmentedViewController{
    
    if (!_segmentedViewController) {
        
        _segmentedViewController = [[LTSegmentedViewController alloc] initWithSegmentedView:self.segmentedView dataSource:self];
        _segmentedViewController.embedSegmentedView = YES;
        [self willMoveToParentViewController:_segmentedViewController];
        [self addChildViewController:_segmentedViewController];
        [self.view addSubview:_segmentedViewController.view];
    }
    
    return _segmentedViewController;
}

- (LTSegmentedView*) segmentedView{
    
    if (!_segmentedView) {
        
        __weak typeof(self) weakSelf = self;
        LTSegmentedItem *item1 = [[LTSegmentedItem alloc] initWithTitle:self.firstViewController.title action:^(LTSegmentedItem *item) {
            NSLog(@"%@", item.titleLabel.text);
            [weakSelf.segmentedViewController jumpToPage:0];
        }];
        LTSegmentedItem *item2 = [[LTSegmentedItem alloc] initWithTitle:self.secondViewController.title action:^(LTSegmentedItem *item) {
            NSLog(@"%@", item.titleLabel.text);
            [weakSelf.segmentedViewController jumpToPage:1];
        }];
        [item2.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 10 forAxis:UILayoutConstraintAxisHorizontal];
        
        LTSegmentedItem *item3 = [[LTSegmentedItem alloc] initWithTitle:self.thirdViewController.title action:^(LTSegmentedItem *item) {
            NSLog(@"%@", item.titleLabel.text);
            [weakSelf.segmentedViewController jumpToPage:2];
        }];
        [item3.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 11 forAxis:UILayoutConstraintAxisHorizontal];
        
        LTSegmentedItem *item4 = [[LTSegmentedItem alloc] initWithTitle:self.fourthViewController.title action:^(LTSegmentedItem *item) {
            NSLog(@"%@", item.titleLabel.text);
            [weakSelf.segmentedViewController jumpToPage:3];
        }];
        [item4.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 12 forAxis:UILayoutConstraintAxisHorizontal];
        
        LTSegmentedItem *item5 = [[LTSegmentedItem alloc] initWithTitle:self.fifthViewController.title action:^(LTSegmentedItem *item) {
            NSLog(@"%@", item.titleLabel.text);
            [weakSelf.segmentedViewController jumpToPage:4];
        }];
        [item5.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 13 forAxis:UILayoutConstraintAxisHorizontal];
        
        
        LTSegmentedView *segmentedView = [[NSClassFromString(self.segmentViewClassName) alloc] initWithItems:@[ item1, item2, item3, item4, item5]];
        segmentedView.contentView.backgroundColor = [UIColor redColor];
        _segmentedView = segmentedView;
    }
    
    return _segmentedView;
}

- (ContentViewController*) firstViewController{
    
    if (!_firstViewController) {
        
        _firstViewController = [[ContentViewController alloc] init];
        _firstViewController.title = @"First";
    }
    
    return _firstViewController;
}

- (ContentViewController*) secondViewController{
    
    if (!_secondViewController) {
        
        _secondViewController = [[ContentViewController alloc] init];
        _secondViewController.title = @"Second";
    }
    
    return _secondViewController;
}

- (ContentViewController*) thirdViewController{
    
    if (!_thirdViewController) {
        
        _thirdViewController = [[ContentViewController alloc] init];
        _thirdViewController.title = @"Third";
    }
    
    return _thirdViewController;
}

- (ContentViewController*) fourthViewController{
    
    if (!_fourthViewController) {
        
        _fourthViewController = [[ContentViewController alloc] init];
        _fourthViewController.title = @"Fourth";
    }
    
    return _fourthViewController;
}

- (ContentViewController*) fifthViewController{
    
    if (!_fifthViewController) {
        
        _fifthViewController = [[ContentViewController alloc] init];
        _fifthViewController.title = @"Fifth";
    }
    
    return _fifthViewController;
}
@end
