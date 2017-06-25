//
//  KoreanAudioPhraseController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "KoreanAudioPhraseController.h"

NSString* const kFilePathKey = @"audiofilepath";
NSString* const kOriginalPhraseKey = @"original";

@interface KoreanAudioPhraseController ()

@property (strong, nonatomic) AudioController *audioController;
@property NSMutableDictionary* audioSectionDictionary;

@end

@implementation KoreanAudioPhraseController


-(void)viewWillAppear:(BOOL)animated{
    
    /** Load all of the original English phrases from the plist **/
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"SurvivalWordsPhrases" ofType:@"plist"];
    
    self.audioSectionDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismissNavigationController)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Play Korean Translation" style:UIBarButtonItemStylePlain target:self action:@selector(playSelectedSound)];
    
}


-(void) dismissNavigationController{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void) playSelectedSound{
    [self.audioController playSystemSound];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.audioController = [[AudioController alloc] init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EnglishPhraseCell"];
    
    [self.tableView setDelegate:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return LAST_AUDIO_SECTION_INDEX;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString* audioSectionStringKey = [self getAudioSectionStringKeyForAudioSectionKeyEnum:section];
    
    NSArray* audioInfoDictArray = [self.audioSectionDictionary valueForKey:audioSectionStringKey];
    
    return [audioInfoDictArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"EnglishPhraseCell"];
    
    NSInteger sectionNumber = indexPath.section;
    
    NSString* sectionStringKeyName = [self getAudioSectionStringKeyForAudioSectionKeyEnum:sectionNumber];
    
    NSArray* audioInfoDictArray = [self.audioSectionDictionary valueForKey:sectionStringKeyName];
    
    NSDictionary* audioInfoDict = [audioInfoDictArray objectAtIndex:indexPath.row];
    
    NSString* audioFilePath = [audioInfoDict valueForKey:kFilePathKey];
    NSString* originalPhrase = [audioInfoDict valueForKey:kOriginalPhraseKey];
    
    cell.textLabel.text = originalPhrase;
    
    return cell;
}


/** Helper Method **/


-(NSString*) getAudioSectionStringKeyForAudioSectionKeyEnum:(AudioSectionKeyEnum)audioSectionKeyEnum{
    
    switch (audioSectionKeyEnum) {
        case CURRENCY:
            return @"Currency";
        case HEALTH_MEDICAL:
            return @"Health/Medical";
        case DIRECTIONS:
            return @"Directions";
        case FUN_PHRASES:
            return @"Fun Phrases";
        case BANKING:
            return @"Banking";
        case BASIC_PHRASES:
            return @"Basic Phrases";
        case RESTAURANTS:
            return @"Restaurants and Food";
        case TRANSPORTATION:
            return @"Transportation";
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.audioController setCurrentSoundIndexTo:indexPath];
    
}

@end
