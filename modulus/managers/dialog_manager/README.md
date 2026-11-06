# Dialog Manager - Maximilian Volt's Modulus Engine

## Startup guide

### 0. MODULE GENERALITIES

The Dialog Manager provides a common way to compose, store, and resolve dialog data, with extension points for game-specific effects. It can be used for any dialog, be it HUD elements or narrative text. The manager provides enough data for any use but it does **not** render textboxes or decide how your game presents a line; your game reads the dialog data and handles presentation on its own.

The script uses bitmasks to pack multiple independent settings into one integer. Each setting group occupies its own bit region, so a dialog can carry, for example, both a speaker and an emotion without separate positional arguments for every property. The encoders place values in their correct regions, and the accessors decode them later. This keeps composed data compact and makes it straightforward to combine independent settings with bitwise OR.

- Values within a setting group that represents alternatives (such as speaker or emotion) are mutually exclusive: select one value from that group.
- Flag settings, such as effect triggers, can be combined when the flags are intended to apply together.
- Use the provided encoders and accessors; do not calculate or edit bit shifts yourself.

**Example**: assume `SPEAKER_NPC` and `EMOTION_HAPPY` have been added as enum members; you can then combine:

```js
var _spk_npc = Dialog.encodespeaker(DIALOG.SPEAKER_NPC);
var _emt_happy = Dialog.encodeemotion(DIALOG.EMOTION_HAPPY);

// Each encoder selects a separate bit region, so these settings can be combined.
var _settings_mask_npc_happy = _spk_npc | _emt_happy;
```

### 1. RECOMMENDED PRELIMINARY STEPS

The enums define the values accepted by the settings encoders. Add game-specific values at the `// ...` placeholders in the corresponding enum.

| Enumerator | Expandable/editable listings | Usage |
| --- | --- | --- |
| `DIALOG_MANAGER` | None recommended | Structure operations, positions, formats, and errors |
| `DIALOG_RUNNER` | None recommended | Dialog advancement settings and runner statuses |
| `DIALOG_SCENE` | `BG_*`, `BGM_*`, `BGS_*`, `TAG_*` | Scene presentation and filtering |
| `DIALOG_SEQUENCE` | `TAG_*` | Sequence filtering |
| `DIALOG` | `SPEAKER_*`, `EMOTION_*`, `ANCHOR_*`, `TEXTBOX_*`, `TAG_*` | Dialog presentation and filtering |
| `DIALOG_FX` | `TYPE_*`, `TRIGGER_*`, `SIGNAL_*`, `TAG_*`, condition and indexer values | Effect behavior and filtering |

> Note:
>
> 1. `TAG_*` values are intended for categorizing and filtering items.
> 2. Do not assign arbitrary explicit values to enum members. The enums contain count and boundary members used to define bit regions and capacities. Let the values be assigned sequentially by the enum.
> 3. Keep each group within the bit width allocated to it. When adding an effect type, also register a function at the matching index in the appropriate FX map; see section 2.1.

Cache frequently used encoded settings in local variables to make composition more readable:

```js
var _spk_npc = Dialog.encodespeaker(DIALOG.SPEAKER_NPC);
var _emt_happy = Dialog.encodeemotion(DIALOG.EMOTION_HAPPY);
var _tag_dialog_hide_portrait = Dialog.encodetag(DIALOG.TAG_HIDE_PORTRAIT);
var _bg_mountains = DialogScene.encodebg(DIALOG_SCENE.BG_MOUNTAINS);
var _fx_trigger_on_enter = DialogFX.encodetrigger(DIALOG_FX.TRIGGER_ON_ENTER);

// Etc...
```

### 2. DIALOG STRUCTURE OPERATIONS

A dialog structure is a hierarchic tree that contains dialog items in a cascading manner: the first child items are scenes; scenes contain sequences; sequences contain dialog lines and dialog lines can contain effects. A dialog line is the smallest container that the runner advances through and effects are the only executed layer in the hierarchy.

To import a structure from serialized data or a file, use:

```js
var _dialog_structure = dialog_structure_import(_data_string, _is_file, _format);
```

Where:

- `_data_string` is either serialized structure data or a file path.
- `_is_file` is `true` when `_data_string` is a path and `false` when it is serialized data.
- `_format` specifies `DIALOG_MANAGER.FORMAT_ARRAY` or `DIALOG_MANAGER.FORMAT_STRUCT`.

#### 2.1. DIALOG EFFECT CREATION

Effects are behavior hooks attached to dialog line items. They are stored as data (settings and arguments); the code that implements their behavior is registered separately in an **FX map**.

An FX map is an indexed registry of functions. When an effect runs, the resolver reads the effect's type and function index, looks up the corresponding function in the selected map, and calls it with the effect arguments and execution context. This keeps executable functions in code while allowing dialog data to be serialized and reused.

The manager provides three maps:

| Map | Purpose |
| --- | --- |
| `DIALOG_FX.MAP_INDEX_NORMAL` | Runs regular effects such as changing game state, playing audio, or updating presentation |
| `DIALOG_FX.MAP_INDEX_CONDITION` | Evaluates whether a conditional flow resolver should run; should return a boolean |
| `DIALOG_FX.MAP_INDEX_INDEXER` | Selects a flow option in a branch; return its zero-based index |

