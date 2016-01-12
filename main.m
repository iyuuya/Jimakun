#import "AppDelegate.h"
#import "SubtitleWindowController.h"

void printUsage(void)
{
  printf(
    "Usage: jimakun [OPTIONS] [MESSAGES]\n"
    "\n"
    "Set Options:\n"
    "  -c --color [RRGGBB]      set subtitle color\n"
    "  -e --edge-color [RRGGBB] set subtitle edge color\n"
    "  -t --thickness [N]       set thickness(N:0-20)\n"
    "  -f --font [NAME SIZE]    set font name and size\n"
    "\n"
    "Helper Options:\n"
    "  -h --help                show this message\n"
    "     --font-names        -- show font names\n"
    "\n"
    "Other Options:\n"
    "  -q --quit                terminate application\n"
    "\n"
  );
}

void printFontNames(void)
{
  for (NSString *font_name in [[NSFontManager sharedFontManager] availableFonts]) {
    printf("%s\n", [font_name cStringUsingEncoding:NSUTF8StringEncoding]);
  }
}

void ArgumentError(void)
{
  fprintf(stderr, "argument error!\n\n");
  printUsage();
  exit(0);
}

int main(int argc, const char *argv[])
{
  @autoreleasepool
  {
    NSMutableArray *arguments = [[[NSProcessInfo processInfo] arguments] mutableCopy];

    if (argc == 1 || [arguments containsObject:@"-h"] || [arguments containsObject:@"--help"]) {
      printUsage();
      return 0;
    }

    if ([arguments containsObject:@"--font-names"]) {
      printFontNames();
      return 0;
    }

    NSApplication *app = [NSApplication sharedApplication];
    AppDelegate *delegate = [[AppDelegate alloc] init];

    delegate.options = [@{@"subtitle": [arguments lastObject]} mutableCopy];
    [arguments removeLastObject];
    argc--;

    if ([arguments containsObject:@"-q"] || [arguments containsObject:@"--quit"]) {
      delegate.options[@"terminate"] = @"QUIT";
    }

    NSUInteger idx = -1;

    if (((idx = [arguments indexOfObject:@"-c"]) != NSNotFound) ||
        ((idx = [arguments indexOfObject:@"--color"]) != NSNotFound)) {
      if (argc > idx+1) {
        delegate.options[@"color"] = arguments[idx+1];
      } else {
        ArgumentError();
      }
    }

    if (((idx = [arguments indexOfObject:@"-e"]) != NSNotFound) ||
        ((idx = [arguments indexOfObject:@"--edge-color"]) != NSNotFound)) {
      if (argc > idx+1) {
        delegate.options[@"edge_color"] = arguments[idx+1];
      } else {
        ArgumentError();
      }
    }

    if (((idx = [arguments indexOfObject:@"-t"]) != NSNotFound) ||
        ((idx = [arguments indexOfObject:@"--thickness"]) != NSNotFound)) {
      if (argc > idx+1) {
        delegate.options[@"thickness"] = arguments[idx+1];
      } else {
        ArgumentError();
      }
    }

    if (((idx = [arguments indexOfObject:@"-f"]) != NSNotFound) ||
        ((idx = [arguments indexOfObject:@"--font"]) != NSNotFound)) {
      if (argc > idx+2) {
        delegate.options[@"font_name"] = arguments[idx+1];
        delegate.options[@"font_size"] = arguments[idx+2];
      } else {
        ArgumentError();
      }
    }

    delegate.subtitle = [[SubtitleWindowController alloc] initWithText:delegate.options[@"subtitle"]];
    [delegate updateSubtitleAttributes: delegate.options];

    [app setDelegate:[delegate autorelease]];
    [app run];
  }
  return 0;
}
