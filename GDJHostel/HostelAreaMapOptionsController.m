//
//  HostelAreaMapOptionsController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelAreaMapOptionsController.h"
#import "HostelAreaMapViewController.h"
#import "HostelLocationAnnotation.h"
#import "SeoulLocationAnnotation+HelperMethods.h"

@implementation HostelAreaMapOptionsController


-(void)viewDidLoad{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.tableView setAllowsSelection:YES];
    [self.tableView setAllowsMultipleSelection:YES];
    [self.tableView setAllowsSelectionDuringEditing:YES];
    
    UINavigationController* navigationController = (UINavigationController*)self.presentingViewController.presentedViewController;
    
    
    HostelAreaMapViewController* hostelAreaMapController = [[navigationController viewControllers] firstObject];
    
    hostelAreaMapController.selectedOptions = [[NSMutableArray alloc] init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return LAST_LOCATION_TYPE_INDEX;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"HostelAreaOptionsCell"];
    
    NSString* title = [SeoulLocationAnnotation getTitleForLocationType:indexPath.row];
    
    [cell.textLabel setAttributedText:[[NSAttributedString alloc] initWithString:title attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Medium" size:20.0],NSFontAttributeName, nil]]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UINavigationController* navigationController = (UINavigationController*)self.presentingViewController.presentedViewController;
    
    
    HostelAreaMapViewController* hostelAreaMapController = [[navigationController viewControllers] firstObject];
    
    [hostelAreaMapController.selectedOptions addObject:[NSNumber numberWithInteger:indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UINavigationController* navigationController = (UINavigationController*)self.presentingViewController.presentedViewController;
    
    
    HostelAreaMapViewController* hostelAreaMapController = [[navigationController viewControllers] firstObject];
    
    [hostelAreaMapController.selectedOptions removeObject:[NSNumber numberWithInteger:indexPath.row]];
}
    



@end
