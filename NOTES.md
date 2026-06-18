# Learning Notes — Flutter Web Portfolio

A running file of things worth remembering as we build. Newest entries at the bottom of each phase section.

---

## Phase 0 — Environment setup

### Vocabulary

- **Programming** — writing step-by-step instructions for the computer.
- **Code** — the written instructions themselves.
- **Programming language** — the rules and vocabulary used to write code. We use **Dart**.
- **Flutter** — a toolbox built on top of Dart, used for building user interfaces (the visual things people see and click).
- **SDK (Software Development Kit)** — a bundle of tools you install once so you can build apps. Flutter SDK = Flutter toolbox + Dart language + helper programs.
- **Terminal** — a text window on the Mac where you type commands and press Enter. Pre-installed; open via Spotlight (Cmd+Space, type "Terminal").
- **Command** — a single line of text typed into Terminal that tells the Mac to do something.
- **Homebrew (`brew`)** — a helper program that installs other programs with one command. Optional but makes life easier on a Mac.

### Commands we ran

| Command | What it does |
|---|---|
| `brew --version` | Checks whether Homebrew is already installed. |
| `brew install --cask flutter` | Downloads and installs the Flutter SDK. |
| `flutter --version` | Shows which version of Flutter (and Dart) is installed. |
| `flutter config --enable-web` | Turns on Flutter's ability to build for web browsers. |
| `flutter doctor` | Checks if everything is set up correctly. Tells you what's missing. |
| `flutter devices` | Lists places we can run our app (Chrome, simulator, phone, etc). |

### Rules of thumb

- When `flutter doctor` shows red X's, **read them but don't panic.** For a web-only portfolio we only need ✓ next to "Chrome — develop for the web". X's for Android/iOS toolchains can be ignored for now.
- In Terminal, when typing a password, you won't see characters appear. That's normal and a security feature, not a broken keyboard.
- `flutter doctor` legend: `[✓]` = good, `[!]` = warning (works partly), `[✗]` = broken. You only need ✓ on the **platform you actually build for**. For this project that's only **Chrome — develop for the web**.
- Mac chip architectures: **arm64** = Apple Silicon (M1/M2/M3/M4). **x86_64** = older Intel Macs. Flutter handles both, but knowing yours helps when reading install instructions.
- Official VS Code extensions for Flutter are both published by **"Dart Code"**. Check the publisher name when installing extensions to avoid look-alikes.

### Phase 0 — Done ✓

What we have working:
- Flutter 3.44.1, Dart 3.12.1, web target enabled, Chrome detected as a run device.
- VS Code with Dart + Flutter extensions installed.

