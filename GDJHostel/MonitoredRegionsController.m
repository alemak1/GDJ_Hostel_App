//
//  MonitoredRegionsController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MonitoredRegionsController.h"
#import "TouristSiteManager.h"
#import "AppLocationManager.h"
#import "UIView+HelperMethods.h"

@interface MonitoredRegionsController ()


@property TouristSiteManager* touristSiteManager;


@end



@implementation MonitoredRegionsController



-(void)viewWillAppear:(BOOL)animated{
    
    self.touristSiteManager = [[TouristSiteManager alloc] initWithFileName:@"SeoulTouristSites"];
}


-(void)viewDidLoad{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MonitoredRegionCell"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.touristSiteManager totalNumberOfTouristSitesInMasterArray];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MonitoredRegionCell"];
    
    
    TouristSiteConfiguration* touristSiteConfiguration = [self.touristSiteManager getConfigurationObjectFromMasterArray:indexPath.row];
    
    NSString* title = [touristSiteConfiguration title];
    NSString* address = [touristSiteConfiguration physicalAddress];
    
    
    BOOL hasSwitch = false;
    
    for (UIView*subview in cell.contentView.subviews) {
        if([subview isKindOfClass:[UISwitch class]]){
            hasSwitch = true;
        }
    }
    
    
    if(!hasSwitch){
        CGRect toggleFrame = [cell.contentView getFrameAdjustedRelativeToContentViewWithXCoordOffset:0.95 andWithYCoordOffset:0.10 andWithWidthMultiplier:0.20 andWithHeightMultiplier:0.90];
    
        UISwitch* monitoringToggle = [[UISwitch alloc] initWithFrame:toggleFrame];
    
        [monitoringToggle setTag:indexPath.row];
    
        BOOL isBeingMonitored = [[UserLocationManager sharedLocationManager] isBeingRegionMonitored:touristSiteConfiguration.title];
    
        [monitoringToggle setOn:isBeingMonitored];
    
        [monitoringToggle addTarget:self action:@selector(adjustToggleSwitch:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:monitoringToggle];
    }

    
    
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:address];
    
    
    
    return cell;
    
}


-(void)adjustToggleSwitch:(UISwitch*)sender{
    
    NSLog(@"Toggled switch with tag %d",[sender tag]);
    
    TouristSiteConfiguration* touristSiteConfiguration = [self.touristSiteManager getConfigurationObjectFromMasterArray:sender.tag];
    
    CLRegion* region = [touristSiteConfiguration getRegionFromTouristConfiguration];

    if([sender isOn]){
        
        
        [[UserLocationManager sharedLocationManager] startMonitoringForSingleRegion:region];
        
    } else {
        
        [[UserLocationManager sharedLocationManager] stopMonitoringForSingleRegion:region];
        
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
