#import "SubtitleWindowController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc
{
  [_subtitle release];
  [super dealloc];
}

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
  pid_t myPID = [[NSProcessInfo processInfo] processIdentifier];
  NSURL *myURL = [[NSBundle mainBundle] executableURL];

  NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
  haveOtherProcess = NO;

  for (NSRunningApplication *app in apps) {
    if (myPID == app.processIdentifier) continue;

    if ([[myURL absoluteString] isEqualToString: [app.executableURL absoluteString]]) {
      haveOtherProcess = YES;
    }
  }

  if (haveOtherProcess) {
    [self _postNotes];
    [NSApp terminate:self];
  }

  [self _registerForNotes];

  [_subtitle.window makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
  [_subtitle showWindow:self];
}

#pragma mark - NSNotification

- (void)_registerForNotes
{
  NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
  [dnc addObserver:self selector:@selector(_handleDistributedNote:) name:[self _notificationName] object:nil];
}

- (void)_postNotes
{
  NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
  NSNotification *n = [NSNotification notificationWithName:[self _notificationName] object:nil userInfo:self.options];
  [dnc postNotification:n];
}

- (void)_handleDistributedNote:(NSNotification *)note
{
  if ([note.userInfo[@"terminate"] isEqualToString: @"QUIT"]) {
    [NSApp terminate:self];
  }

  [self updateSubtitleAttributes:note.userInfo];
}

- (void)updateSubtitleAttributes:(NSDictionary *)attrs
{
  if ([attrs.allKeys containsObject:@"subtitle"]) {
    [_subtitle setText:attrs[@"subtitle"]];
  }

  if ([attrs.allKeys containsObject:@"color"]) {
    [_subtitle setHexColorString:attrs[@"color"]];
  }

  if ([attrs.allKeys containsObject:@"edge_color"]) {
    [_subtitle setHexEdgeColorString:attrs[@"edge_color"]];
  }

  if ([attrs.allKeys containsObject:@"thickness"]) {
    [_subtitle setThickness:[attrs[@"thickness"] floatValue]];
  }

  if ([attrs.allKeys containsObject:@"font_name"] &&
      [attrs.allKeys containsObject:@"font_size"]) {
    [_subtitle setFontWithName: attrs[@"font_name"] size:[attrs[@"font_size"] floatValue]];
  }
}

- (NSString *)_notificationName
{
  return @"JimakunDistributedNote";
}

@end