What we're choosing to ignore (for now):
- Android toolchain (we're not building Android apps).
- Xcode / CocoaPods (we're not building iOS/macOS native apps).

---

## Phase 1 — Dart in tiny bites

Ran four small programs in `~/dart-sandbox/hello.dart`. Each program built on the previous one.

### Vocabulary

- **File extension** — the bit after the last dot in a filename. Dart code goes in `.dart` files.
- **Statement** — one instruction. Each one ends with a semicolon `;` (like a period in English).
- **String** — text wrapped in quotes. `'single'` or `"double"` — both work in Dart.
- **Variable** — a named box that holds a value.
- **`final`** — a variable that won't be reassigned after it's set. Default choice in most Dart/Flutter code.
- **Assignment** (`=`) — put the value on the right into the box on the left. NOT "equals" in the math sense.
- **String interpolation** — using `$name` (or `${name.property}` for anything fancier) inside a string to insert a value.
- **Function** — a named, reusable block of instructions. Defined once, called many times.
- **Parameter** vs **argument** — same value, different perspective. Parameter = what the function asks for (named slot in the definition). Argument = what you actually pass when calling.
- **Named arguments** — passed with a label, like `greet(name: 'Alia')`. The parameters in the definition are wrapped in `{ ... }`. Required for Flutter — used everywhere.
- **`required`** in a named parameter — "you must pass this when calling."
- **Default value** — `String greeting = 'Hello'` — if no argument is passed, use this.
- **Class** — a blueprint that defines the shape of a kind of thing (its fields, what it can do).
- **Instance** — an actual concrete thing created from a class.
- **Field** — a variable that belongs to instances of a class. Declared at the top of the class body with a type.
- **Constructor** — a special function that creates new instances. Same name as the class.
- **`this.name`** in a constructor — shorthand for "take the named arg and assign it into the field of the same name."
- **Dot access** — `instance.fieldName` reaches into an instance to read a field.

### Templates worth remembering

```dart
// 1. Every Dart file starts here:
void main() {
  // your code
}

// 2. Variable:
final name = 'Alia';

// 3. Function with named arguments (Flutter-style):
void greet({required String name, String greeting = 'Hello'}) {
  print('$greeting, $name!');
}

// Call it:
greet(name: 'Alia');                          // uses default greeting
greet(name: 'Alia', greeting: 'Welcome');     // overrides greeting

// 4. Class with a constructor:
class Project {
  final String name;
  final String description;

  Project({required this.name, required this.description});
}

// Create an instance:
final tasmi = Project(name: 'Tasmi', description: 'A memorization app.');

// Read a field:
print(tasmi.name);
```

### Rules of thumb

- **Class names use PascalCase** (`Project`, `ServiceCard`); variable and function names use camelCase (`projectName`, `greet`). Dart's auto-formatter and analyzer will warn you if you mix these up.
- **No `new` keyword** — to create an instance, just write `Project(...)`, never `new Project(...)`. Old Dart used `new` but it's gone.
- **Default to `final`.** Reach for non-final variables only when you genuinely need to reassign.
- **Every Flutter widget is a class.** When you write `Text('Hello')`, you are creating an instance of the `Text` class. When you write `SizedBox(height: 16)`, you are calling `SizedBox`'s constructor with a named argument. You already know how to read both.

---

## Phase 2 — Flutter mental model

Three ideas that explain how Flutter works:

1. **Everything is a widget.** Text, padding, a button, a list, the entire page — all widgets. UIs are built by **nesting widgets inside other widgets**.
2. **The widget tree.** Your UI is a tree (or Russian doll). One root widget contains children, each child can contain more children. Reading Flutter code is reading this tree top-down.
3. **You describe, Flutter reconciles.** You write a `build()` method that returns a widget tree describing the current shape. Flutter calls `build()` whenever something changes and figures out the minimal update to the screen. You never touch pixels directly.

---

## Phase 3 — Scaffold the Flutter project

Generated the project files with:

```bash
flutter create --platforms web --org com.codedancoffee --project-name codedancoffee_portfolio .
```

The `.` at the end means "create in the current folder." Flutter project names must be lowercase with underscores (not dashes), so we override the default with `--project-name`.

### Folder/file map of a Flutter project

| What | Touch a lot? | What it is |
|---|---|---|
| `lib/` | **Yes** | Your code lives here. |
| `pubspec.yaml` | Sometimes | Project's instruction sheet: name, version, dependencies (packages). |
| `web/` | Sometimes | Web-specific shell: `index.html`, favicon, manifest. |
| `analysis_options.yaml` | Rarely | Static-analysis rules. Default is fine. |
| `test/` | Won't | Auto-tests folder. Skipping for this project. |
| `.dart_tool/`, `.metadata`, `pubspec.lock` | Never | Auto-managed. Don't edit. |
| `.idea/`, `*.iml` | Delete | IntelliJ leftovers; safe to remove if you use VS Code. |

### Minimal `lib/main.dart`

Stripped down to a blank canvas you can build on:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'codedancoffee',
      home: Scaffold(
        body: Center(
          child: Text('codedancoffee portfolio'),
        ),
      ),
    );
  }
}
```

### New Flutter shapes from this file

- `import 'package:flutter/material.dart';` — every Flutter file starts with this.
- `runApp(rootWidget)` — Flutter's entry point. Called once, from `main`.
- `extends StatelessWidget` — defines a widget that doesn't change on its own. Default choice.
- `const MyWidget({super.key})` — standard widget constructor. The `super.key` is plumbing; just include it.
- `@override` — annotation; says "I'm replacing the parent's method." Always write it on `build`.
- `Widget build(BuildContext context)` — the method Flutter calls to ask "what should you look like right now?" You return a widget tree.
- **MaterialApp** = app-level root (title, theme, routing).
- **Scaffold** = page skeleton with slots (`body`, `appBar`, `floatingActionButton`, etc).
- **Center** = layout widget that centers its single `child`.
- **Text(string)** = displays text.
- Widgets nest via named arguments (`home:`, `body:`, `child:`). Reading the indentation IS reading the widget tree.

### Hot reload, hot restart, and re-running

- `flutter run -d chrome` starts the app and stays running, watching for changes.
- **Hot reload** (`r` in terminal, or save the file in VS Code) — small, incremental update. Keeps app state. Use 99% of the time.
- **Hot restart** (`R` in terminal) — wipes app state and restarts. Use when something looks broken after several reloads.
- The `flutter run` process dies when the terminal closes or your Mac sleeps for a long time. If Chrome stops updating when you save, restart it with `flutter run -d chrome` again.

---

## Phase 4 — Data foundation

Two files capture the studio's content separately from the UI:

- `lib/data/models.dart` — the **shapes**: `Service` and `Project` classes. Pure structure, no data.
- `lib/data/content.dart` — the **data**: instances of those classes with all the actual text.

### Shapes that showed up

- `import 'models.dart';` — relative import for a file in the same folder.
- **Top-level constants** — declared outside any class/function, importable from any file that imports yours.
- **Typed list literal** — `<Service>[Service(...), Service(...)]`. The `<Service>` constrains the type of every item.
- **Const context** — inside a `const` declaration, nested constructor calls are automatically `const`; you don't have to write `const` over and over.
- **Three flavors of named parameter:** `required this.x` (must pass), `this.x = default` (optional with fallback), `this.x` on a nullable type (defaults to null).

---

## Phase 5 — Colors, fonts, and theme

The visual identity lives in three files under `lib/theme/`:

| File | Holds |
|---|---|
| `app_colors.dart` | Coffee-themed palette as top-level `Color` constants: `cream`, `foam`, `espresso`, `cocoa`, `latte`, `matcha`, `caramel`, `peach`, `vanilla`. |
| `app_typography.dart` | TextStyle constants using `google_fonts`: `displayLarge/Medium/Small` (Fraunces serif), `bodyLarge/Medium` (Plus Jakarta Sans), `labelLarge`. |
| `app_theme.dart` | `buildAppTheme()` — returns a `ThemeData` combining the colors and text styles into the app's design system. |

### Shapes that showed up

- **`Color(0xFFRRGGBB)`** — Flutter's color from hex. `0xFF` prefix = fully opaque.
- **Package import** — `import 'package:google_fonts/google_fonts.dart';` (not relative — packages live outside your folder).
- **`flutter pub add <package>`** — adds a package to `pubspec.yaml` and downloads it. Don't edit `pubspec.yaml` by hand.
- **`TextStyle`** — bundle of typography settings. Common fields: `fontSize`, `fontWeight`, `height` (line-height multiplier), `letterSpacing`, `color`, `fontFamily`.
- **`FontWeight.wN`** — N is 100/200/.../900. Common picks: 400 regular, 500 medium, 600 semibold, 700 bold.
- **`GoogleFonts.fontName(...)`** — function that returns a TextStyle pre-wired with that font.
- **`ThemeData`** — Flutter's app-wide design bundle. Set once at `MaterialApp(theme: ...)` and every widget reads from it.
- **`ColorScheme.fromSeed(seedColor: x)`** — generates a Material 3 palette from a single base color.
- **`TextTheme`** has named slots: `displayLarge/Medium/Small`, `headlineLarge/Medium/Small`, `titleLarge/Medium/Small`, `bodyLarge/Medium/Small`, `labelLarge/Medium/Small`. Plain `Text('foo')` defaults to `bodyMedium`.

### Rules of thumb

- Name colors by what they ARE (`espresso`, `latte`), not by where you'll use them (`buttonColor`).
- Name text styles by ROLE (`displayLarge`, `bodyMedium`), not by literal size (`text32`). Lets you re-tune one place.
- After `flutter pub add`, press capital **`R`** in the run terminal — hot reload isn't enough; you need a hot restart to pick up new packages.

---

## Phase 6 — Layout primitives cheat sheet

| Widget | Use it for |
|---|---|
| **Column** | Stack things vertically (top→bottom). |
| **Row** | Stack things horizontally (left→right). |
| **Padding** | Inset its single child from the parent's edges. |
| **SizedBox** | Fixed-size box. Often used empty with just `height:` or `width:` as a gap between siblings. |
| **Container** | Padding + background + border + rounded corners all on one widget. Use when you need decoration. |
| **Center** | Centers its single child both axes. |
| **Spacer** | Invisible flexible space inside Row/Column — pushes siblings apart. |
| **Expanded** | Inside Row/Column — takes a share of remaining space. Multiple Expandeds split it. |
| **Wrap** | Like Row, but children flow to a new line when they overflow. Perfect for grids and tag chips. |
| **Stack + Positioned** | Overlap things. We haven't used this yet but it's there for badges/overlays. |
| **SingleChildScrollView** | Vertical scroller wrapping content taller than the screen. The whole portfolio body is wrapped in one of these. |
| **ClipRRect** | Round the corners of any child. Use with `BorderRadius.vertical(top: Radius.circular(N))` for arches. |

### Alignment words

- **`mainAxisAlignment`** = along the flow direction. **`crossAxisAlignment`** = perpendicular.
- Options on both: `start`, `center`, `end`. mainAxisAlignment also has `spaceBetween`, `spaceAround`, `spaceEvenly`.

### EdgeInsets

- `EdgeInsets.all(16)` — every side.
- `EdgeInsets.symmetric(horizontal: x, vertical: y)` — left/right and top/bottom symmetric.
- `EdgeInsets.only(top: ..., left: ..., ...)` — specific sides.
- `EdgeInsets.fromLTRB(L, T, R, B)` — left, top, right, bottom.

---

## Phase 7 — Nav bar

Lives at `lib/sections/nav_bar.dart`. Structure: `Padding(Row(logo, Spacer, nav-Row, Spacer, icons))`. Two `Spacer()` widgets keep the nav-link group centered while pinning logo left and socials right.

### New shapes that showed up

- **Relative imports up a folder**: `import '../data/content.dart';` reaches `lib/data/content.dart` from `lib/sections/`.
- **`Spacer()`** — invisible flexible space. With two of equal weight, splits the leftover 50/50, centering whatever's between them.
- **`MainAxisSize.min`** on a nested Row/Column — "shrink to fit my children" instead of filling the parent. Required for Spacers to work around the nested group.
- **`IconButton`** + `Icons.foo` + `tooltip:` — clickable Material icon with hover tip. Flutter ships hundreds of icons (browse fonts.google.com/icons).
- **`TextButton`** + `TextButton.styleFrom(foregroundColor: ..., textStyle: ...)` — clickable text label with custom color/typography.
- **Private widgets** — `class _NavLink` (leading underscore) is file-private. Use for small helpers only the current file needs.

---

## Phase 8 — Hero section

Lives at `lib/sections/hero.dart`. Class is `HeroSection` (NOT `Hero` — Flutter has a built-in `Hero` widget for navigation transitions; avoid name collision). Splits into private `_HeroText` (left) and `_HeroArch` (right) for readability.

### New shapes that showed up

- **`Expanded(child: ...)`** inside Row/Column — claims a share of remaining space. Two Expandeds = 50/50.
- **`Container(decoration: BoxDecoration(...))`** — the "I need a styled box" combo. `BoxDecoration` holds `color`, `borderRadius`, `border`, `boxShadow`, `gradient`, `image`.
- **`BorderRadius.circular(100)`** — round all corners. If the value exceeds half the height/width, you get a pill shape.
- **`Border.all(color: ...)`** — 1px line on all 4 sides of the decoration.
- **`FilledButton`** + `FilledButton.styleFrom(backgroundColor:, foregroundColor:, padding:, shape:, textStyle:)` — Material 3's solid CTA button.
- **`OutlinedButton`** + `OutlinedButton.styleFrom(foregroundColor:, side: BorderSide(color:), ...)` — outlined CTA.
- **`shape: StadiumBorder()`** — pill / "stadium" rounded shape.
- **`ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(300)), child: ...)`** — arches the top of any child by giving it a huge corner radius.
- **`BoxShape.circle`** — quick circle shape on `BoxDecoration` (no need for `borderRadius`).

### Hero pattern to remember

Most landing-page heroes have the same skeleton: **eyebrow badge → big headline → short body → CTA buttons → visual on the side.** When you build another one, you can copy this file and swap content.

---

## Phase 10–13 — Sections grid (services, portfolio, stats, process)

The four content sections share a skeleton. **Spot the pattern**:

```
SectionName (public widget)
  └─ Padding
       └─ Column (crossAxisAlignment: center)
            ├─ Container (eyebrow pill)
            ├─ SizedBox(width: 720, child: Text)  ← centered heading
            └─ Wrap (the card grid)
                 └─ for-loop generating _SectionCard(...) instances