Register callbacks during initialization. `DialogManager.registerfx()` returns the registered function's index; its optional third argument lets you register at a specific index. Keep that index aligned with the corresponding enum value so the effect data looks up the intended function. Normal effect types use the normal map; condition and indexer values use their respective maps.

```js
// Add TYPE_PLAY_SFX to DIALOG_FX at the index used for this normal-map entry.
var _fx_play_sfx_index = DialogManager.registerfx(
  function(_argv, _ctx) {
    audio_play_sound(_argv[0], 0, false);
  },
  DIALOG_FX.MAP_INDEX_NORMAL,
  DIALOG_FX.TYPE_PLAY_SFX
);

// Add FUNC_CONDITION_HAS_KEY at the returned condition-map index.
var _fx_has_key_index = DialogManager.registerfx(
  function(_argv, _ctx) {
    return global.has_key;
  },
  DIALOG_FX.MAP_INDEX_CONDITION,
  DIALOG_FX.FUNC_CONDITION_HAS_KEY
);

// Add FUNC_INDEXER_MEMBER_COUNT at the returned indexer-map index.
var _fx_choice_member_count_index = DialogManager.registerfx(
  function(_argv, _ctx) {
    return global.party.member_count - 1; // Adjusts for 0-indexing
  },
  DIALOG_FX.MAP_INDEX_INDEXER,
  DIALOG_FX.FUNC_INDEXER_MEMBER_COUNT
);
```

The callback receives its stored arguments as `_argv` and a `DialogJumpContextDTO` as `_ctx`. The normal map already contains flow-resolver effect implementations (more on these later). The condition map includes the built-in false and true conditions, and the indexer map includes an indexer that reads the runner's selected choice index. The enum names in this example are illustrative: add them to the indicated enums at the same indices used for registration.

Create a regular effect by combining its type and trigger encodings, then provide any arguments consumed by the registered callback:

```js
var _fx_play_sfx = dialog_fx_create(
  _fx_play_sfx_index | _fx_trigger_on_enter,
  ["door_open"]
);
```

The custom enum names above are examples. Add each one to `DIALOG_FX` at the matching map index; using the returned `_fx_play_sfx_index` here makes the lookup index explicit.

Flow resolver effects are the manager's built-in navigation effects, not custom effects that need a normal-map callback. They let data navigate the structure using flow options:

- `dialog_fx_create_jump()` unconditionally resolves its single destination (similar to a `goto`).
- `dialog_fx_create_dispatch()` evaluates a condition and an indexer, then resolves the selected option if the condition succeeds. Condition is optional and evaluates to `true` if missing (similar to `[if] + switch`).
- `dialog_fx_create_fallback()` evaluates a condition and resolves its single destination when the condition succeeds (similar to `if`).
- `dialog_fx_create_choice()` resolves the option selected by its indexer, commonly the runner's selected choice index (similar to `user_input + switch`).

The manager already provides these resolver implementations in the normal FX map. Register custom callbacks for your game effects and custom condition/indexer behavior; use the flow-resolver constructors for navigation.

#### 2.2. DIALOG ITEMS CREATION

Create a dialog line item with `dialog_create()`, then group dialog items into a sequence and scenes into a structure. Encoded settings are optional; pass an effect list as the third argument to `dialog_create()`.
After creating a list of dialog lines you can then create the parent sequence and the same can be done with scenes. Once all the scenes are created you can then list them inside the dialog structure.
You are free to cache and save references to dialogs, sequences etc. however you'd like.

> It is often useful to store references to sequences and scenes if you're using the dialog manager for Visual Novels or RPGs; if you're storing HUD text you should save the single dialogs.

**Never** place the same item twice in the structure: each item is meant to be uniquely identified by its position and/or ID.

> If you really need the same content and cannot achieve it through managing flow-resolver effects, then simply create a "duplicate" item, which will have different position and IDs assigned to it.

```js
var _speaker = Dialog.encodespeaker(DIALOG.SPEAKER_NARRATOR);
var _emotion = Dialog.encodeemotion(DIALOG.EMOTION_NONE);

var _line_1 = dialog_create("The door opens."              , _speaker | _emotion, [_fx_play_sfx]);
var _line_2 = dialog_create("A narrow passage lies beyond.", _speaker | _emotion                );

var _sequence = dialog_sequence_create([_line_1, _line_2] /*, settings mask, speaker map */);
var _scene = dialog_scene_create([_sequence] /*, settings mask */);
var _dialog_structure = dialog_structure_create("en", [_scene]);
```

Scenes and sequences can also receive settings masks (for example, encoded background or tag values). The encoding methods are `DialogScene.encodebg()`, `DialogScene.encodebgm()`, `DialogScene.encodebgs()`, `DialogScene.encodetag()`, `DialogSequence.encodetag()`, and `Dialog.encodetag()`, along with `Dialog.encodespeaker()`, `Dialog.encodeemotion()`, `Dialog.encodeanchor()`, and `Dialog.encodetextbox()`.

