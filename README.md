![github-top-lang][lang] ![lic] ![emojis-lic]
# Emojis for Godot

Now compatible with both Godot 3.4+ (version 1.x) and 4.0+ (version 2.x).

This addon provides the following nodes to use emojis in Godot:
- **EmojiIcon**: A node that displays an Emoji.
- **EmojiButton**: A node that displays an Emoji as a button.

Version 2.0 is rewritten to give you access to **EmojisDB** singleton for easier use of emojis anywhere in your project.

It's also adds **IconsFinder** to the Godot's **Tools** menu.
So you can find the emojis easily.

![EmojiFinder Screen Shot](/assets/addons/emojis.png)

## Using it with RichTextLabel

From version 1.3 you can use emojis in RichTextLabel.

This is the example code of using emojis in RichTextLabel:
- [Godot 3.4+ (version 1.x)](https://github.com/rakugoteam/Emojis-For-Godot/blob/godot-3/addons/emojis-for-godot/examples/LabelWithEmojis.gd)
- [Godot 4.0+ (version 2.x)](https://github.com/rakugoteam/Emojis-For-Godot/blob/godot-4/addons/emojis-for-godot/examples/LabelWithEmojis.gd)

This is the result of the above code:

![RichTextLabel Example Screen Shot](/assets/addons/emojis_rtl.png)

## Exporting
For emojis to work in exported projects, you need add `*.json` files to include files settings:
![include files settings](/assets/other/screenshot_export.png)

[**TexturePacker**](https://www.codeandweb.com/texturepacker) is used to generate the emoji atlases.

## Exporting
For emojis to work in exported projects, you need add `*.json` files to include files settings:
![include files settings](screenshot_export.png)

[**TexturePacker**](https://www.codeandweb.com/texturepacker) is used to generate the emoji atlases.

[lic]: https://img.shields.io/github/license/rakugoteam/Emojis-For-Godot?style=flat-square&label=📃%20License&
[lang]: https://img.shields.io/github/languages/top/rakugoteam/Emojis-For-Godot?style=flat-square
[emojis-lic]: https://img.shields.io/badge/license-CC0%201.0-orange.svg?style=flat-square&label=📃%20Emojis%20License&