```

### New shapes that showed up

- **`Wrap`** — Row that breaks to new lines when overflowing. `spacing:` for between cards, `runSpacing:` for between rows. `alignment: WrapAlignment.center` centers each row.
- **Collection-for** in list literals — `[for (int i = 0; i < n; i++) Widget(...)]` or `[for (final x in list) Widget(x)]`. Cleaner than `.map(...).toList()`.
- **Modulo `%`** — `i % colors.length` cycles through a palette regardless of list length.
- **`textAlign: TextAlign.center`** — aligns text inside its own bounds. Different from wrapping in `Center` (which centers the whole widget).
- **Outlined Material icons** — names ending in `_outlined` (e.g., `Icons.smart_toy_outlined`). Thinner, more elegant on pastel backgrounds.
- **`clipBehavior: Clip.antiAlias`** on a rounded Container — required when the child has hard edges that need to follow the rounded corners.
- **String indexing** — `string[0]` returns the first character. `string.length` for length. `string.substring(start, end)` for slicing.
- **Records (Dart 3)** — anonymous bundles. Named flavor: `(name: 'x', value: 12)`, access with `.name`. Type annotation: `({String name, int value})`. Use for one-off inline data; reach for a class when reused.
- **`MainAxisAlignment.spaceBetween`** — push children to the edges, no outer gap. Useful for "thing on left, thing on right" rows.
- **`BoxShape.circle`** on `BoxDecoration` — perfect circle without `borderRadius` (Container must be square).

---

## Phase 14 — Contact + footer

Two short files. Contact is a **dark espresso card** for visual contrast against all the cream above. Footer is a thin row.

### New shapes

- **Dark sections for visual rhythm** — most of the page is light, the CTA section flips it. Same widget skeleton, just inverted colors (`color: espresso` on Container, `color: cream` on text).
- **`async` / `await` inside event handlers** — `onPressed: () async { await launchUrl(uri); }`. Let the OS handle long operations without blocking the UI.
- **`Uri.parse('mailto:foo@bar.com')` + `launchUrl(uri)`** — standard "open external link" pattern via the `url_launcher` package. Works for `https://`, `mailto:`, `tel:`.
- **Quote style trick** — pick the quote style that avoids escaping. `"Let's"` is cleaner than `'Let\'s'`.