Each structure also carries metadata used by localization and navigation: its language code, the comment prefix used when storing per-item comments, and the bit sizes used to pack scene/sequence/dialog positions into a single link value. Use `_structure.getlang()` / `_structure.setlang(_lang)` to manage the localization context, `_structure.getcommentprefix()` / `_structure.setcommentprefix(_prefix)` to attach comments in a consistent way across translated variants, and `_structure.getlinkencodingsizes()` / `_structure.setlinkencodingsizes([...])` to tune the packed position encoding when your project needs a different bit budget. The structure exposes `generateid()`, `finalize()`, `resetids()`, `getidgeneratormode()`, and `setidgeneratormode()` to control how item ids are assigned and normalized across scenes, sequences, dialogs, and effects.

With `DIALOG_MANAGER.ID_GENERATOR_MODE_PARTITIONED`, IDs encode the hierarchy using four-digit, one-based slots: scene `30001`, sequence `200010001`, dialog `1000100010001`, and its first FX `10001000100010001`. FX IDs use the dialog-level prefix and an additional four-digit integer slot. Scene, sequence, and dialog IDs are safe JSON integers; the 17-digit FX ID is exposed and serialized as a digit string to avoid numeric precision loss. Compare IDs as returned by `getid()` rather than converting string IDs to numbers. Slots are assigned as one greater than the highest matching ID already in the same container, not from the item's array position. Thus inserting an unassigned item in the middle preserves existing IDs and gives the new item the container's next ID. Existing IDs are not renumbered.

#### 2.3. DIALOG ITEMS LINKING

To link any item in the structure you need a start point, an end point and a flow resolver.

Flow resolvers are built-in dialog effects that take care of resolution inside the structure. Flow resolvers (`JUMP`, `DISPATCH`, `FALLBACK`, and `CHOICE`) contain flow options. A flow option describes a destination, jump settings, optional prompt text, and optional metadata. Destinations may be absolute (a linkable item or a `DIALOG_MANAGER.POSITION_CODE_*` value) or relative (a signed shift with a unit such as dialog, sequence, or scene).

To create an option manually, use `DialogFlowOptionDTO.createoption()` and insert the result into the flow resolver. This example creates a choice with two destinations:

```js
var _choice_fx = dialog_fx_create_choice(_fx_trigger_on_leave);

var _question = dialog_create("Which path will you take?", 0, [_choice_fx]);
var _left_path_dialog = dialog_create("You take the left path.");
var _right_path_dialog = dialog_create("You take the right path.");

// Absolute destination
var _absolute = DIALOG_RUNNER.JUMP_OPTION_TYPE_ABSOLUTE;
var _left_option = DialogFlowOptionDTO.createoption(_left_path_dialog, _absolute, "Left");
var _right_option = DialogFlowOptionDTO.createoption(_right_path_dialog, _absolute, "Right");

_choice_fx.insertflowoption(_left_option, 0);
_choice_fx.insertflowoption(_right_option, 1);
```

Alternatively, instead of manually creating and inserting the options above, add them from each destination using `DialogLinkInterface.linkfrom()`. It creates an absolute option targeting that item and inserts it into the supplied flow resolver:

```js
// Can be used for all link items
_left_path_dialog.linkfrom(_choice_fx, "Left", 0);
_right_path_dialog.linkfrom(_choice_fx, "Right", 1);
```

For a conditional dispatch, pass the registered condition and indexer indices to `dialog_fx_create_dispatch()` instead of using a choice resolver:

```js
var _dispatch_fx = dialog_fx_create_dispatch(
  _fx_trigger_on_leave,
  _has_key_index, // Condition function index 
  _membercount_index, // Indexer function index
  undefined, // Condition callback arguments
  undefined, // Indexer callback arguments
  [_left_option, _right_option]
);
```

For a relative option, pass the signed shift as the destination and a relative unit setting:

```js
var _relative_option = DialogFlowOptionDTO.createoption(
  +2,
  DIALOG_RUNNER.JUMP_OPTION_UNIT_SEQUENCE,
  "Skip two sequences going forward"
);
```

The option index is the index returned by the flow resolver's indexer. The default choice indexer uses a runner's built-in variable, change it with `_dialog_runner.setchoiceindex(_selected_index)` before the choice is resolved (e.g. in the Step Event before running the advance function). If a condition is `false` or an index returned by an indexer is negative, the effect will fail naturally and not be executed. However all positive indices must be always be validated before being used for resolution.

#### 2.4. EXPORTING A STRUCTURE

To export a structure, use:

```js
var _raw_data = dialog_structure_export(_dialog_structure, DIALOG_MANAGER.FORMAT_STRUCT);
```

Where:

- `_dialog_structure` is the structure to export.
- `_format` specifies `DIALOG_MANAGER.FORMAT_ARRAY` or `DIALOG_MANAGER.FORMAT_STRUCT`.

The export function returns a struct wrapper containing the structure in the requested format. Serialize that result using the format required by your game (for example, JSON).

### 2.5. COMPARING STRUCTURES

Use `dialog_structure_compare()` to check that localized structures keep the same organization: corresponding scenes, sequences, dialogs, and effects should have the same IDs in each language.

