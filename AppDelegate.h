#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@class SubtitleWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
  BOOL haveOtherProcess;
}

@property (nonatomic, strong) SubtitleWindowController *subtitle;
@property (nonatomic, strong) NSMutableDictionary *options;

- (void)updateSubtitleAttributes:(NSDictionary *)attrs;

@end