### Rule of thumb

- After `flutter pub add`, **always press capital `R`** in the run terminal. Hot reload (`r`) doesn't load new packages.

---

## Phase 15 — Smooth-scroll nav links

Two-piece pattern for "click a nav link, page scrolls to that section":

1. Define a **GlobalKey per section** in a shared file (`lib/section_keys.dart`).
2. Pass each key into the matching section via the `key:` parameter — every widget accepts a key because constructors take `super.key`.
3. In nav links, call **`Scrollable.ensureVisible(key.currentContext!, duration: ..., curve: ..., alignment: 0.0)`** when tapped.

Flutter walks up from the target widget's context, finds the nearest scrollable (our `SingleChildScrollView`), and animates the scroll position.

### New shapes that showed up

- **`GlobalKey`** — stable widget identifier that survives rebuilds. Used to reach a widget from somewhere else in the tree.
- **`key.currentContext`** — the BuildContext of the widget the key is attached to. Can be null if the widget isn't mounted; always null-check.
- **`Scrollable.ensureVisible(ctx, alignment: 0.0)`** — scroll the nearest enclosing scrollable so `ctx`'s widget is in view. `alignment: 0.0` = top of viewport, `1.0` = bottom.
- **`Duration(milliseconds: 600)`** + **`Curves.easeInOutCubic`** — standard nice scroll animation.
- **Arrow-function shorthand** — `() => doSomething()` instead of `() { doSomething(); }`. Heavily used in callbacks.

