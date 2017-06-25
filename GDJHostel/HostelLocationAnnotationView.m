//
//  HostelLocationAnnotationView.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/23/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostelLocationAnnotationView.h"
#import "HostelLocationAnnotation.h"

@implementation SeoulLocationAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if(self){
        SeoulLocationAnnotation* seoulLocationAnnotation = self.annotation;
        
        switch(seoulLocationAnnotation.locationType){
            case NearHostelLocationCoffeeShop:
                self.image = [UIImage imageNamed:@"coffeeA"];
                break;
            case NearHostelLocationKoreanBarbecue:
                self.image = [UIImage imageNamed:@"barbecueA"];
                break;
            case NearHostelLocationConvenienceStore:
                self.image = [UIImage imageNamed:@"convenienceStoreA"];
                break;
            case NearHostelLocationOtherRestaurants:
                self.image = [UIImage imageNamed:@"otherRestaurantsA"];
                break;
            case NearHostelLocationSportsRecreation:
                self.image = [UIImage imageNamed:@"microphoneA"];
                break;
            case NearHostelLocationPharmacyDrugstore:
                self.image = [UIImage imageNamed:@"pharmacyA"];
                break;
            case NearHostelLocationPhoneMobileServices:
                self.image = [UIImage imageNamed:@"phoneA"];
                break;
            case NearHostelLocationCosmeticsSkinFacialCare:
                self.image = [UIImage imageNamed:@"creamIconA"];
                break;
            case NearHostelLocationPubsBars:
                self.image = [UIImage imageNamed:@"otherRestaurantsA"];
                break;
            case NearHostelLocationOtherStores:
                self.image = [UIImage imageNamed:@""];
                break;
            case NearHostelLocationBankATM:
                self.image = [UIImage imageNamed:@"piggyBankA"];
                break;
            case TouristAttractionTower:
                self.image = [UIImage imageNamed:@"towerA"];
                break;
            case TouristAttractionMuseum:
                self.image = [UIImage imageNamed:@"paintingA"];
                break;
            case TouristAttractionTemple:
                self.image = [UIImage imageNamed:@"templeA"];
                break;
            case TouristAttractionWarMemorial:
                self.image = [UIImage imageNamed:@"tankA"];
                break;
            case TouristAttractionShoppingArea:
                self.image = [UIImage imageNamed:@"shoppingA"];
                break;
            case TouristAttractionStreetMarket:
                self.image = [UIImage imageNamed:@"streetStandA"];
                break;
        }
        
        
    }
    
    return self;
}

@end
