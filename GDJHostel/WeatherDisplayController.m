//
//  WeatherDisplayController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "WeatherDisplayController.h"
#import "WeatherForecastCollectionController.h"
#import "WeatherCollectionCell.h"

#import "WFSManager.h"
#import "WeatherIconManager.h"

@interface WeatherDisplayController () <UIPickerViewDelegate,UIPickerViewDataSource, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/** Outlets and Actions **/

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)changedForecastDate:(UIDatePicker *)sender;



@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;

@property (weak, nonatomic) IBOutlet UISlider *forecastPeriodSlider;

- (IBAction)changedForecastPeriod:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UILabel *forecastPeriodLabel;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property UICollectionView* childCollectionView;

- (IBAction)loadDarkSkyWebsite:(UITapGestureRecognizer *)sender;


/** Data Source **/

@property CLLocationCoordinate2D currentlySelectedLocationCoordinate;
@property (readonly) NSString* currentRequestURI;
@property (readonly) NSString* apiKey;

@property WFSManager* wfsManager;



@end

@implementation WeatherDisplayController

static NSString* _baseURL = @"https://api.darksky.net/forecast/";
static NSString* _apiKey = @"ee1cc0493ff35cc8dc97394f1fcb0348";

-(void)viewWillAppear:(BOOL)animated{
    
   
    [self.locationPicker setDelegate:self];
    [self.locationPicker setDataSource:self];
}

-(void)viewDidLoad{
    
    self.wfsManager = [[WFSManager alloc] initFromFileName:@"WeatherForecastSites"];
    NSLog(@"Forecast Sites: %@",[self.wfsManager forecastSitesDescription]);
    
    
     WeatherForecastCollectionController* forecastCollectionController = (WeatherForecastCollectionController*)[self.childViewControllers objectAtIndex:0];
    
    self.childCollectionView = forecastCollectionController.collectionView;
    
    [self.childCollectionView setDelegate:self];
    [self.childCollectionView setDataSource:self];
    
    NSLog(@"Forecast Collection Controller Debug Info: %@",[forecastCollectionController description]);
    
    [self.childCollectionView reloadData];
    
}

-(void)didReceiveMemoryWarning{
    
    
}

- (IBAction)changedForecastDate:(UIDatePicker *)sender {
    NSLog(@"The selected date is: %@",[self.datePicker date]);
    
    NSLog(@"Selected a new forecast date, new URI request is: %@", self.currentRequestURI);

}

-(NSTimeInterval) getUNIXDate{
    
    return [[self.datePicker date] timeIntervalSince1970];
    
}




- (IBAction)changedForecastPeriod:(UISlider *)sender {
    
    NSUInteger forecastPeriod = (NSUInteger)[self.forecastPeriodSlider value];
    
    NSString* forecastPeriodString = [NSString stringWithFormat:@"%lu",forecastPeriod];
    
    forecastPeriodString = [forecastPeriodString stringByAppendingString:@" days"];
    
    [self.forecastPeriodLabel setText:forecastPeriodString];
    
    NSLog(@"Selected a new forecast period, new URI request is: %@", self.currentRequestURI);

    [self.childCollectionView reloadData];
    
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"Selected row %d",row);
    
    
    self.currentlySelectedLocationCoordinate = [self.wfsManager getCoordinateForForecastSite:row];
    
    NSLog(@"Selected a new forecast location, new URI request is: %@", self.currentRequestURI);
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.wfsManager getNumberOfForecastSites];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 50;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 100;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    NSString* labelText = [self.wfsManager getTitleForForecastSite:row];
    
    UILabel* labelView = [[UILabel alloc] init];
    [labelView setFont:[UIFont fontWithName:@"Futura-Medium" size:40.0]];
    [labelView setText:labelText];
    
    [labelView setFrame:self.locationPicker.frame];
    [labelView setTextAlignment:NSTextAlignmentCenter];
    [labelView setAdjustsFontSizeToFitWidth:YES];
    [labelView setMinimumScaleFactor:0.50];
    
    return labelView;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (NSUInteger)[self.forecastPeriodSlider value];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WeatherCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCollectionCell" forIndexPath:indexPath];
    
    cell.weatherIconName = @"cloudy";
    cell.temperature = 98.45;
    cell.precipitation = 12.99;
    cell.visibility = 4;
    cell.humidity = 0.55;
    cell.cloudCover = 0.88;
    cell.windSpeed = 22.34;
    cell.date = [NSDate date];
    
    return cell;
}

-(NSString *)apiKey{
    return _apiKey;
}

-(NSString *)currentRequestURI{
    
    CLLocationDegrees latitude = self.currentlySelectedLocationCoordinate.latitude;
    CLLocationDegrees longitude = self.currentlySelectedLocationCoordinate.longitude;
    NSTimeInterval requestedForecastDate = [self getUNIXDate];
    
    NSString* parameterString = [NSString stringWithFormat:@"%@/%f,%f,%f",self.apiKey,latitude,longitude,requestedForecastDate];
    
    NSString* baseURLWithParameters = [_baseURL stringByAppendingString:parameterString];
    
    return baseURLWithParameters;
}

- (IBAction)loadDarkSkyWebsite:(UITapGestureRecognizer *)sender {
}
@end