### Why `const` had to come off

Passing a runtime `GlobalKey` into `HeroSection(key: heroKey)` makes that widget non-const. Anything wrapping it (Column, Scaffold, etc.) also becomes non-const. `const` cascades from leaves up to roots — break one leaf, lose const on the path. Trade a tiny perf cost for the wiring you need.

---

## Phase 9 — Responsive layout

**The pattern**: same widget tree everywhere, **branched parameters**, decided by `isMobile(context)`.

```dart
final mobile = isMobile(context);
return Padding(
  padding: EdgeInsets.symmetric(
    horizontal: mobile ? 24 : 48,
    vertical: mobile ? 64 : 96,
  ),
  child: mobile ? Column(children: kids) : Row(children: kids),
);
```

No separate "mobile app." The same code adapts.

### Files involved

- `lib/widgets/responsive.dart` — `Breakpoints` constants + `isMobile`/`isTablet` helpers + a `cardWidth(context)` helper that computes 1-column / 2-column / fixed-max based on viewport.
- Every section reads from these helpers in its `build()`.
- `nav_bar.dart` — desktop: inline nav + socials. Mobile: hamburger that opens a `Drawer`.
- `hero.dart` — desktop: Row(text | arch). Mobile: Column(text → arch).

### New shapes that showed up

