#import "MediaRemote.h"
#import <Cephei/HBPreferences.h>

@interface MusicNowPlayingControlsViewController : UIViewController
-(void)getInfo;
@end

UIImageView *artWorkView;
UIImage *artWork;
NSData *artworkData;
static bool isLight = false;
static bool isEnabled = true;
UIVisualEffect *blurEffect;

%hook MusicNowPlayingControlsViewController
-(void)viewDidLoad {
    %orig;
	if (isEnabled){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfo) name:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoDidChangeNotification object:nil];
		artWork = [[UIImage alloc] initWithData:artworkData];
		artWorkView = [[UIImageView alloc] initWithFrame:self.view.bounds];
		[artWorkView setImage:artWork];
		[artWorkView setContentMode:UIViewContentModeScaleAspectFill];
		artWorkView.alpha = 0.85;
		if (isLight) {
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		} else {
			blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		}
		UIVisualEffectView *visualEffectView;
		visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
		visualEffectView.frame = artWorkView.bounds;
		[artWorkView addSubview:visualEffectView];
		[self.view insertSubview:artWorkView atIndex:0];
		[self getInfo];
	}
}
%new
-(void)getInfo {
    MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
            NSDictionary *dict=(__bridge NSDictionary *)(information);
            if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData] != nil) {
                artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
                artWorkView.image = [UIImage imageWithData:artworkData];
            } else {
                artWorkView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Schmusic/noalbumart.png"];
            }
    });
}
%end

void loadPrefs() {
	HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"com.maxbridgland.schmusic"];
    isEnabled = [([file objectForKey:@"kEnabled"] ?: @(YES)) boolValue];
	isLight = [([file objectForKey:@"kLight"] ?: @(NO)) boolValue];
}

%ctor {
	loadPrefs();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.maxbridgland.schmusic/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}