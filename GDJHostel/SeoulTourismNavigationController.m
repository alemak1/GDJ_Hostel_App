//
//  SeoulTourismNavigationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeoulTourismNavigationController.h"
#import "TouristSiteConfiguration.h"
#import "TouristSiteDetailInformationController.h"

@interface SeoulTourismNavigationController ()

@property TouristSiteConfiguration* touristSiteConfiguration;

@end

@implementation SeoulTourismNavigationController



-(void)viewDidLoad{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePresentDetailIntormationControllerNotification:) name:@"presentTouristSiteDetailNotification" object:nil];
}

-(void) handlePresentDetailIntormationControllerNotification:(NSNotification*)notification{
    NSLog(@"Handling notification....");
    
    TouristSiteConfiguration* touristSiteConfiguration = [[notification userInfo] valueForKey:@"touristSiteConfiguration"];
    
    self.touristSiteConfiguration = touristSiteConfiguration;
    
    [self performSegueWithIdentifier:@"showTouristSiteDetailController" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showTouristSiteDetailController"]){
        
        TouristSiteDetailInformationController* detailInfoController = (TouristSiteDetailInformationController*)segue.destinationViewController;
        
        [detailInfoController setTouristSiteConfiguration:self.touristSiteConfiguration];
        
       
        
        //TODO: configure the view controller with tourist configuration object
    }
    
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
