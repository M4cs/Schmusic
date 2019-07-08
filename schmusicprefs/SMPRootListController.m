#include "SMPRootListController.h"

@implementation SMPRootListController
	- (instancetype)init {
		self = [super init];
		if (self) {
			HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
			appearanceSettings.tintColor = [UIColor colorWithRed:66.f / 255.f green:105.f / 255.f blue:154.f / 255.f alpha:1];
        	appearanceSettings.tableViewBackgroundColor = [UIColor colorWithWhite:242.f / 255.f alpha:1];
			appearanceSettings.navigationBarBackgroundColor = [UIColor colorWithWhite:242.f / 255.f alpha:1];
			self.hb_appearanceSettings= appearanceSettings;
		}
		return self;
	}
	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		}
		return _specifiers;
	}
	- (void)viewWillAppear:(BOOL)animated {
		[super viewWillAppear:animated];
		CGRect frame = self.table.bounds;
		frame.origin.y = -frame.size.height;
		[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
		self.navigationController.navigationController.navigationBar.translucent = YES;
	}
	- (void)resetPrefs:(id)sender {
		HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"com.maxbridgland.schmusic"];
		[prefs removeAllObjects];
	}
@end