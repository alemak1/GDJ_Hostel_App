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
                    options:@[@"About Hostel", @"Directions", @"Contact Info", @"Seoul Tourism", @"Acknowledgements"]
                    optionImages:@[@"informationB", @"compassB", @"contactPhoneB", @"templeB", @"trophyB"]];

}


- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    [self.menuComponent showMenuWithSelectionHandler:^(NSInteger selectedOptionIndex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIKit Dynamics Menu"
                message:[NSString stringWithFormat:@"You selected option #%d", selectedOptionIndex + 1]
                delegate:nil
                cancelButtonTitle:nil
                otherButtonTitles:@"Okay", nil];
        [alert show];
    }];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [self.menuComponent resetMenuView:[self traitCollection]];
}

@end