The comparator aligns items by ID and reports inserted, deleted, moved, and structurally modified items. It does **not** compare dialog text, check whether a translation is complete, or judge translation quality. Treat it as a structural parity check, and validate the actual localized strings separately. The optional third argument supplies comparison tolerances; when omitted, the default tolerances apply.

### 3. DIALOG RUNNER CREATION

Create one runner for the structure being played:

```js
var _dialog_runner = dialog_runner_create(_dialog_structure);
```

Each runner stores the current dialog link, status flags, choice index, and navigation history. It does not render the current line; use the runner's accessors to retrieve the dialog and present it in your game. More runners can share the same dialog structure.

### 4. DIALOG RUNNER EXECUTION

An **advancement** is a relative jump inside the dialog structure: a signed shift measured in a specified unit. `DialogRunner.advance()` defaults to advancing one dialog. A negative shift moves backward; the unit can instead be a sequence or a scene:

```js
_dialog_runner.advance(); // +1 dialog
_dialog_runner.advance(-1); // -1 dialog
_dialog_runner.advance(2, DIALOG_RUNNER.JUMP_OPTION_UNIT_SEQUENCE); // +2 sequences
_dialog_runner.advance(1, DIALOG_RUNNER.JUMP_OPTION_UNIT_SCENE); // +1 scene
```

The method resolves the relative destination, executes applicable effects, updates the runner's current link and status, and returns the runner. Its remaining arguments can specify the starting link, an effect filter, and arguments passed to effect execution. A zero shift keeps the current dialog and runs its `TRIGGER_ON_STAY` effects:

```js
var _should_advance = _condition();

// If condition is false, then the runner will not advance and all DIALOG_FX.TRIGGER_ON_STAY effects will be executed
_dialog_runner.advance(_should_advance);
```

A **maintainment** is a restriction on a relative jump: it prevents the jump from crossing a specified structure level. For example, maintainment of a sequence while advancing in dialog units allows movement among dialogs in that sequence but stops the jump at the sequence boundary. If the requested destination crosses that boundary, the resolver selects the appropriate edge dialog of the same sequence (last for a positive shift, first for a negative shift). If the runner is already at that edge, the resolved link can remain the same.

Maintaining a level does not execute effects for it does not count as neither leaving nor reaching nor staying in a dialog. For that reason when the resolved jump is maintained, the effects with "normal" triggers are skipped by default. To run either trigger's effects on a maintained jump, include the corresponding `JUMP_SETTING_EXEC_FX_ON_*_IF_MAINTAINED` setting. This is useful for actions such as closing a textbox when an attempted advance reaches the end of a sequence without moving the runner.

For a non-zero shift, the dialog manager resolves any transition as follows:

1. Determine the requested destination relative to the starting link and advancement unit.
2. Execute all matching `DIALOG_FX.TRIGGER_ON_LEAVE` effects on the dialog being left, unless leave effects are bypassed.
3. If a flow resolver runs, it selects or computes a new pending destination. Flow resolvers stop the current FX cycle by default, so later effects in that same cycle are skipped.
4. Execute all matching `DIALOG_FX.TRIGGER_ON_ENTER` effects on the pending destination, unless enter effects are bypassed. A flow resolver here can replace the pending destination too.
5. If a resolver changed the destination, repeat the leave-then-enter cycle from the intermediate destination to the newly selected one. Continue until the pass completes without a flow resolver changing the destination, or a signal stops resolution.
6. Load the final destination and compose the runner's position and execution status flags.

Effects in a trigger cycle run in their stored order. `SIGNAL_STOP_CYCLE` ends that cycle but does not, by itself, cancel the overall transition. Repeat and skip signals adjust which effects run next. `SIGNAL_STOP_RESOLUTION` interrupts transition resolution. Safety thresholds detect effect or jump loops that fail to settle.

When the shift is zero, only the current dialog's `TRIGGER_ON_STAY` effects are considered; no leave/enter transition is performed. Enter, stay, or leave effects can also be bypassed through the jump settings listed in section 5.

Both before and after an advancement, you can use `DialogRunner.getstatusflag()` to test one status flag without manually inspecting or shifting the runner's status mask:

```js
if (_dialog_runner.getstatusflag(DIALOG_RUNNER.STATUS_LAST_OF_SEQUENCE)) {
  // The current runner position converted to dialog is the last one in its sequence.
}

if (_dialog_runner.getstatusflag(DIALOG_RUNNER.STATUS_EXECUTED_CHOICE)) {
  // A choice resolver ran during the latest advancement.
}
```

Status flags include the current position in the structure, the direction of the last advancement, maintained levels, and the type of flow resolver executed.

### 5. ADDITIONAL OPERATIONS

#### Frequently used methods

