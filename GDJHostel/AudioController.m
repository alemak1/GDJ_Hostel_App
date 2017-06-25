//
//  AudioController.m
//  GDJHostel
//
//  Created by Aleksander Makedonski on 6/25/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AudioController.h"
@import AVFoundation;

@interface AudioController () <AVAudioPlayerDelegate>


@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer *backgroundMusicPlayer;
@property (assign) BOOL backgroundMusicPlaying;
@property (assign) BOOL backgroundMusicInterrupted;

@property (assign) NSIndexPath* currentSoundIndexPath;

/** C-Style arrays for organizing sound files organized in different sound categories **/

@property SystemSoundID* transportationSounds;
@property SystemSoundID* restaurantSounds;


@end


@implementation AudioController

static int NUMBER_OF_TRANSPORTATION_SOUNDS = 10;

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        [self configureAudioSession];
       // [self configureAudioPlayer];
        [self configureSystemSound];
        
    }
    
    return self;
}

- (void)tryPlayMusic {
    // If background music or other music is already playing, nothing more to do here
    if (self.backgroundMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
        return;
    }
    
    // Play background music if no other music is playing and we aren't playing already
    //Note: prepareToPlay preloads the music file and can help avoid latency. If you don't
    //call it, then it is called anyway implicitly as a result of [self.backgroundMusicPlayer play];
    //It can be worthwhile to call prepareToPlay as soon as possible so as to avoid needless
    //delay when playing a sound later on.
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
    self.backgroundMusicPlaying = YES;
}

-(void) configureAudioSession{
    self.audioSession = [AVAudioSession sharedInstance];
    
    
    NSError *setCategoryError = nil;
    
    if ([self.audioSession isOtherAudioPlaying]) {
        
        [self.audioSession setCategory:AVAudioSessionCategorySoloAmbient error:&setCategoryError];
        
        self.backgroundMusicPlaying = NO;
        
    } else {
        [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    }
    if (setCategoryError) {
        NSLog(@"Error setting category! %ld", (long)[setCategoryError code]);
    }
}

- (void) configureAudioPlayer{
    // Create audio player with background music
    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"Alpha Dance" ofType:@"mp3"];
    
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
    
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
    
    self.backgroundMusicPlayer.delegate = self;  // We need this so we can restart after interruptions
    self.backgroundMusicPlayer.numberOfLoops = -1;	// Negative number means loop forever
}

-(void)playSystemSound{
    
    if(self.audioSession.isOtherAudioPlaying){
        return;
    }
    
    [self playSoundForIndexPath:self.currentSoundIndexPath];
}

-(void)setCurrentSoundIndexTo:(NSIndexPath*)indexPath{
    self.currentSoundIndexPath = indexPath;
}

-(void) playSoundForIndexPath:(NSIndexPath*)indexPath{
    
    AudioSectionKeyEnum section = indexPath.section;
    
    switch (section) {
        case TRANSPORTATION:
            AudioServicesPlaySystemSound(_transportationSounds[indexPath.row]);
            break;
        case HEALTH_MEDICAL:
            break;
        case RESTAURANTS:
            break;
        case DIRECTIONS:
            break;
        default:
            break;
    }
    
    
}

- (void)configureSystemSound {
    // This is the simplest way to play a sound.
    // But note with System Sound services you can only use:
    // File Formats (a.k.a. audio containers or extensions): CAF, AIF, WAV
    // Data Formats (a.k.a. audio encoding): linear PCM (such as LEI16) or IMA4
    // Sounds must be 30 sec or less
    // And only one sound plays at a time!
    
    int numberOfTransportationSounds = NUMBER_OF_TRANSPORTATION_SOUNDS;
    
    _transportationSounds = calloc(sizeof(SystemSoundID), numberOfTransportationSounds);
    

    for (int i = 0; i < numberOfTransportationSounds; i++) {
        
        NSString* fileName = [NSString stringWithFormat:@"transportation-%d",i];
        NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"];
        NSURL* url = [NSURL fileURLWithPath:path];
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_transportationSounds[i]);
    }
    
    
}


#pragma CLEANUP_METHODS

-(void) releaseSoundFiles{
    free(_transportationSounds);
    _transportationSounds = nil;
}

-(void)dealloc{
    
    [self releaseSoundFiles];
    
}


#pragma mark - AVAudioPlayerDelegate methods

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {
   
    self.backgroundMusicInterrupted = YES;
    self.backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player withOptions:(NSUInteger) flags{
  
    [self tryPlayMusic];
    self.backgroundMusicInterrupted = NO;
}




@end
