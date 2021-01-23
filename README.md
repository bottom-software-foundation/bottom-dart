# Bottom

This is a Dart implementation of [bottom](https://github.com/kaylynn234/bottom).

Bottom encodes UTF-8 text into a sequence comprised of bottom emoji (`🫂✨🥺❤️`, with `,` sprinkled in for good measure) followed by `👉👈`. It can encode any valid UTF-8 — being a bottom transcends language, after all — and decode back into UTF-8.

## Usage

Here's a simple example:

```dart
import 'package:bottom/bottom.dart';

void main(List<String> args) {
  print(bottom.encode(args.join(' ')));
}
```
