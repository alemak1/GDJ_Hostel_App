//
//  PolygonSelectionController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/1/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolygonSelectionController.h"
#import "PolygonMapController.h"
#import "BoundaryOverlay.h"

@interface PolygonSelectionController ()

@property NSMutableDictionary* polygonDictionary;
@property POLYGON_TYPE currentlySelectedPolygonIndex;

@end

@implementation PolygonSelectionController


-(void)viewDidLoad{
    
    [self loadPolygonDictionary];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"PolygonCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return LAST_POLYGON_INDEX;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PolygonCell"];
    
    NSString* title = [self getCellTitleForPolygonEnum:(POLYGON_TYPE)indexPath.row];
    
    [cell.textLabel setText:title];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentlySelectedPolygonIndex = (POLYGON_TYPE)indexPath.row;
    
    [self performSegueWithIdentifier:@"showPolygonMapControllerSegue" sender:nil];
}

-(NSString*)getCellTitleForPolygonEnum:(POLYGON_TYPE)polygonType{
    switch (polygonType) {
        case LOTTO_HOTEL:
            return @"Lotto Hotel";
            break;
        default:
            return nil;
    }
}


-(void)loadPolygonDictionary{
 
    self.polygonDictionary = [[NSMutableDictionary alloc] init];
    
    for(int i = 0; i < LAST_POLYGON_INDEX; i++){
        
        NSNumber* numberIndex = [NSNumber numberWithInteger:i];
        
        POLYGON_TYPE polygonType = (POLYGON_TYPE)i;
        
        NSString* fileName;
        
        switch (polygonType) {
            case LOTTO_HOTEL:
                fileName = @"LottoHotel";
                break;
            default:
                break;
        }
        
        
        NSLog(@"Preparing to initialize boundary overaly with path %@",fileName);
        
        BoundaryOverlay* polygonOverlay = [[BoundaryOverlay alloc] initWithFilename:fileName];
        
        
        [self.polygonDictionary setObject:polygonOverlay forKey:numberIndex];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([segue.identifier isEqualToString:@"showPolygonMapControllerSegue"]){
        
        PolygonMapController* polygonMapController = (PolygonMapController*)segue.destinationViewController;
        
        BoundaryOverlay* currentPolygon = [self.polygonDictionary objectForKey:[NSNumber numberWithInteger:self.currentlySelectedPolygonIndex]];
        
        polygonMapController.polygonOverlay = currentPolygon;
    }
}

@end
