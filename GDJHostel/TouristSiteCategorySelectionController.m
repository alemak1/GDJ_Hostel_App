//
//  TouristSiteCategorySelectionController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/27/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteCategorySelectionController.h"
#import "TouristSiteCollectionViewController.h"

@interface TouristSiteCategorySelectionController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation TouristSiteCategorySelectionController


-(void)viewWillLayoutSubviews{
    
    
    
}

-(void)viewDidLoad{
    
    
    CGFloat scrollViewWidth = CGRectGetWidth(self.scrollView.frame);
    CGFloat scrollViewHeight = CGRectGetHeight(self.scrollView.frame);
    
    self.scrollView.contentSize = CGSizeMake(scrollViewWidth, scrollViewHeight*3.00);

    
    __block CGFloat controllerIndex = 0;
    
    CGFloat controllerHeight = scrollViewHeight*0.50;
    
    CGRect(^getControllerFrame)(void) = ^CGRect(void){
        
        CGRect frame = CGRectMake(0.00, controllerIndex*controllerHeight+controllerHeight*0.20, scrollViewWidth, controllerHeight);
        
        return frame;
    };
    
    
    
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    
    TouristSiteCollectionViewController* touristSiteCVC1 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC1];
    
    CGRect frame1 = getControllerFrame();
    
    [touristSiteCVC1.view setFrame:frame1];
    
    [self.scrollView addSubview:touristSiteCVC1.view];
    
    [touristSiteCVC1 didMoveToParentViewController:self];
    
    [touristSiteCVC1 setTitleLabelText:@"Museums"];
    
    controllerIndex++;
    
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC2 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC2];

    CGRect frame2 = getControllerFrame();
    
    [touristSiteCVC2.view setFrame:frame2];
    
    [self.scrollView addSubview:touristSiteCVC2.view];
    
    [touristSiteCVC2 didMoveToParentViewController:self];
    
    [touristSiteCVC2 setTitleLabelText:@"Parks"];

    
    controllerIndex++;
    
    
    //Configure the next view controller...
    
    
    TouristSiteCollectionViewController* touristSiteCVC3 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC3];

    CGRect frame3 = getControllerFrame();
    
    [touristSiteCVC3.view setFrame:frame3];

    [self.scrollView addSubview:touristSiteCVC3.view];
    
    [touristSiteCVC3 didMoveToParentViewController:self];
    
    [touristSiteCVC3 setTitleLabelText:@"Memorials and Monuments"];

    
    controllerIndex++;
    
    //Configure the next view controller...
    
    TouristSiteCollectionViewController* touristSiteCVC4 = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TouristSiteCollectionViewController"];
    
    [self addChildViewController:touristSiteCVC4];
    
    
    CGRect frame4 = getControllerFrame();
    
    [touristSiteCVC4.view setFrame:frame4];
    
    [self.scrollView addSubview:touristSiteCVC4.view];
    
    [touristSiteCVC4 didMoveToParentViewController:self];
    
    [touristSiteCVC4 setTitleLabelText:@"Shopping Centers"];

    
}


@end