| Method | Use |
| --- | --- |
| `dialog_structure_create(_lang, _scenes)` | Create a structure and associate its language code. |
| `_structure.getlang()` / `_structure.setlang(_lang)` | Read or change a structure's language. |
| `_structure.getcommentprefix()` / `_structure.setcommentprefix(_prefix)` | Read or change the prefix used for localized comments. |
| `_structure.getidgeneratormode()` / `_structure.setidgeneratormode(_mode)` | Read or change the mode used to generate stable item ids. |
| `_structure.getlinkencodingsizes()` / `_structure.setlinkencodingsizes([...])` | Read or update the bit widths used to encode scene/sequence/dialog positions. |
| `dialog_structure_import(_data, _is_file, _format)` / `dialog_structure_export(_structure, _format)` | Load or serialize a structure. |
| `dialog_structure_compare(_source, _candidate[, _diff_params])` | Compare two structures and return a `DialogDiffResultDTO`. |
| `DialogManager.setidassignmentmode()` | Change whether items should have their IDs assigned on creation or structure finalization. Assignment on finalization will not allow imported items to maintain their ID. |
| `DialogManager.resetitemidcounters()` | Restart automatic ID counters before building an independent structure. |
| `_result.getsummary()` / `_result.gettree()` | Get comparison severity and the detailed difference tree. |
| `_collection.getitemcount()` / `_collection.getitem(_index)` / `_collection.hasitemsof(_filter)` | Inspect or filter scenes, sequences, dialogs, and effects in a collection. |
| `_link.toscene()` / `_link.tosequence()` / `_link.todialog()` | Convert a link to the corresponding structure level. |
| `_dialog.gettext()` / `_dialog.getid()` / `_dialog.getfx()` | Read a line's text and ID or retrieve its effects. |
| `_runner.getcurrentlink()` / `_runner.advance(...)` / `_runner.getstatusflag(_flag)` | Read the current position, advance, and check runner status. |
| `_runner.setchoiceindex(_index)` / `DialogManager.registerfx(_func, _map, _index)` | Submit a choice or register a custom effect callback. |

`DialogDiffResultDTO.getsummary()` returns a summary whose `getseverity()` is one of `DIFF_SEVERITY_OK`, `DIFF_SEVERITY_WARNING`, or `DIFF_SEVERITY_ERROR`. `gettree()` returns the detailed comparison; its nodes expose paths, operations, and child nodes through methods such as `getpath()`, `getoperation()`, `getitems()`, and `getitemcount()`.

#### `DIALOG_MANAGER.*`

| Option group | Usable members | Purpose |
| --- | --- | --- |
| Levels | `LEVEL_FX`, `LEVEL_DIALOG`, `LEVEL_SEQUENCE`, `LEVEL_SCENE`, `LEVEL_STRUCTURE`, `LEVEL_RUNNER` | Identify the levels used by the manager and runner |
| IDs | `ID_GENERATOR_MODE_AUTOINCREMENTAL` / `ID_GENERATOR_MODE_PARTITIONED` / `ID_ASSIGNMENT_MODE_ON_FINALIZATION` / `ID_ASSIGNMENT_MODE_ON_INSTANTIATION` | Change ID assignment and generation mode |
| Position codes | `POSITION_CODE_SCENE_LAST`, `POSITION_CODE_SCENE_NEXT`, `POSITION_CODE_SCENE_END`, `POSITION_CODE_SCENE_MIDDLE`, `POSITION_CODE_SCENE_START`, `POSITION_CODE_SCENE_PREVIOUS`, `POSITION_CODE_SCENE_FIRST`, `POSITION_CODE_SEQUENCE_LAST`, `POSITION_CODE_SEQUENCE_NEXT`, `POSITION_CODE_SEQUENCE_END`, `POSITION_CODE_SEQUENCE_MIDDLE`, `POSITION_CODE_SEQUENCE_START`, `POSITION_CODE_SEQUENCE_PREVIOUS`, `POSITION_CODE_SEQUENCE_FIRST`, `POSITION_CODE_NONE` | Additional named position targets for dialog links and navigation |
| Formats | `FORMAT_ARRAY`, `FORMAT_STRUCT`, `FORMAT_DEFAULT` | Select serialized structure representation |
| Diff operations | `DIFF_OP_INSERTED`, `DIFF_OP_DELETED`, `DIFF_OP_MOVED`, `DIFF_OP_MODIFIED`, `DIFF_OP_MATCHED` | Classify changes found when comparing structures |
| Diff severity | `DIFF_SEVERITY_OK`, `DIFF_SEVERITY_WARNING`, `DIFF_SEVERITY_ERROR` | Classify the result of a structure comparison |
| Diff tolerances | `DIFF_ARG_TOLERANCE_INSERTIONS_WARNING`, `DIFF_ARG_TOLERANCE_INSERTIONS_MAX`, `DIFF_ARG_TOLERANCE_DELETIONS_WARNING`, `DIFF_ARG_TOLERANCE_DELETIONS_MAX`, `DIFF_ARG_TOLERANCE_MOVES_WARNING`, `DIFF_ARG_TOLERANCE_MOVES_MAX`, `DIFF_ARG_TOLERANCE_MODIFICATIONS_WARNING`, `DIFF_ARG_TOLERANCE_MODIFICATIONS_MAX` | Warning and maximum thresholds for comparison changes |
| Errors | `ERR_UNDEFINED_ERROR_TYPE`, `ERR_INVALID_ARGUMENT_VALUE`, `ERR_INVALID_POSITION`, `ERR_INVALID_CONTAINERIZATION`, `ERR_INVALID_CONTAINER_ACCESS`, `ERR_FAILED_SERIALIZATION`, `ERR_FAILED_DESERIALIZATION`, `ERR_FAILED_PARSING`, `ERR_UNDEFINED_BACKREF_L1`, `ERR_UNDEFINED_BACKREF_L2`, `ERR_EMPTY_CONTAINER_OBJECT`, `ERR_MAX_FX_CAPACITY_REACHED`, `ERR_TEXT_OVERFLOW`, `ERR_INFINITE_JUMP_LOOP_DETECTED`, `ERR_INFINITE_FX_LOOP_DETECTED` | Error identifiers raised by manager operations |
| Error thresholds | `ERRCHECK_JUMP_INFINITE_LOOP_TRESHOLD`, `ERRCHECK_FX_INFINITE_LOOP_TRESHOLD` | Limits used to detect unresolved jump or FX loops |