- **`MediaQuery.sizeOf(context)`** — cheaper than `MediaQuery.of(context).size` because it only rebuilds on size changes, not every MediaQuery change.
- **`Breakpoints` class with `static const`** — central place to change the threshold across the app.
- **`isMobile(context)` helper** — one-line boolean. Use inline anywhere in a build method.
- **`mobile ? Column(...) : Row(...)`** — ternary picks the parent widget.
- **Collection-if**: `[if (cond) Widget(...), ...moreWidgets]` — conditionally include items in a list literal.
- **Spread in list literals**: `[...firstList, ...secondList]` — flatten lists into one.
- **`Drawer`** + **`Scaffold(endDrawer: ...)`** + **`Scaffold.of(context).openEndDrawer()`** — the hamburger pattern. Scaffold owns the drawer; a button below it opens it via context.
- **`Navigator.of(context).pop()`** — close the top-most overlay (drawer, dialog, full-screen route).
- **`SafeArea`** — keeps content out of the notch / status bar / home indicator on phones. Wrap drawer/dialog content.
- **`ListTile(title: ..., onTap: ...)`** — standard Material list row with built-in padding + ripple. Perfect for menu items.

### Rules of thumb

- **Build mobile-first when you can.** It forces you to prioritize content. Then enhance for wider screens.
- **`MediaQuery.sizeOf(context).width`** is the only thing you usually need. Reach for `LayoutBuilder` only when you need the **parent's** size, not the viewport's.
- **Pass widths as parameters down to leaves** (`_ServiceCard(width: w, ...)`). Don't reach for `MediaQuery` in every nested widget — pass it down explicitly.

---

## Phase 16 — Deploy

### `flutter build web --release`

- Compiles the app into static HTML/JS/CSS in `build/web/`.
- `--release` = optimized production build (smaller, no debug banner). `--debug` is what `flutter run` uses.
- Output is ~25 MB total. The `build/` folder is gitignored — rebuild before each deploy.

### Things to fix BEFORE deploying

1. **`web/index.html`** — update `<title>` (browser tab + Google results), `<meta name="description">` (Google snippet + social shares), and `<meta name="apple-mobile-web-app-title">` (iOS home-screen title).
2. **`flutter build web --base-href "/subpath/"`** — only needed if hosting under a subdirectory (like GitHub Pages). Skip for root-domain hosting like Netlify.

### Netlify Drop (easiest path)

1. `flutter build web --release`
2. Open `https://app.netlify.com/drop`
3. Drag the entire `build/web` folder onto the page
4. Get a random URL like `https://gentle-eclair-12abc.netlify.app`

Without an account → site expires in ~24 hours. With a free Netlify account, claim the site to keep it forever (and rename the subdomain to something readable).

### Vercel CLI (the path we took)

One-time setup:

1. `npm i -g vercel`
2. `vercel login` — opens a browser device-auth flow.

