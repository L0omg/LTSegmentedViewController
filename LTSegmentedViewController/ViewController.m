//
//  ViewController.m
//  LTSegmentedViewController
//
//  Created by LYP on 15/9/13.
//  Copyright (c) 2015年 LYP. All rights reserved.
//

#import "ViewController.h"
#import "LTSegmentedView.h"
#import "NSLayoutConstraint+ActiveConstraint.h"
#import "ContentViewController.h"
@interface ViewController ()
@property (nonatomic, strong) ContentViewController *firstViewController;
@property (nonatomic, strong) ContentViewController *secondViewController;
@property (nonatomic, strong) ContentViewController *thirdViewController;
@property (nonatomic, strong) ContentViewController *fourthViewController;
@property (nonatomic, strong) ContentViewController *fifthViewController;
@property (nonatomic, strong) LTSegmentedView *segmentedView;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) BOOL animation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.viewControllers = @[self.firstViewController, self.secondViewController, self.thirdViewController, self.fourthViewController, self.fifthViewController];
    
    __weak typeof(self) weakSelf = self;
    LTSegmentedItem *item1 = [[LTSegmentedItem alloc] initWithTitle:self.firstViewController.title action:^(LTSegmentedItem *item) {
        weakSelf.firstViewController.view.backgroundColor = [UIColor redColor];
        NSLog(@"%@", item.titleLabel.text);
        [weakSelf.pageViewController jumpToPage:0];
    }];
    LTSegmentedItem *item2 = [[LTSegmentedItem alloc] initWithTitle:self.secondViewController.title action:^(LTSegmentedItem *item) {
        weakSelf.secondViewController.view.backgroundColor = [UIColor greenColor];
        NSLog(@"%@", item.titleLabel.text);
        [weakSelf.pageViewController jumpToPage:1];
    }];
    [item2.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 10 forAxis:UILayoutConstraintAxisHorizontal];

    LTSegmentedItem *item3 = [[LTSegmentedItem alloc] initWithTitle:self.thirdViewController.title action:^(LTSegmentedItem *item) {
        weakSelf.thirdViewController.view.backgroundColor = [UIColor blueColor];
        NSLog(@"%@", item.titleLabel.text);
        [weakSelf.pageViewController jumpToPage:2];
    }];
    [item3.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 11 forAxis:UILayoutConstraintAxisHorizontal];
    
    LTSegmentedItem *item4 = [[LTSegmentedItem alloc] initWithTitle:self.fourthViewController.title action:^(LTSegmentedItem *item) {
        weakSelf.fourthViewController.view.backgroundColor = [UIColor grayColor];
        NSLog(@"%@", item.titleLabel.text);
        [weakSelf.pageViewController jumpToPage:3];
    }];
    [item4.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 12 forAxis:UILayoutConstraintAxisHorizontal];
    
    LTSegmentedItem *item5 = [[LTSegmentedItem alloc] initWithTitle:self.fifthViewController.title action:^(LTSegmentedItem *item) {
        weakSelf.fifthViewController.view.backgroundColor = [UIColor blackColor];
        NSLog(@"%@", item.titleLabel.text);
        [weakSelf.pageViewController jumpToPage:4];
    }];
    [item5.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 13 forAxis:UILayoutConstraintAxisHorizontal];
    
    
    LTSegmentedView *segmentedView = [[LTSegmentedView alloc] initWithItems:@[ item1, item2, item3, item4, item5]];
    segmentedView.translatesAutoresizingMaskIntoConstraints = NO;
    segmentedView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3f];
    [self.view addSubview:segmentedView];
    self.segmentedView = segmentedView;
    
    UIView *pageView = self.pageViewController.view;
    
    NSLayoutConstraint *bottom_Constraint = [NSLayoutConstraint constraintWithItem:segmentedView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeLastBaseline multiplier:1.f constant:0.f];
    NSArray *v_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[segmentedView(40)][pageView]|" options:(NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing) metrics:nil views:NSDictionaryOfVariableBindings(segmentedView, pageView)];
    NSArray *h_Constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(segmentedView)];
    [bottom_Constraint fm_ActiveToView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:v_Constraints toView:self.view];
    [NSLayoutConstraint fm_ActiveConstraints:h_Constraints toView:self.view];
    
    [self.view addGestureRecognizer:({
    
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
        
        tapGesture;
    })];
}

- (void) tapSelf{
    
    self.titleLabel.text = [self.titleLabel.text stringByAppendingString:@"ABC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Protocol
#pragma mark LTPageViewControllerDataSource<NSObject>
- (UIViewController*) pageViewController:(LTPageViewController*) pageViewController viewControllerAtIndex:(NSInteger) index{
    
    if (index < self.viewControllers.count) {
        
        return self.viewControllers[index];
    }
    return nil;
}

- (NSInteger) pageViewController:(LTPageViewController*) pageViewController indexAtViewController:(UIViewController*) viewController{
    
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index != NSNotFound) {
        
        return index;
    }
    return 0;
}

#pragma mark LTPageViewControllerDelegate <NSObject>
- (void) pageViewController:(LTPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    
    self.animation = YES;
}

- (void) pageViewController:(LTPageViewController*) pageViewController didTransitionToViewController:(UIViewController*) viewController{
    
    NSLog(@"%s BEGIN", __FUNCTION__);
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    if (index != NSNotFound) {
        
        self.segmentedView.selectedIndex = index;
    }
    [self.segmentedView.items enumerateObjectsUsingBlock:^(__kindof LTSegmentedItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx == index) {
            
            obj.titleLabel.textColor = [UIColor colorWithRed:1.f green:76.f / 255.f blue:76.f / 255.f alpha:1.f];
            obj.titleLabel.font = [UIFont systemFontOfSize:15];
        }else{
            
            obj.titleLabel.textColor = [UIColor colorWithRed:0.f green:76.f / 255.f blue:76.f / 255.f alpha:1.f];
            obj.titleLabel.font = [UIFont systemFontOfSize:10];
        }
    }];
    self.animation = NO;
    NSLog(@"%s END", __FUNCTION__);
}

- (void) pageViewController:(LTPageViewController*) pageViewController currentIndex:(NSInteger) currentIndex scrollDirection:(LTPageViewControllerScrollDirection) direction didScrollToPercent:(CGFloat)percent{
    
    if (!self.animation) {
        
        return;
    }
    
    percent = [[NSString stringWithFormat:@"%.2f", percent] floatValue];
    
    NSInteger curIndex = currentIndex;
    NSInteger lastIndex = MAX(MIN(self.segmentedView.items.count - 1, curIndex + (direction == LTPageViewControllerScrollDirectionLeft ? -1 : 1)), 0);
    if (curIndex > lastIndex) {
        
        NSInteger tmpIndex = lastIndex;
        lastIndex = curIndex;
        curIndex = tmpIndex;
    }
    
    LTSegmentedItem *curItem = self.segmentedView.items[curIndex];
    LTSegmentedItem *lastItem = self.segmentedView.items[lastIndex];
    
    if (curIndex != lastIndex) {

        curItem.titleLabel.font = [UIFont systemFontOfSize:(5 * (1 - percent)) + 10];
        lastItem.titleLabel.font = [UIFont systemFontOfSize:(5 * percent) + 10];
    }
}



#pragma mark -Accessor
- (LTPageViewController*) pageViewController{
    
    if (!_pageViewController) {
        
        _pageViewController = [[LTPageViewController alloc] init];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self willMoveToParentViewController:_pageViewController];
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    
    return _pageViewController;
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