#### `DIALOG_RUNNER.*`

| Option group | Usable members | Purpose |
| --- | --- | --- |
| History | `HISTORY_MAX_SIZE` | Maximum number of runner positions retained in history |
| Position flags | `STATUS_UNINITIALIZED`, `STATUS_FIRST_DIALOG`, `STATUS_FIRST_SEQUENCE`, `STATUS_FIRST_SCENE`, `STATUS_FIRST_OF_SEQUENCE`, `STATUS_FIRST_OF_SCENE`, `STATUS_MIDDLE_OF_SEQUENCE`, `STATUS_MIDDLE_OF_SCENE`, `STATUS_MIDDLE_SCENE`, `STATUS_LAST_DIALOG`, `STATUS_LAST_SEQUENCE`, `STATUS_LAST_SCENE`, `STATUS_LAST_OF_SEQUENCE`, `STATUS_LAST_OF_SCENE` | Describe the runner's current position in the structure |
| Advancement flags | `STATUS_ADVANCED_DIALOG`, `STATUS_ADVANCED_SEQUENCE`, `STATUS_ADVANCED_SCENE`, `STATUS_RECEDED_DIALOG`, `STATUS_RECEDED_SEQUENCE`, `STATUS_RECEDED_SCENE` | Indicate the direction and level of the latest advancement |
| Maintained flags | `STATUS_MAINTAINED_DIALOG`, `STATUS_MAINTAINED_SEQUENCE`, `STATUS_MAINTAINED_SCENE` | Indicate which structure level was maintained |
| Flow resolver flags | `STATUS_EXECUTED_JUMP`, `STATUS_EXECUTED_DISPATCH`, `STATUS_EXECUTED_FALLBACK`, `STATUS_EXECUTED_CHOICE` | Indicate which flow resolver selected the destination |
| Jump types | `JUMP_TYPE_ABSOLUTE`, `JUMP_TYPE_RELATIVE` | Raw type values; use the `JUMP_OPTION_TYPE_*` settings in flow options |
| Jump units | `JUMP_UNIT_NONE`, `JUMP_UNIT_DIALOG`, `JUMP_UNIT_SEQUENCE`, `JUMP_UNIT_SCENE` | Raw unit values; use `JUMP_OPTION_UNIT_*` settings for relative options |
| Destination type settings | `JUMP_OPTION_TYPE_ABSOLUTE`, `JUMP_OPTION_TYPE_RELATIVE` | Encode the type of flow-option destination |
| Relative unit settings | `JUMP_OPTION_UNIT_DIALOG`, `JUMP_OPTION_UNIT_SEQUENCE`, `JUMP_OPTION_UNIT_SCENE` | Encode the unit used by a relative flow-option destination |
| Effect bypass settings | `JUMP_SETTING_BYPASS_FX_ON_ENTER`, `JUMP_SETTING_BYPASS_FX_ON_STAY`, `JUMP_SETTING_BYPASS_FX_ON_LEAVE` | Bypass effects for the corresponding trigger |
| Maintain settings | `JUMP_OPTION_MAINTAIN_DIALOG`, `JUMP_OPTION_MAINTAIN_SEQUENCE`, `JUMP_OPTION_MAINTAIN_SCENE` | Maintain the specified structure level during a jump |
| Effects on maintained jumps | `JUMP_SETTING_EXEC_FX_ON_ENTER_IF_MAINTAINED`, `JUMP_SETTING_EXEC_FX_ON_STAY_IF_MAINTAINED`, `JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED`, `JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED` | Opt into enter/leave effects when a jump is maintained |
| Jump info | `JUMP_INFO_MAINTAINED` | Internal flow-resolution information indicating a maintained jump |

`JUMP_TYPE_*` and `JUMP_UNIT_*` are raw values, not complete settings masks. Use `JUMP_OPTION_*` and `JUMP_SETTING_*` values when composing flow-option settings.

#### `DIALOG_FX.*`

