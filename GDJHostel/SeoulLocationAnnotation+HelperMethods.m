//
//  SeoulLocationAnnotation+HelperMethods.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 7/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "SeoulLocationAnnotation+HelperMethods.h"

@implementation SeoulLocationAnnotation (HelperMethods)



+(NSString*) getTitleForLocationType:(SeoulLocationType)locationType{
    
    switch (locationType) {
        case NearHostelLocationBankATM:
            return @"Banks and ATMs";
        case NearHostelLocationPubsBars:
            return @"Pubs and Bars";
        case NearHostelLocationCoffeeShop:
            return @"Coffee Shops";
        case NearHostelLocationOtherStores:
            return @"Other Types of Stores";
        case NearHostelLocationKoreanBarbecue:
            return @"Korean Barbecue";
        case NearHostelLocationConvenienceStore:
            return @"Convenience Stores";
        case NearHostelLocationOtherRestaurants:
            return @"Other Kinds of Restaurants";
        case NearHostelLocationSportsRecreation:
            return @"Sports and Recreation";
        case NearHostelLocationPharmacyDrugstore:
            return @"Pharmacy and Drugstores";
        case NearHostelLocationPhoneMobileServices:
            return @"Phone and Mobile Services";
        case NearHostelLocationCosmeticsSkinFacialCare:
            return @"Cosmetics and Skin Care";
        case TouristAttractionTower:
            return @"Radio Towers";
        case TouristAttractionMuseum:
            return @"Museums";
        case TouristAttractionTemple:
            return @"Temples";
        case TouristAttractionWarMemorial:
            return @"Korean War Memorial";
        case TouristAttractionShoppingArea:
            return @"Shopping Area";
        case TouristAttractionStreetMarket:
            return @"Night Market";
        default:
            return nil;
    }
}

+(NSString*)getImagePathForSeoulLocationType:(SeoulLocationType)seoulLocationType{
    switch(seoulLocationType){
        case NearHostelLocationCoffeeShop:
            return @"coffeeA";
        case NearHostelLocationKoreanBarbecue:
            return @"barbecueA";
        case NearHostelLocationConvenienceStore:
            return @"convenienceStoreA";
        case NearHostelLocationOtherRestaurants:
            return @"otherRestaurantsA";
        case NearHostelLocationSportsRecreation:
            return @"microphoneA";
        case NearHostelLocationPharmacyDrugstore:
            return @"pharmacyA";
        case NearHostelLocationPhoneMobileServices:
            return @"phoneA";
        case NearHostelLocationCosmeticsSkinFacialCare:
            return @"creamIconA";
        case NearHostelLocationPubsBars:
            return @"otherRestaurantsA";
        case NearHostelLocationOtherStores:
            return @"convenienceStoreA";
        case NearHostelLocationBankATM:
            return @"piggyBankA";
        case TouristAttractionTower:
            return @"towerA";
        case TouristAttractionMuseum:
            return @"paintingA";
        case TouristAttractionTemple:
            return @"templeA";
        case TouristAttractionWarMemorial:
            return @"tankA";
        case TouristAttractionShoppingArea:
            return @"shoppingA";
        case TouristAttractionStreetMarket:
            return @"streetStandA";
        default:
            return nil;
    }

}

+(UIColor*)getFontHeaderColorForSeoulLocationType:(SeoulLocationType)seoulLocationType{
    
    switch (seoulLocationType) {
        case NearHostelLocationCoffeeShop:
            return [UIColor brownColor];
        case NearHostelLocationKoreanBarbecue:
            return [UIColor redColor];
        case NearHostelLocationConvenienceStore:
            return [UIColor grayColor];
        case NearHostelLocationOtherRestaurants:
            return [UIColor purpleColor];
        case NearHostelLocationSportsRecreation:
            return [UIColor cyanColor];
        case NearHostelLocationPharmacyDrugstore:
            return [UIColor magentaColor];
        case NearHostelLocationPhoneMobileServices:
            return [UIColor blueColor];
        case NearHostelLocationCosmeticsSkinFacialCare:
            return [UIColor yellowColor];
        case NearHostelLocationPubsBars:
            return [UIColor orangeColor];
        case NearHostelLocationOtherStores:
            return [UIColor grayColor];
        case NearHostelLocationBankATM:
            return [UIColor lightGrayColor];
        case TouristAttractionTower:
            return [UIColor darkGrayColor];
        case TouristAttractionMuseum:
            return [UIColor brownColor];
        case TouristAttractionTemple:
            return [UIColor redColor];
        case TouristAttractionWarMemorial:
            return [UIColor grayColor];
        case TouristAttractionShoppingArea:
            return [UIColor blueColor];
        case TouristAttractionStreetMarket:
            return [UIColor yellowColor];
        default:
            return nil;
    }
    
}

@end