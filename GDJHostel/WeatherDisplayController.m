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

@property CLLocationCoordinate2D currentlySelectedLocationCoordinate;


/** Helper Properties for Configuring URL **/

@property (readonly) NSString* currentRequestURI;
@property (readonly) NSString* apiKey;

/** Data Source **/

@property WFSManager* wfsManager;


/** Properties related to NSURL Session **/

@property NSURLSession* sessionForWeatherDataRequests;
@property (readonly) NSURLSessionConfiguration* sessionConfiguration;
@property NSMutableArray<NSDictionary*>* jsonDictArray;

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
    
    
     WeatherForecastCollectionController* forecastCollectionController = (WeatherForecastCollectionController*)[self.childViewControllers objectAtIndex:0];
    
    self.childCollectionView = forecastCollectionController.collectionView;
    
    [self.childCollectionView setDelegate:self];
    [self.childCollectionView setDataSource:self];
    

    [self.childCollectionView reloadData];
    
    /** Provide initial values for weather forecast **/
    
    [self.datePicker setDate:[NSDate date]];
    [self.forecastPeriodSlider setValue:1.00];
    [self setCurrentlySelectedLocationCoordinate:CLLocationCoordinate2DMake(37.5616592, 126.8736235)];
    
    /** Start an initial url session **/
    
    [self getUpdatedJSONDataBasedOnAdjustedParameters];
    
}

-(void)didReceiveMemoryWarning{
    
    
}

#pragma mark **** METHODS THAT TRIGGER NEW URLSESSIONS 

- (IBAction)changedForecastDate:(UIDatePicker *)sender {
    
    /** Start a new url session for the new forecast date **/
    
    [self getUpdatedJSONDataBasedOnAdjustedParameters];


}


- (IBAction)changedForecastPeriod:(UISlider *)sender {
    
    NSUInteger forecastPeriod = (NSUInteger)[self.forecastPeriodSlider value];
    
    NSString* forecastPeriodString = [NSString stringWithFormat:@"%lu",forecastPeriod];
    
    forecastPeriodString = [forecastPeriodString stringByAppendingString:@" days"];
    
    [self.forecastPeriodLabel setText:forecastPeriodString];
    
    /** Start a new url session for the new forecast date **/
    
    [self getUpdatedJSONDataBasedOnAdjustedParameters];
    

    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
    self.currentlySelectedLocationCoordinate = [self.wfsManager getCoordinateForForecastSite:row];
    
    
    /** Start a new URL session for the newly selected location  **/
    
    [self getUpdatedJSONDataBasedOnAdjustedParameters];
    
    
}


#pragma mark ******* PICKER VIEW DELEGATE METHODS


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

#pragma mark ****** COLLECTION VIEW DATA SOURCE AND DELEGATE METHODS

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



#pragma mark ******* URL SESSION MANAGEMENT HELPER METHODS

-(void)getUpdatedJSONDataBasedOnAdjustedParameters{
    
    [self cancelPreviousURLSession];
    
    [self createAndStartDataTasksForNewURLSession];
    
    [self.childCollectionView reloadData];
    
    NSLog(@"Contents of the JSON data array");
    
    for(NSDictionary* dict in self.jsonDictArray){
        NSLog(@"Contents of JSON Dict: %@",[dict description]);
    }
    
}

-(void) cancelPreviousURLSession{
    
    if(self.sessionForWeatherDataRequests){
        [self.sessionForWeatherDataRequests invalidateAndCancel];
        self.sessionForWeatherDataRequests = nil;
    }
}


-(void)createAndStartDataTasksForNewURLSession{
    
    self.sessionForWeatherDataRequests = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
    
    self.jsonDictArray = [[NSMutableArray alloc] init];
    
    WeatherDisplayController* __weak weakSelf = self;
    
    for(NSURL* url in [self getURLsForForecastPeriod]){
        
        [[self.sessionForWeatherDataRequests dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSLog(@"Got response %@ with error %@.\n", response, error);
            
            /** JSON Dictionaries for a particular session are added to stored array **/
            NSError* e = nil;
            
            if(data){
                NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            
                [weakSelf.jsonDictArray addObject:jsonDict];
            }
            
        }] resume];
        
    }
    
    
}


-(NSArray<NSURL*>*)getURLsForForecastPeriod{
    
    NSMutableArray<NSURL*>* urlArray = [[NSMutableArray alloc] init];
    
    int numberOfForecastDays = (int)[self.forecastPeriodSlider value];
    NSDate* runningDate = [self.datePicker date];
    
    for(int i = 0; i < numberOfForecastDays; i++){
        
       runningDate = [NSDate dateWithTimeInterval:(i*3600*24) sinceDate:runningDate];
        NSTimeInterval UNIXFormattedRunningDate = [runningDate timeIntervalSince1970];
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setMaximumFractionDigits:0];
        
        NSString* runningDateString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:UNIXFormattedRunningDate]];
        
        NSString* nextURLString = [self.currentRequestURI stringByAppendingString:runningDateString];
        
        NSURL* nextURL = [NSURL URLWithString:nextURLString];
        
        [urlArray addObject:nextURL];
    }
    
    return [NSArray arrayWithArray:urlArray];
}


-(void)showCurrentURLsForDataTasks{
    
    NSLog(@"The new set of urls is: ");
    
    for (NSURL*url in [self getURLsForForecastPeriod]) {
        NSLog(@"%@",[url absoluteString]);
    }
    
}


-(NSString *)apiKey{
    return _apiKey;
}

-(NSString *)currentRequestURI{
    
    CLLocationDegrees latitude = self.currentlySelectedLocationCoordinate.latitude;
    CLLocationDegrees longitude = self.currentlySelectedLocationCoordinate.longitude;
    
    NSString* parameterString = [NSString stringWithFormat:@"%@/%f,%f,",self.apiKey,latitude,longitude];
    
    NSString* baseURLStringWithLocationParameters = [_baseURL stringByAppendingString:parameterString];
    
    return baseURLStringWithLocationParameters;
}

-(NSURLSessionConfiguration *)sessionConfiguration{
    
    /** The readonly sessionConfiguration provides a new instance of a default session configuration each time it is accessed **/
    
    return [NSURLSessionConfiguration defaultSessionConfiguration];
}


#pragma mark **** OTHER HELPER METHODS

-(NSTimeInterval) getUNIXDate{
    
    return [[self.datePicker date] timeIntervalSince1970];
    
}

#pragma mark ****** IBACTION FOR LOADING DARK SKY WEBSITE 

- (IBAction)loadDarkSkyWebsite:(UITapGestureRecognizer *)sender {
}

@end
