//
//  HostelInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/24/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelInformationController.h"
#import "MenuComponent.h"

@interface HostelInformationController ()

@property (nonatomic, strong) MenuComponent *menuComponent;
@property UIImageView* backgroundImageView;

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer;


@end

@implementation HostelInformationController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

   
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}



-(void)viewDidLoad{
    [super viewDidLoad];
   
    UISwipeGestureRecognizer *showMenuGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    
    showMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:showMenuGesture];
    
    CGRect desiredMenuFrame = CGRectMake(0.0, 0.0, 300.0, self.view.frame.size.height);
    self.menuComponent = [[MenuComponent alloc] initMenuWithFrame:desiredMenuFrame
                    targetView:self.view
                    direction:menuDirectionRightToLeft
                    options:@[@"About Hostel", @"Directions", @"Contact Info", @"Seoul Tourism",@"Weather",@"Survival Korean", @"Acknowledgements"]
                    optionImages:@[@"informationB", @"compassB", @"contactPhoneB", @"templeB",@"cloudyA",@"chatA", @"trophyB"]];

}


- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    [self.menuComponent showMenuWithSelectionHandler:^(NSInteger selectedOptionIndex) {
        
        UIStoryboard* storyBoardA = [UIStoryboard storyboardWithName:@"StoryboardA" bundle:nil];
        
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController* requestedViewController;
        
        switch (selectedOptionIndex) {
            case 0:
                //Information about hostel
                requestedViewController = [self getInformationControllerFromStoryBoard];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);
                break;
            case 1:
                //Directions
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 2:
                //Contact info
                 requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 3:
                //Seoul tourism
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"SeoulTourismNavigationController"];
                    NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 4:
                //Weather
                 requestedViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"WeatherNavigationController"];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            case 5:
                //Korean Phrases Audio
                break;
            case 6:
                //Acknowledgements
                requestedViewController = [storyBoardA instantiateViewControllerWithIdentifier:@"DirectionsMenuController"];
                NSLog(@"You selected option %d",(int)selectedOptionIndex);

                break;
            default:
                break;
        }
        
        [self showViewController:requestedViewController sender:nil];

    }];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [self.menuComponent resetMenuView:[self traitCollection]];
}

-(UIViewController*)getInformationControllerFromStoryBoard{
    
    // decide which kind of content we need based on the device idiom,
    // when we load the proper storyboard, the "ContentController" class will take it from here
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    NSString *storyBoardIdentifier = @"PadInformationController";
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyBoardIdentifier = @"PhoneInformationController";
    }
    
    
    return [mainStoryBoard instantiateViewControllerWithIdentifier:storyBoardIdentifier];
    
}

@end