| Option group | Usable members | Purpose |
| --- | --- | --- |
| Effect types | `TYPE_NONE`, `TYPE_ANY`, `TYPE_DEFAULT`, `TYPE_FLOWRES_JUMP`, `TYPE_FLOWRES_DISPATCH`, `TYPE_FLOWRES_FALLBACK`, `TYPE_FLOWRES_CHOICE`, `TYPE_STATE_MODIFIER`, `TYPE_TEXT_PARSE`, `TYPE_TEXT`, `TYPE_IMAGE`, `TYPE_VIDEO`, `TYPE_BGM`, `TYPE_BGS`, `TYPE_SFX` | Identify effect behavior; add game-specific types and register their normal-map functions |
| Triggers | `TRIGGER_NONE`, `TRIGGER_DEFAULT`, `TRIGGER_ON_ENTER`, `TRIGGER_ON_STAY`, `TRIGGER_ON_LEAVE`, `TRIGGER_ON_MAINTAIN`, `TRIGGER_ON_CUSTOM` | Select when an effect runs; trigger flags may be combined |
| Signals | `SIGNAL_NONE`, `SIGNAL_DEFAULT`, `SIGNAL_REPEAT_CYCLE`, `SIGNAL_REPEAT_PREVIOUS_FX`, `SIGNAL_REPEAT_FX`, `SIGNAL_SKIP_NEXT_FX`, `SIGNAL_STOP_CYCLE`, `SIGNAL_STOP_RESOLUTION` | Return from an effect to control the current cycle or overall resolution |
| Tags | `TAG_NONE`, `TAG_DEFAULT` | Default effect tag; add `TAG_*` values for categorization and filtering |
| FX maps | `MAP_INDEX_NORMAL`, `MAP_INDEX_CONDITION`, `MAP_INDEX_INDEXER` | Select the normal-effect, condition, or indexer function map |
| Conditions | `FUNC_CONDITION_FALSE`, `FUNC_CONDITION_TRUE`, `FUNC_CONDITION_DEFAULT` | Built-in condition indices; the default condition returns true |
| Indexers | `FUNC_INDEXER_RUNNER_CHOICE_INDEX`, `FUNC_INDEXER_DEFAULT` | Built-in indexer indices; the default returns the runner's selected choice index |

Use `DialogFX.encodetype()`, `DialogFX.encodetrigger()`, `DialogFX.encodesignal()`, and `DialogFX.encodetag()` to encode the corresponding settings. `SIGNAL_*` values are mutually exclusive execution results: effects may repeat or skip work, end the current cycle, or stop resolution.

### 6. USEFUL EXAMPLES

The examples below assume `_dialog_runner` is a runner created for a populated structure, and any named custom effect has already been registered in its FX map.

#### Compare two localized structures

The manager assigns IDs automatically. You can override these manually if needed. When working with multiple languages you should maintain the same displacement in every structure. Here, the strings differ but the scene/sequence/dialog structure is the same:

```js
var _line_en = dialog_create("The door opens.");
var _line_fr = dialog_create("La porte s'ouvre.");

var _sequence_en = dialog_sequence_create([_line_en]);
var _sequence_fr = dialog_sequence_create([_line_fr]);

var _scene_en = dialog_scene_create([_sequence_en]);
var _scene_fr = dialog_scene_create([_sequence_fr]);

var _structure_en = dialog_structure_create("en", [_scene_en]);
var _structure_fr = dialog_structure_create("fr", [_scene_fr]);

var _diff = dialog_structure_compare(_structure_en, _structure_fr);

if (_diff.getsummary().getseverity() != DIALOG_MANAGER.DIFF_SEVERITY_OK)
{
  show_debug_message("The localized structures differ.");

  var _tree = _diff.gettree();

  for (var _i = 0; _i < _tree.getnodecount(); ++_i) {
    var _node = _tree.getnode(_i);
    show_debug_message($"{_node.getpath()}: {_node.getoperation().gettype()}");
  }
}
```

The sample's different line text alone does not produce a diff. The tree provides detailed inserted, deleted, moved, or modified nodes when structural differences are found; inspect child nodes with `getitems()` to follow nested differences. You can create tolerance parameters for avoiding error triggering in certain levels. You can specify tolerance parameters by passing an array of arrays of tolerances. Each tolerance has two numbers to signal either a warning difference or an error difference. Tolerances are specified following the indexing provided by `DIALOG_MANAGER.DIFF_ARG_*` options. All undefined arguments default to `0` (the maximum severity will be triggered with any difference).

A nonzero modification tolerance at a level acts as a catch-all for each parent item at that level: its modification count is the sum of the direct child level's statistics, and the child level's severity is suppressed for those changes. The roll-up is global for all parent items, so a sequence tolerance is checked with each sequence. Set both modification tolerances to `0` to leave the child level's severity checks in effect.

```js
var _diff = dialog_structure_compare(_structure_en, _structure_fr, [
  [],     // Dialog FX level params
  [3, 5], // Dialog level params
  [],     // Sequence level params
  []      // Scene level params
]);
```

This example shows a comparison that will tolerate in the French dialog manager at most 5 insertions at dialog level but will still raise a warning if more than 3 are present.

#### Filter and check for specific dialog items

```js
var _current_sequence = _dialog_runner.getcurrentlink().tosequence();

if (_current_sequence.hasitemsof(function(_d) { return _d.hasspeaker(DIALOG.SPEAKER_VILLAIN); })) {
  // The villain will have a dedicated dialog in this sequence
}
```

#### Advance and go back one dialog

The default unit is dialog. Negative shifts move backward:

```js
_dialog_runner.advance(+1);
_dialog_runner.advance(-1);
```

#### Advance or run stay effects

