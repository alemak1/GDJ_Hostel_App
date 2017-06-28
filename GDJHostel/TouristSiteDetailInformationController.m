//
//  TouristSiteDetailInformationController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/28/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristSiteDetailInformationController.h"

@interface TouristSiteDetailInformationController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isOpenSwitch;

@property (weak, nonatomic) IBOutlet UIImageView *siteImageView;
@property (weak, nonatomic) IBOutlet UILabel *operatingHoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *admissionFeeLabel;

- (IBAction)getDirectionsButton:(UIButton *)sender;


- (IBAction)loadWebsiteButton:(UIButton *)sender;


@end

@implementation TouristSiteDetailInformationController

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    
}




- (IBAction)getDirectionsButton:(UIButton *)sender {
}

- (IBAction)loadWebsiteButton:(UIButton *)sender {
}
@end
