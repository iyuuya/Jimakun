#import "AppDelegate.h"
#import "SubtitleWindowController.h"

NSString *s2ns(const char *s)
{
  if (s) return [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
  else   return @"";
}

void printUsage(void)
{
  printf(
    "usage:\n"
    "  jimakun \"messages ...\" [color_code] [edge_color_code] [thickness] [font_name font_size]\n"
    "    colo_code:      RRGGBB\n"
    "    edge_colo_code: RRGGBB\n"
    "    thickness:      0-20\n"
    "    font_name:      \"Font Name\"\n"
    "    font_size:      1-N\n"
  );
}

void printFontNames(void)
{
  for (NSString *font_name in [[NSFontManager sharedFontManager] availableFonts]) {
    printf("%s\n",
        [font_name cStringUsingEncoding:NSUTF8StringEncoding]);
  }
}

int main(int argc, const char * argv[])
{
  if (argc <= 1 || argc == 6) {
    printUsage();
    return 1;
  }

  if (argc == 2 && [s2ns(argv[1]) isEqual:@"-f"]) {
    printFontNames();
    return 0;
  }

  @autoreleasepool
  {
    NSApplication *app = [NSApplication sharedApplication];
    AppDelegate *delegate = [[AppDelegate alloc] init];

    delegate.options = [@{@"subtitle": s2ns(argv[1])} mutableCopy];

    if ([delegate.options[@"subtitle"] length] == 0)
      delegate.options[@"terminate"] = @"QUIT";

    if (argc >= 3) delegate.options[@"color"] = s2ns(argv[2]);
    if (argc >= 4) delegate.options[@"edge_color"] = s2ns(argv[3]);
    if (argc >= 5) delegate.options[@"thickness"] = s2ns(argv[4]);
    if (argc >= 7) {
      delegate.options[@"font_name"] = s2ns(argv[5]);
      delegate.options[@"font_size"] = s2ns(argv[6]);
    }

    delegate.subtitle = [[SubtitleWindowController alloc] initWithText:delegate.options[@"subtitle"]];
    [delegate updateSubtitleAttributes: delegate.options];

    [app setDelegate:[delegate autorelease]];
    [app run];
  }
  return 0;
}
