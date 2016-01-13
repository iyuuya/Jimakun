#import "SubtitleWindowController.h"
#import "MYLabel.h"

@interface MYLabel ()

@property (nonatomic, strong) NSMutableDictionary *attributes;

@end

@implementation MYLabel

- (void)setParentWindowController:(SubtitleWindowController *)wc
{
  parentWindowController = wc;
}

#pragma mark - Initialize

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setDefault];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setFrameOrigin: NSMakePoint(0.0, 0.0)];
    [self setFrameSize:   NSMakeSize(448.0, 223.0)];
    self.menu = [self createMenu];
  }

  return self;
}

#pragma mark -

- (void)setDefault
{
  self.thickness = 0.25;
  self.font = [NSFont fontWithName:@"HiraKakuStd-W8" size:36];
  self.color = [NSColor whiteColor];
  self.edge_color = [NSColor colorWithSRGBRed:0 green:0 blue:0.5 alpha:1];
  self.attributes = [NSMutableDictionary dictionary];
  [self updateAttributes];
}

- (void)updateAttributes
{
  [self.attributes setObject: self.font forKey:NSFontAttributeName];
  [self.attributes setObject: self.color forKey:NSForegroundColorAttributeName];
  [self.attributes setObject: self.edge_color forKey:NSStrokeColorAttributeName];
  [self.attributes setObject: [NSNumber numberWithFloat: -0.5*self.thickness*self.font.pointSize] forKey:NSStrokeWidthAttributeName];
  self.needsDisplay = YES;
}

- (NSSize)getSize
{
  return [self.text sizeWithAttributes:self.attributes];
}

#pragma mark - Draw

- (void)drawRect:(NSRect)dirtyRect
{
  [self.text drawAtPoint:NSMakePoint(0, 0) withAttributes:self.attributes];
}

#pragma mark - Menu and Action

- (NSMenu *)createMenu
{
  NSMenu *menu = [[[NSMenu alloc] initWithTitle: @"MYLabelMenu"] autorelease];
  [menu addItemWithTitle: @"文字の色を変更" action: @selector(showColorDialog:) keyEquivalent: @"c"];
  [menu addItemWithTitle: @"文字の縁の色を変更" action: @selector(showEdgeColorDialog:) keyEquivalent: @"e"];
  [menu addItemWithTitle: @"フォントを変更" action: @selector(showFontDialog:) keyEquivalent: @"f"];

  NSMenuItem *sliderItem = [[[NSMenuItem alloc] initWithTitle:@"sliderItem" action:nil keyEquivalent:@""] autorelease];
  NSSlider *slider = [[[NSSlider alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)] autorelease];
  [slider setMinValue:0.0f];
  [slider setMaxValue:1.0f];
  [slider setDoubleValue: 0.3];
  [slider setTarget: self];
  [slider setAction: @selector(changeThickness:)];
  [sliderItem setView:slider];
	[menu addItem:sliderItem];
  [menu addItem: [NSMenuItem separatorItem]];
  [menu addItemWithTitle: @"終了" action: @selector(terminate:) keyEquivalent: @"q"];
  return menu;
}

- (void)changeThickness:(NSSlider *)slider
{
  self.thickness = slider.doubleValue;
  [self updateAttributes];
  [self updateLayer];
  [parentWindowController resizeWindow];
}

- (void)showColorDialog:(id)sender
{
  NSColorPanel *colorPanel = [NSColorPanel sharedColorPanel];
  [colorPanel setTarget:self];
  [colorPanel setAction:@selector(changeColor:)];
  [colorPanel makeKeyAndOrderFront:self.window];
}

- (void)changeColor:(NSColorPanel *)sender
{
  self.color = sender.color;
  [self updateAttributes];
}

- (void)showEdgeColorDialog:(id)sender
{
  NSColorPanel *colorPanel = [NSColorPanel sharedColorPanel];
  [colorPanel setTarget:self];
  [colorPanel setAction:@selector(changeEdgeColor:)];
  [colorPanel makeKeyAndOrderFront:self.window];
}

- (void)changeEdgeColor:(NSColorPanel *)sender
{
  self.edge_color = sender.color;
  [self updateAttributes];
}

- (void)showFontDialog:(id)sender
{
  NSFontManager *fontManager = [NSFontManager sharedFontManager];
  [fontManager setTarget:self];
  [fontManager orderFrontFontPanel:self];
}

- (void)changeFont:(id)sender
{
  self.font = [sender convertFont: self.font];
  [self updateAttributes];
  [self updateLayer];
  [parentWindowController resizeWindow];
}

@end
