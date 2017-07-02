//
//  ProductPriceController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "ProductPriceController.h"
#import "ProductCategory.h"
#import "NSString+CurrencyHelperMethods.h"

@interface ProductPriceController ()

@property NSDictionary* currencyExchangeData;
@property NSURLSession* apiRequestSession;

@end

@implementation ProductPriceController

static void* ProductPriceControllerContext = &ProductPriceControllerContext;

-(void)viewWillAppear:(BOOL)animated{
    
    [self loadCurrencyExchangeData];

    [self addObserver:self forKeyPath:@"currencyExchangeData" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:ProductPriceControllerContext];
}

-(void)viewDidLoad{
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDataSource:self];
    

  
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if(context == ProductPriceControllerContext){
        
        NSLog(@"The value of the currency exchange dictionary changed. It's value is now: %@",[self.currencyExchangeData description]);
    }
}


-(void)dealloc{
    
    /** Cancel outstanding URL sessions upon exit to avoid memory leaks **/
    
    [self.apiRequestSession invalidateAndCancel];
    
    [self removeObserver:self forKeyPath:@"currencyExchangeData"];
}


#pragma mark TABLEVIEW DATASOURCE AND DELEGATE METHODS

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return LAST_ASSORTED_PRODUCT_INDEX;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCategoryCell" forIndexPath:indexPath];
    
    NSString* imagePath = [NSString getImagePathFor:indexPath.row];
    
    UIImageView* cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagePath]];
    

    cellImageView.frame = cell.contentView.frame;
    
    [cell.contentView addSubview:cellImageView];
    
    return cell;
}

#pragma mark NSURL SESSION/NSURL DATA TASK UTILITY FUNCTIONS

-(void) loadCurrencyExchangeData{
    
    NSURLSessionConfiguration* defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.apiRequestSession = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    
    NSURL* urlAddress = [NSURL URLWithString:@"https://api.fixer.io/latest"];
    
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:urlAddress];
    
    NSURLSessionDataTask* dataTask = [self.apiRequestSession dataTaskWithRequest:urlRequest completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        
        
        if(error){
            NSLog(@"Error: failed to download data with error description: %@",[error description]);
        }
        
        if([response isKindOfClass:[NSHTTPURLResponse class]]){
            
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            
            if(httpResponse.statusCode == 200){
                
                self.currencyExchangeData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Currency exchange data %@",[_currencyExchangeData description]);
                    
                    
                });

                
                
            } else {
                NSLog(@"Unable to access data from server, status code: %ld",httpResponse.statusCode);
            }
        }
        
    }];
    
    [dataTask resume];
}

@end

/**
 
 MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
 request.naturalLanguageQuery = [self.locationSearchBar text];
 
 request.region = [self.mainMapView region];
 
 // Create and initialize a search object.
 MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
 
 // Start the search and display the results as annotations on the map.
 [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
 {
 NSMutableArray *placemarks = [NSMutableArray array];
 for (MKMapItem *item in response.mapItems) {
 [placemarks addObject:item.placemark];
 }
 
 [self.mainMapView removeAnnotations:[self.mainMapView annotations]];
 [self.mainMapView showAnnotations:placemarks animated:NO];
 }
 
 ];

 
 
 **/


/** This code is for use in iOS education tutorials:

 NSLog(@"From viewDidLoad, currencyExchangeData %@",[self.currencyExchangeData description]);
 
 [NSThread sleepForTimeInterval:3.00];
 
 NSLog(@"From viewDidLoad, after 3 second sleep, currencyExchangeData %@",[self.currencyExchangeData description]);
 
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.00 * NSEC_PER_SEC));
 
 dispatch_after(popTime, dispatch_get_main_queue(), ^{
 
 NSLog(@"From viewDidLoad, after 3 second wait period, currencyExchangeData %@",[self.currencyExchangeData description]);
 
 
 });

**/