Use the sequence or scene unit to move by containers. A zero shift does not move; it executes the current dialog's `TRIGGER_ON_STAY` effects:

```js
_dialog_runner.advance(+1, DIALOG_RUNNER.JUMP_OPTION_UNIT_SEQUENCE);
_dialog_runner.advance(+1, DIALOG_RUNNER.JUMP_OPTION_UNIT_SCENE);
_dialog_runner.advance(0); // Run ON_STAY effects without changing the current link.
```

#### Jump to a named position with a flow resolver

This jump uses a named absolute destination; the manager resolves the position and updates the runner when the effect is triggered:

```js
var _return_to_first_scene = dialog_fx_create_jump(
  DialogFX.encodetrigger(DIALOG_FX.TRIGGER_ON_LEAVE),
  DialogFlowOptionDTO.createoption(
    DIALOG_MANAGER.POSITION_CODE_SCENE_FIRST,
    DIALOG_RUNNER.JUMP_OPTION_TYPE_ABSOLUTE,
    "Return to the beginning"
  )
);

var _return_to_sequence_start = dialog_fx_create_jump(
  DialogFX.encodetrigger(DIALOG_FX.TRIGGER_ON_LEAVE),
  DialogFlowOptionDTO.createoption(
    DIALOG_MANAGER.POSITION_CODE_SEQUENCE_START,
    DIALOG_RUNNER.JUMP_OPTION_TYPE_ABSOLUTE,
    "Restart sequence"
  )
);
```

#### Keep an advancement inside its sequence

Combine the dialog-unit setting with the sequence maintainment option. Normal movement within the sequence still works; an advancement that would cross the sequence boundary resolves to the edge of the current sequence:

```js
var _advance_within_sequence = DIALOG_RUNNER.JUMP_OPTION_UNIT_DIALOG
  | DIALOG_RUNNER.JUMP_OPTION_MAINTAIN_SEQUENCE
;

_dialog_runner.advance(+1, _advance_within_sequence);
```

#### Skip leave effects for a forced advance

When a scripted transition should not play the current dialog's leave effects, combine the usual relative unit with the bypass flag:

```js
var _silent_dialog_advance = DIALOG_RUNNER.JUMP_OPTION_UNIT_DIALOG
  | DIALOG_RUNNER.JUMP_SETTING_BYPASS_FX_ON_LEAVE
;

_dialog_runner.advance(+1, _silent_dialog_advance);
```

The setting suppresses only `TRIGGER_ON_LEAVE` effects for this advancement; enter effects still run unless their own bypass setting is supplied.

#### Check a status flag before updating presentation

Use `getstatusflag()` to branch on the current runner status without decoding the mask yourself:

```js
if (_dialog_runner.getstatusflag(DIALOG_RUNNER.STATUS_LAST_OF_SEQUENCE)) {
  // Show an end-of-sequence prompt or enable a close action.
}
```

#### Example configuration for autoclosing at the sequence boundary without moving

Assume the current dialog has ordinary `TRIGGER_ON_LEAVE` effects that need to run for the dialog UI. If the runner is at the final dialog of its sequence, this maintained advancement executes that leave effect but resolves back to the same dialog link:

```js
var _advance_and_close_at_sequence_end = DIALOG_RUNNER.JUMP_OPTION_UNIT_DIALOG
  | DIALOG_RUNNER.JUMP_OPTION_MAINTAIN_SEQUENCE
  | DIALOG_RUNNER.JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED
;

_dialog_runner.advance(+1, _advance_and_close_at_sequence_end);
```

Because the leave-effect setting is enabled for maintained jumps, the `TRIGGER_ON_LEAVE` effects run at the boundary. The runner remains on the edge dialog, so the caller can keep or redraw that line after closing its UI. This assumes the effect is not itself a flow resolver that selects a different destination. For working on an autoclose you can detect the maintained sequence:

```js
if (_dialog_runner.getstatusflag(DIALOG_RUNNER.STATUS_MAINTAINED_SEQUENCE)) {
  // Autoclose logic here
}
```

#### Set the selected choice before resolving it

When a choice resolver uses the default runner-choice indexer, store the selected zero-based option index on the runner before advancing. The choice effect then resolves that option:

```js
_dialog_runner.setchoiceindex(1); // Select the second option.
_dialog_runner.advance(+1);
```

The choice effect must be attached to the dialog's appropriate trigger, and its options must be inserted in the same order as the indices presented by the UI. You can retrieve the effects and work with the choice indices before submitting a choice. E.g. (assume the ones used are instance variables):

```js
/// Step Event
current_dialog = runner.getcurrentlink().todialog();
choice = current_dialog.getfxchoice(); // No parameters will retrieve the first choice, if found

if (choice) {
  var _choice_count = choice.getflowoptioncount();
  runner.setchoiceindex(/* ... */); // Clamp or wrap the index
}

runner.advance(_should_advance);
```

For working with choices you can then retrieve the text as follows:

```js
if (!choice)
  return;

var _choice_count = choice.getflowoptioncount();

for (var _i = 0; _i < _choice_count; ++_i) {
  draw_choice(_i, choice.getflowoptionprompt(_i)); // Dedicated logic for drawing a choice
}
```
