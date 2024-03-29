//
//  ScrollableInfoController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "ScrollableInfoController.h"

@interface ScrollableInfoController ()

@property NSArray* contentList;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *containingView;



@property UIDynamicAnimator* animator;

@property UIPushBehavior* pushBehavior;
@property UICollisionBehavior* collisionBehavior;


- (IBAction)changeScrollPage:(UIPageControl *)sender;

@end

@implementation ScrollableInfoController


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"content_iPhone" ofType:@"plist"];
    self.contentList = [NSArray arrayWithContentsOfFile:path];
    
    NSLog(@"The content list is as follows: %@",[self.contentList description]);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSInteger numberOfPages = self.contentList.count;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * numberOfPages, self.scrollView.frame.size.height);
    
    
    self.scrollView.delegate = self;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.bounces = FALSE;
    
    [self loadImagesForScrollView];
    
    self.pageControl.numberOfPages =  numberOfPages;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    [self setupBehaviors];

    [self setupGestureRecognizers];
    
    

}



-(void)setupGestureRecognizers{
    
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    
    [self.containingView addGestureRecognizer:swipeRecognizer];
    
    
}

-(void)setupBehaviors{
    
    self.pushBehavior = [[UIPushBehavior alloc]initWithItems:[NSArray arrayWithObjects:self.containingView, nil] mode:UIPushBehaviorModeInstantaneous];
    
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:[NSArray arrayWithObjects:self.containingView,self.scrollView, nil]];
    
    /**
    CGPoint fromPoint = CGPointMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y + self.scrollView.frame.size.height);
    
    CGPoint toPoint = CGPointMake(self.scrollView.frame.origin.x + self.scrollView.frame.size.width, self.scrollView.frame.origin.y + self.scrollView.frame.size.height);
    
    [self.collisionBehavior addBoundaryWithIdentifier:@"pushBoundary" fromPoint:fromPoint toPoint:toPoint];
    **/
    
    [self.animator addBehavior:self.collisionBehavior];
    

    
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if(swipe.state == UIGestureRecognizerStateBegan){
        if(swipe.direction == UISwipeGestureRecognizerDirectionUp || swipe.direction == UISwipeGestureRecognizerDirectionDown){
            
            
            [self.animator addBehavior:self.pushBehavior];
            
        }
        
    } else if(swipe.state == UIGestureRecognizerStateChanged){
        
        
        
    } else if(swipe.state == UIGestureRecognizerStateEnded || swipe.state == UIGestureRecognizerStateCancelled){
        
        [self.animator removeBehavior:self.pushBehavior];
        
    }
    
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void) loadImagesForScrollView{
    
    for(int i = 0; i < self.contentList.count; i++){
        
        CGRect imageViewFrame = self.scrollView.bounds;
        CGFloat scrollViewFrameWidth = CGRectGetWidth(self.scrollView.bounds);
        CGFloat adjustedScrollViewFrameWidth = scrollViewFrameWidth*1.2;
        
        imageViewFrame.origin.y = 0;
        imageViewFrame.origin.x = i * adjustedScrollViewFrameWidth;
        imageViewFrame.size.width = adjustedScrollViewFrameWidth;
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
        [self.scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        NSDictionary* numberDict = [self.contentList objectAtIndex:i];
        NSString* imagePath = [numberDict valueForKey:@"imageKey"];
        UIImage* image = [UIImage imageNamed:imagePath];
        
        imageView.image = image;
    }
}

- (IBAction)changePage:(id)sender {
    CGFloat x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}



- (IBAction)changeScrollPage:(UIPageControl *)sender {
    NSInteger pageNumber = roundf(self.scrollView.contentOffset.x / (self.scrollView.frame.size.width));
    self.pageControl.currentPage = pageNumber;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // switch the indicator when more than 50% of the previous/next page is visible
    
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    
    NSUInteger page = floor((self.scrollView.contentOffset.x/pageWidth));
    self.pageControl.currentPage = page;


    
    [self goToPoint:page*pageWidth];
    
    
}



-(void)goToPoint:(CGFloat)xPoint{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.20 delay:0.00 options:UIViewAnimationOptionCurveLinear animations:^{
        
            [self.scrollView setContentOffset:CGPointMake(xPoint, 0.00)];
            
        } completion:nil];
        
       
    
    });
    
   
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.alwaysBounceVertical = NO;
    
    [self loadImagesForScrollView];
}

@end
