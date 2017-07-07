//
//  TouristSiteFilterController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/7/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "TouristSiteFilterController.h"


@interface TouristFilterController () <UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UISlider *distanceFilterSlider;


@property (weak, nonatomic) IBOutlet UIPickerView *categoryFilterPicker;

@property NSArray<TouristSiteConfiguration*>* filteredSiteManager;


- (IBAction)performSiteSearchWithSpecifiedFilterCriteria:(UIButton *)sender;

@property TouristSiteCategory selectedSiteCategory;
@property double selectedTravelTimeInSeconds;
@property double selectedMaxDistance;

- (IBAction)didChangeSelectedDistance:(UISlider *)sender;

- (IBAction)didChangeSelectedTime:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UISlider *travelTimeFilterSlider;


@end


@implementation TouristFilterController

-(void)viewDidLoad{
    
    
}


#pragma makr TABLEVIEW DATASOURCE AND DELEGATE METHODS

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TouristSiteCell"];
    
    TouristSiteConfiguration* siteConfiguration = [self.filteredSiteManager objectAtIndex:indexPath.row];
    
    
    NSString* cellTextString = [NSString stringWithFormat:@"%@",siteConfiguration.title];
    
    [cell.textLabel setText:cellTextString];
    return cell;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.filteredSiteManager count];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark PICKERVIEW DATASOURCE AND DELEGATE METHODS

/**
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 50;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 100;
}
**/

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return TOURIST_SITE_CATEGORY_END_INDEX;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self getTitleForPickerViewRow:row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.selectedSiteCategory = (TouristSiteCategory)row;
}



- (IBAction)performSiteSearchWithSpecifiedFilterCriteria:(UIButton *)sender {
    

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
        self.filteredSiteManager = [self.siteManager getArrayForMaximumTravelingTime:self.selectedTravelTimeInSeconds andMaxDistance:self.selectedMaxDistance andForCategory:self.selectedSiteCategory];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    
    });
    
}

-(NSString*)getTitleForPickerViewRow:(NSInteger)row{
    
    TouristSiteCategory siteCategory = (TouristSiteCategory)row;
    
    NSString* rowTitle;
    
    switch (siteCategory) {
        case KOREAN_WAR_MEMORIAL:
            rowTitle = @"War Memorial of Korea";
            break;
        case GWANGHUAMUN:
            rowTitle = @"Gyeongbokgung Palace Area";
            break;
        case MUSUEM:
            rowTitle = @"Museums, Art Galleries, and Related";
            break;
        case TEMPLE:
            rowTitle = @"Temples and Related";
            break;
        case SHOPPING_AREA:
            rowTitle = @"Shopping Areas";
            break;
        case PARK:
            rowTitle = @"Parks and Outdoor Recreation";
            break;
        case SPORT_STADIUM:
            rowTitle = @"Sports Stadium";
            break;
        case SEOUL_TOWER:
            rowTitle = @"North Seoul Tower Area";
            break;
        case NATURAL_SITE:
            rowTitle = @"Natural Sites";
            break;
        case RADIO_TOWER:
            rowTitle = @"Other Radio Towers";
            break;
        case NIGHT_MARKET:
            rowTitle = @"Night Markets";
            break;
        case OTHER:
            rowTitle = @"Other Sites of Interest";
            break;
        case MONUMENT_OR_WAR_MEMORIAL:
            rowTitle = @"Other Monuments or Memorials";
            break;
        case YANGGU_COUNTY:
            rowTitle = @"Yanggu County Area";
            break;
        default:
            break;
    }
    
    return rowTitle;
}

- (IBAction)didChangeSelectedDistance:(UISlider *)sender {
    
    self.selectedMaxDistance = [self.distanceFilterSlider value];
}

- (IBAction)didChangeSelectedTime:(UISlider *)sender {
    
    self.selectedTravelTimeInSeconds = [self.travelTimeFilterSlider value];
}
@end
