# Multilingual
#### An automatic language loading system

Allows you to define multiple languages without converting and dealing with RAGE formats

## How to use

Included is an **Excel** file (`.xlsx`)

Import that file into an editor, like **Excel** or **Google Spreadsheets**

Once you are done, save the file then import the file into http://beautifytools.com/excel-to-json-converter.php

The output can be put into the **`lang.json`** file

Make sure to add the `lang.json` file as a `file` entry in your resource manifest!

Add `lang.lua` as a client script

## Technicalities

Language name is based on the sheet name, `american` is the default English game language and **must be present**.
Other languages can be ignored.

Language names can be found in the FiveM Native Reference: https://runtime.fivem.net/doc/natives/?_0x2BDD44CC428A7EAE

The game client loads the corresponding language automatically based on client settings.
If the language is not defined, it just uses `american`.

**`A1`** must be `LABEL`
**`B1`** must be `ORIGINAL`
**`C1`** must be `TRANSLATION`

Col **`A`** is reserved for the label entry, like `LANG_SELECT`
Col **`B`** is used for the "original" entry, code ignores it
Col **`C`** is used for the translation, this is what is shown in-game for that label

### Example

#### "american" sheet

|   |      A      |        B        |        C        |
|---|:-----------:|:---------------:|:---------------:|
| 1 | LABEL       | ORIGINAL        | TRANSLATION     |
| 2 | LANG_SELECT | Select Language | Select Language |
| 3 | LANG_APPLY  | Apply           | Apply           |

#### "spanish" sheet

|   |      A      |        B        |           C          |
|---|:-----------:|:---------------:|:--------------------:|
| 1 | LABEL       | ORIGINAL        | TRANSLATION          |
| 2 | LANG_SELECT | Select Language | Seleccione el idioma |
| 3 | LANG_APPLY  | Apply           | Aplicar              |
