//
//  FeatureScrollViewController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeatureScrollViewController.h"


@interface FeatureScrollViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FeatureScrollViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];

    
    /** Configure the scroll view **/
    
    [self.scrollView setDelegate:self];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)*1.80)];
    
    
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setPagingEnabled:NO];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setAlwaysBounceVertical:NO];
    
    /** Instantiate the feature view controller from the storyboard, add it as a child view controller, and add it view to the scroll view **/
    
    UIStoryboard* mainStoryBOard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UIViewController* featureViewController = [mainStoryBOard instantiateViewControllerWithIdentifier:@"FeatureViewController"];
    
    [self addChildViewController:featureViewController];
    
    [self.scrollView addSubview:featureViewController.view];
    
    [featureViewController.view setFrame:CGRectMake(0.00, 0.00, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    
    [featureViewController didMoveToParentViewController:self];
    
}




@end
