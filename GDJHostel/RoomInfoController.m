//
//  RoomInfoController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "RoomInfoController.h"
#import "HostelCollectionController.h"
#import "HostelFlowLayout.h"

@interface RoomInfoController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end


@implementation RoomInfoController



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
    
    
    HostelFlowLayout* hostelFlowLayout = [[HostelFlowLayout alloc]initWithPresetHorizontalConfigurationA];
    
    HostelCollectionController* hostelCollectionController = [[HostelCollectionController alloc] initWithCollectionViewLayout:hostelFlowLayout];
    
    
    [self addChildViewController:hostelCollectionController];
    
    [self.scrollView addSubview:hostelCollectionController.view];
    
    [hostelCollectionController.view setFrame:CGRectMake(0.00, 0.00, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    
    [hostelCollectionController didMoveToParentViewController:self];
    }

@end