First deploy (treats `build/web` as a static site, since Vercel doesn't ship Flutter):

```bash
flutter build web --release
cd build/web
vercel
```

Wizard answers: link to existing project? **no** → name → directory `./` → customize settings **no** → additional settings **no**. Vercel uploads the folder, prints a Production URL plus a clean alias (`codedancoffee.vercel.app`), and links the directory to the new project (writes a `.vercel/` folder).

Re-deploys after that are one command:

```bash
flutter build web --release && cd build/web && vercel --prod
```

`--prod` pushes straight to the aliased URL. Without it, you get a fresh preview URL — handy for testing before promoting.

---

## Phase 17 — Custom image assets

Swapped the hero's `Icon(Icons.coffee_outlined, ...)` for the studio logo PNG. Three-step rhythm for any image asset:

1. **Drop the file in `assets/images/`** at the project root (convention — Flutter has no enforced location; this just keeps things tidy).
2. **Declare it in `pubspec.yaml`** under `flutter > assets:`:
   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/images/logo.png   # one file
       # - assets/images/         # OR the whole folder, trailing slash
   ```
3. **Use `Image.asset('assets/images/logo.png', width: ..., fit: BoxFit.contain)`** in code. Path must match the pubspec entry exactly.

### New shapes that showed up

- **`Image.asset(path, width:, height:, fit:)`** — the standard widget for bundled images.
- **`BoxFit`** — how the image scales inside its given box:
  - `contain` — fit fully inside, no crop, may letterbox.
  - `cover` — fill the box, crop excess. Good for background photos.
  - `fill` — stretch to fill, ignores aspect ratio (avoid unless intentional).
- **No `color:` on `Image.asset` by default** — it paints actual pixels from the file, not a tintable glyph like `Icon`.

### Rules of thumb

- **`const` cascades from leaves up.** `Image.asset(...)` is not a const constructor (reads a file at runtime), so the moment one child loses `const`, every parent on its path has to drop `const` too. Watch for analyzer hints when this happens.
- **For logos, prefer a transparent PNG** so the image's background doesn't fight the surface it's placed on. SVG support exists via the `flutter_svg` package if you want crisp scaling.
- **Flutter web: new asset declarations need a full `flutter run` restart, NOT a hot restart.** The asset manifest is generated when the dev server starts up; capital `R` re-runs Dart but doesn't regenerate the manifest. If you get "Unable to load asset" after declaring it correctly, press `q` to quit and re-run `flutter run -d chrome`. (Mobile is more forgiving — hot restart usually works there.)

### What's worth doing next on the deploy side

- **Custom subdomain**: Netlify dashboard → Site settings → rename to `codedancoffee.netlify.app`.
- **Custom domain**: if you own `codedancoffee.com`, point it at Netlify in DNS settings.
- **GitHub auto-deploy**: push code to a GitHub repo, connect it to Netlify, and each `git push` rebuilds the site automatically. No more drag-drop.
- **Lighthouse**: in Chrome DevTools → Lighthouse tab → Run for "Performance" + "Accessibility." Flutter web typically gets ~85-95 on Performance after first paint — expected.

---

## Project complete — what you actually built

`lib/` layout:

```
main.dart              — app entry, Scaffold, drawer mount, section composition
section_keys.dart      — shared GlobalKeys for scroll-to-section
data/
  models.dart          — Service, Project classes
  content.dart         — studio info, 5 services, 7 projects, copyright
theme/
  app_colors.dart      — coffee palette as Color constants
  app_typography.dart  — Fraunces + Plus Jakarta Sans text styles
  app_theme.dart       — ThemeData wiring colors + typography
widgets/
  responsive.dart      — breakpoints + helpers
sections/
  nav_bar.dart         — NavBar + NavDrawer
  hero.dart            — HeroSection + _HeroText + _HeroArch
  services.dart        — ServicesSection + _ServiceCard
  portfolio.dart       — PortfolioSection + _ProjectCard
  stats.dart           — StatsSection + _StatTile
  process.dart         — ProcessSection + _ProcessCard
  contact.dart         — ContactSection
  footer.dart          — FooterSection
```

Patterns you'd reuse on the next Flutter project:
- Theme = colors file + typography file + theme file wiring them in `MaterialApp(theme:)`
- Section pattern = `Padding > Column > eyebrow + heading + Wrap of cards`, repeated
- Private `_FooCard` widgets keep the public section class readable
- Records for one-off inline data (stats, process steps); classes for data that crosses files (Service, Project)
- Responsive via `isMobile(context)` + ternaries — no separate codebase

---


