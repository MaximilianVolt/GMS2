/**
 * @desc A lightweight, bitmask-focused dialog management system.
 * @link https://github.com/MaximilianVolt/GMS2_scripts/tree/main/modulus/dialog_manager
 * @author @MaximilianVolt
 * @version 0.13.1
 */



#macro __DIALOG_MANAGER_VERSION__                      "0.13.0"
#macro __DIALOG_MANAGER_LINK__                         "https://github.com/MaximilianVolt/GMS2/tree/main/modulus/managers/dialog_manager"

#macro __DIALOG_MANAGER_FIELD_VERSION__                "version"
#macro __DIALOG_MANAGER_FIELD_LINK__                   "link"
#macro __DIALOG_STRUCTURE_FIELD_LANG__                 "lang"
#macro __DIALOG_STRUCTURE_FIELD_LINK_ENCODING_SIZES__  "linkencodingbits"
#macro __DIALOG_STRUCTURE_FIELD_ID_GENERATOR_MODE__    "idgeneratormode"
#macro __DIALOG_STRUCTURE_FIELD_MAX_IDS__              "maxids"
#macro __DIALOG_STRUCTURE_FIELD_COMMENT_PREFIX__       "commentprefix"

#macro __DIALOG_CONTAINER_FIELD_ITEMS__                "items"
#macro __DIALOG_CONTAINER_FIELD_ITEMCOUNT__            "itemcount"
#macro __DIALOG_ITEM_FIELD_COMMENT__                   "comment"
#macro __DIALOG_ITEM_FIELD_SETTINGS__                  "settings"
#macro __DIALOG_ITEM_FIELD_ID__                        "id"
#macro __DIALOG_SEQUENCE_FIELD_SPEAKERS__              "speakers"
#macro __DIALOG_FIELD_TEXT__                           "text"
#macro __DIALOG_FX_FIELD_ARGV__                        "argv"

#macro __DIALOG_DIFF_FIELD_TREE__                      "tree"
#macro __DIALOG_DIFF_FIELD_SUMMARY__                   "summary"
#macro __DIALOG_DIFF_SUMMARY_FIELD_SEVERITY__          "severity"
#macro __DIALOG_DIFF_SUMMARY_FIELD_LEVELS__            "summarylevels"
#macro __DIALOG_DIFF_SUMMARY_FIELD_NODES__             "summarynodes"
#macro __DIALOG_DIFF_SUMMARY_LEVEL_FIELD_PARAM_TYPES__ "types"
#macro __DIALOG_DIFF_TREE_FIELD_DIFFCOUNT__            "diffcount"
#macro __DIALOG_DIFF_TREE_FIELD_DIFFCOUNTSUB__         "diffcountsub"
#macro __DIALOG_DIFF_TREE_FIELD_NODECOUNT__            "nodecount"
#macro __DIALOG_DIFF_TREE_FIELD_NODES__                "nodes"
#macro __DIALOG_DIFF_TREE_NODE_FIELD_STATS__           "stats"

#macro __DIALOG_STRUCTURE_COMMENT_PREFIX_DEFAULT__     "<DEVELOPER COMMENT>"



// ----------------------------------------------------------------------------

#region Lib functions












/**
 * @desc Creates a new instance of DialogRunner with the specified dialog structure.
 * @param {Struct.DialogStructure} _dialog_structure The dialog structure to be used by the runner.
 * @returns {Struct.DialogRunner}
 */

function dialog_runner_create(_dialog_structure)
{
  return DialogRunner.create(_dialog_structure);
}



/**
 * @desc Imports a dialog structure from a string or file, using the specified import format.
 * @param {String} _data_string The string or file path containing the dialog structure data.
 * @param {Bool} [_is_file] Indicates whether the _data_string is a file path (`true`) or a raw string (`false`). Defaults to `false`.
 * @param {Constant.DIALOG_MANAGER} [_import_format] Specifies the format to use for importing the dialog structure. Defaults to `DIALOG_MANAGER.FORMAT_DEFAULT`.
 * @returns {Struct.DialogStructure}
 */

function dialog_structure_import(_data_string, _is_file = undefined, _import_format = undefined)
{
  return DialogImporter.importstructure(_data_string, _is_file, _import_format);
}



/**
 * @desc Exports a dialog structure to a specified format.
 * @param {Struct.DialogStructure} _dialog_structure The dialog structure to be exported.
 * @param {Constant.DIALOG_MANAGER} [_export_format] Specifies the format to use for exporting the dialog structure. Defaults to `DIALOG_MANAGER.FORMAT_DEFAULT`.
 * @returns {Struct}
 */

function dialog_structure_export(_dialog_structure, _export_format = undefined)
{
  return DialogExporter.exportstructure(_dialog_structure, _export_format);
}



/**
 * @desc Compares two dialog structures and returns the differences.
 * @param {Struct.DialogStructure} _dialog_structure_source The source dialog structure.
 * @param {Struct.DialogStructure} _dialog_structure_candidate The candidate dialog structure.
 * @param {Struct.DialogDiffParamGroupDTO} [_diff_param_group] The parameter group for the comparison.
 * @returns {Struct.DialogDiffResultDTO} The result of the comparison.
 */

function dialog_structure_compare(_dialog_structure_source, _dialog_structure_candidate, _diff_param_group = undefined)
{
  return DialogComparator.diff(_dialog_structure_source, _dialog_structure_candidate, _diff_param_group);
}



/**
 * @desc Creates a new instance of DialogStructure with the specified language and optional dialog scene list.
 * @param {String|Real} _lang The language code or identifier for the dialog structure.
 * @param {Array<Struct.DialogScene>} [_dialog_scene_list] The list of dialog scenes to include in the structure. Defaults to an empty list.
 * @returns {Struct.DialogStructure}
 */

function dialog_structure_create(_lang, _dialog_scene_list = undefined)
{
  return DialogStructure.create(_dialog_scene_list, undefined, _lang);
}



/**
 * @desc Creates a new scene with the specified dialog sequence list and optional settings.
 * @param {Array<Struct.DialogSequence>} _dialog_sequence_list The sequences to include in the scene.
 * @param {Constant.DIALOG_SCENE|Real} [_settings_mask] The settings mask for the dialog scene.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog scene.
 * @param {String} [_comment] A comment for the dialog scene.
 * @returns {Struct.DialogScene}
 */

function dialog_scene_create(_dialog_sequence_list, _settings_mask = undefined, _id = undefined, _comment = undefined)
{
  return DialogScene.create(_dialog_sequence_list, _settings_mask, _id, _comment, undefined);
}



/**
 * @desc Creates a new sequence with the specified dialog list and optional settings.
 * @param {Array<Struct.Dialog>} _dialog_list The dialogs to include in the sequence.
 * @param {Constant.DIALOG_SEQUENCE|Real} [_settings_mask] The settings mask for the dialog sequence.
 * @param {Array} [_speaker_list] The list of speakers for the dialog sequence.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog sequence.
 * @param {String} [_comment] A comment for the dialog sequence.
 * @returns {Struct.DialogSequence}
 */

function dialog_sequence_create(_dialog_list, _settings_mask = undefined, _speaker_list = undefined, _id = undefined, _comment = undefined)
{
  return DialogSequence.create(_dialog_list, _settings_mask, _speaker_list, _id, _comment, undefined);
}



/**
 * @desc Creates a new instance of Dialog with the specified text and optional settings.
 * @param {String} _text The text content of the dialog.
 * @param {Constant.DIALOG|Real} [_settings_mask] The settings mask for the dialog.
 * @param {Array<Struct.DialogFX>} [_dialog_fx_list] The list of dialog effects to include in the dialog.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog.
 * @param {String} [_comment] A comment for the dialog.
 * @returns {Struct.Dialog}
 */

function dialog_create(_text, _settings_mask = undefined, _dialog_fx_list = undefined, _id = undefined, _comment = undefined)
{
  return Dialog.create(_text, _settings_mask, _dialog_fx_list, _id, _comment, undefined);
}



/**
 * @desc Creates a new instance of DialogFX with the specified settings.
 * @param {Constant.DIALOG_FX|Real} _settings_mask The settings mask for the dialog effect.
 * @param {Any} [_fx_argv] The arguments for the dialog effect.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog effect.
 * @param {String} [_comment] A comment for the dialog effect.
 * @returns {Struct.DialogFX}
 */

function dialog_fx_create(_settings_mask, _fx_argv = undefined, _id = undefined, _comment = undefined)
{
  return DialogFX.create(_settings_mask, _fx_argv, _id, _comment);
}



/**
 * @desc Creates a new instance of DialogFX with the specified settings for a jump effect.
 * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask for the dialog effect.
 * @param {Array} [_flow_option] The list of flow options for the dialog effect.
 * @param {Any} [_flow_settings] The settings for the flow.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog effect.
 * @param {String} [_comment] A comment for the dialog effect.
 * @returns {Struct.DialogFX}
 */

function dialog_fx_create_jump(_settings_mask = undefined, _flow_option = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
{
  return DialogFX.createjump(_settings_mask, _flow_option, _flow_settings, _id, _comment);
}



/**
 * @desc Creates a new instance of DialogFX with the specified settings for a dispatch effect.
 * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask for the dialog effect.
 * @param {Constant.DIALOG_FX|Real} [_fx_condition_map_idx] The index for the condition map.
 * @param {Constant.DIALOG_FX|Real} [_fx_indexer_map_idx] The index for the indexer map.
 * @param {Any} [_fx_condition_map_argv] The arguments for the condition map.
 * @param {Any} [_fx_indexer_map_argv] The arguments for the indexer map.
 * @param {Array} [_flow_option_list] The list of flow options for the dialog effect.
 * @param {Any} [_flow_settings] The settings for the flow.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog effect.
 * @param {String} [_comment] A comment for the dialog effect.
 * @returns {Struct.DialogFX}
 */

function dialog_fx_create_dispatch(_settings_mask = undefined, _fx_condition_map_idx = undefined, _fx_indexer_map_idx = undefined, _fx_condition_map_argv = undefined, _fx_indexer_map_argv = undefined, _flow_option_list = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
{
  return DialogFX.createdispatch(_settings_mask, _fx_condition_map_idx, _fx_indexer_map_idx, _fx_condition_map_argv, _fx_indexer_map_argv, _flow_option_list, _flow_settings, _id, _comment);
}



/**
 * @desc Creates a new instance of DialogFX with the specified settings for a fallback effect.
 * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask for the dialog effect.
 * @param {Constant.DIALOG_FX|Real} [_fx_condition_map_idx] The index for the condition map.
 * @param {Any} [_fx_condition_map_argv] The arguments for the condition map.
 * @param {Array} [_flow_option] The list of flow options for the dialog effect.
 * @param {Any} [_flow_settings] The settings for the flow.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog effect.
 * @param {String} [_comment] A comment for the dialog effect.
 * @returns {Struct.DialogFX}
 */

function dialog_fx_create_fallback(_settings_mask = undefined, _fx_condition_map_idx = undefined, _fx_condition_map_argv = undefined, _flow_option = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
{
  return DialogFX.createfallback(_settings_mask, _fx_condition_map_idx, _fx_condition_map_argv, _flow_option, _flow_settings, _id, _comment);
}



/**
 * @desc Creates a new instance of DialogFX with the specified settings for a choice effect.
 * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask for the dialog effect.
 * @param {Constant.DIALOG_FX|Real} [_fx_indexer_map_idx] The index for the indexer map.
 * @param {Any} [_fx_indexer_map_argv] The arguments for the indexer map.
 * @param {Array} [_flow_option_list] The list of flow options for the dialog effect.
 * @param {Any} [_flow_settings] The settings for the flow.
 * @param {Constant.DIALOG_MANAGER|Real} [_id] The ID for the dialog effect.
 * @param {String} [_comment] A comment for the dialog effect.
 * @returns {Struct.DialogFX}
 */

function dialog_fx_create_choice(_settings_mask = undefined, _fx_indexer_map_idx = undefined, _fx_indexer_map_argv = undefined, _flow_option_list = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
{
  return DialogFX.createchoice(_settings_mask, _fx_indexer_map_idx, _fx_indexer_map_argv, _flow_option_list, _flow_settings, _id, _comment);
}



/**
 * @desc Creates a new instance of DialogFlowOptionDTO with the specified settings.
 * @param {Array} [_flow_option_list] The list of flow options.
 * @param {Constant.DIALOG_FX|Real} [_fx_condition_map_idx] The index for the condition map.
 * @param {Constant.DIALOG_FX|Real} [_fx_indexer_map_idx] The index for the indexer map.
 * @param {Any} [_fx_condition_map_argv] The arguments for the condition map.
 * @param {Any} [_fx_indexer_map_argv] The arguments for the indexer map.
 * @param {Any} [_flow_settings] The settings for the flow.
 * @returns {Array}
 */

function dialog_flow_option_create(_flow_option_list = undefined, _fx_condition_map_idx = undefined, _fx_indexer_map_idx = undefined, _fx_condition_map_argv = undefined, _fx_indexer_map_argv = undefined, _flow_settings = undefined)
{
  return DialogFlowOptionDTO.create(_flow_option_list, _fx_condition_map_idx, _fx_indexer_map_idx, _fx_condition_map_argv, _fx_indexer_map_argv, _flow_settings);
}












#endregion

// ----------------------------------------------------------------------------

#region Enumerators












/**
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 * @desc `ERR_*` options refer to error codes and can be used to check error types.
 */

enum DIALOG_MANAGER
{
  // Structure levels - MUST START AT 0 FOR ARRAY LEVEL INDEXING
  __LEVELS_ITEM_START = 0,
  LEVEL_FX = DIALOG_MANAGER.__LEVELS_ITEM_START,
  __LEVELS_LINKABLE_START,
  LEVEL_DIALOG = DIALOG_MANAGER.__LEVELS_LINKABLE_START,
  LEVEL_SEQUENCE,
  LEVEL_SCENE,
  __LEVELS_LINKABLE_END,
  __LEVELS_ITEM_END = DIALOG_MANAGER.__LEVELS_LINKABLE_END,
  LEVEL_STRUCTURE = DIALOG_MANAGER.__LEVELS_LINKABLE_END,
  LEVEL_RUNNER,
  LEVELS_COUNT,
  LEVELS_LINKABLE_COUNT = DIALOG_MANAGER.__LEVELS_LINKABLE_END - DIALOG_MANAGER.__LEVELS_LINKABLE_START,
  LEVELS_ITEM_COUNT = DIALOG_MANAGER.__LEVELS_ITEM_END - DIALOG_MANAGER.__LEVELS_ITEM_START,

  // Format codes
  FORMAT_ARRAY = 0,
  FORMAT_STRUCT,
  FORMAT_DEFAULT = DIALOG_MANAGER.FORMAT_STRUCT,

  // ID management
  __ID_SEPARATOR_AUTOINCREMENTAL = 100000000,
  __ID_SEPARATOR_PARTITIONED = 10000,
  __ID_SEPARATOR_PARTITIONED_DIGITS = 4,
  ID_UNASSIGNED = -1,
  ID_GENERATOR_MODE_AUTOINCREMENTAL = 0,
  ID_GENERATOR_MODE_PARTITIONED,
  ID_GENERATOR_MODE_DEFAULT = DIALOG_MANAGER.ID_GENERATOR_MODE_AUTOINCREMENTAL,
  ID_ASSIGNMENT_MODE_ON_FINALIZATION = 0,
  ID_ASSIGNMENT_MODE_ON_INSTANTIATION,
  ID_ASSIGNMENT_MODE_DEFAULT = DIALOG_MANAGER.ID_ASSIGNMENT_MODE_ON_FINALIZATION,

  // Positioning codes
  POSITION_CODE_SCENE_LAST = -14,
  POSITION_CODE_SCENE_NEXT,
  POSITION_CODE_SCENE_END,
  POSITION_CODE_SCENE_MIDDLE,
  POSITION_CODE_SCENE_START,
  POSITION_CODE_SCENE_PREVIOUS,
  POSITION_CODE_SCENE_FIRST,
  POSITION_CODE_SEQUENCE_LAST,
  POSITION_CODE_SEQUENCE_NEXT,
  POSITION_CODE_SEQUENCE_END,
  POSITION_CODE_SEQUENCE_MIDDLE,
  POSITION_CODE_SEQUENCE_START,
  POSITION_CODE_SEQUENCE_PREVIOUS,
  POSITION_CODE_SEQUENCE_FIRST,
  POSITION_CODE_NONE,
  POSITION_CODES_COUNT = 1 - DIALOG_MANAGER.POSITION_CODE_SCENE_LAST,

  // Diff data codes
  DIFF_SEVERITY_OK = 0,
  DIFF_SEVERITY_WARNING,
  DIFF_SEVERITY_ERROR,
  DIFF_SEVERITIES_COUNT,
  DIFF_ARG_TOLERANCE_INSERTIONS_WARNING = 0,
  DIFF_ARG_TOLERANCE_INSERTIONS_MAX,
  DIFF_ARG_TOLERANCE_DELETIONS_WARNING,
  DIFF_ARG_TOLERANCE_DELETIONS_MAX,
  DIFF_ARG_TOLERANCE_MOVES_WARNING,
  DIFF_ARG_TOLERANCE_MOVES_MAX,
  DIFF_ARG_TOLERANCE_MODIFICATIONS_WARNING,
  DIFF_ARG_TOLERANCE_MODIFICATIONS_MAX,
  DIFF_ARG_TOLERANCES_COUNT,

  // Diff operation codes
  DIFF_OP_UNMATCHED = -1,
  DIFF_OP_INSERTED,
  DIFF_OP_DELETED,
  DIFF_OP_MOVED,
  DIFF_OP_MODIFIED,
  __DIFF_OP_STAT_COUNT,
  DIFF_OP_MATCHED = DIALOG_MANAGER.__DIFF_OP_STAT_COUNT,
  DIFF_OPS_COUNT,

  // Position bit partitioning
  __BITMASK_POSITION_DIALOG_SHIFT = 0,
  __BITMASK_POSITION_DIALOG_BITS = 12,
  __BITMASK_POSITION_DIALOG_MASK = (1 << DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_BITS) - 1 << DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_SHIFT,
  __BITMASK_POSITION_SEQUENCE_SHIFT = DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_SHIFT + DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_BITS,
  __BITMASK_POSITION_SEQUENCE_BITS = 9,
  __BITMASK_POSITION_SEQUENCE_MASK = (1 << DIALOG_MANAGER.__BITMASK_POSITION_SEQUENCE_BITS) - 1 << DIALOG_MANAGER.__BITMASK_POSITION_SEQUENCE_SHIFT,
  __BITMASK_POSITION_SCENE_SHIFT = DIALOG_MANAGER.__BITMASK_POSITION_SEQUENCE_SHIFT + DIALOG_MANAGER.__BITMASK_POSITION_SEQUENCE_BITS,
  __BITMASK_POSITION_SCENE_BITS = 10,
  __BITMASK_POSITION_SCENE_MASK = (1 << DIALOG_MANAGER.__BITMASK_POSITION_SCENE_BITS) - 1 << DIALOG_MANAGER.__BITMASK_POSITION_SCENE_SHIFT,

  // Error codes
  ERR_UNDEFINED_ERROR_TYPE = 0,
  ERR_INVALID_ARGUMENT_VALUE,
  ERR_INVALID_POSITION,
  ERR_INVALID_CONTAINERIZATION,
  ERR_INVALID_CONTAINER_ACCESS,
  ERR_FAILED_SERIALIZATION,
  ERR_FAILED_DESERIALIZATION,
  ERR_FAILED_PARSING,
  ERR_UNDEFINED_BACKREF_L1,
  ERR_UNDEFINED_BACKREF_L2,
  ERR_EMPTY_CONTAINER_OBJECT,
  ERR_MAX_FX_CAPACITY_REACHED,
  ERR_TEXT_OVERFLOW,
  ERR_INFINITE_JUMP_LOOP_DETECTED,
  ERR_INFINITE_FX_LOOP_DETECTED,
  ERRS_COUNT,

  // Error checks
  ERRCHECK_JUMP_INFINITE_LOOP_TRESHOLD = 32,
  ERRCHECK_FX_INFINITE_LOOP_TRESHOLD = 256,
}












/**
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 * @desc `STATUS_*` flags refer to possible positioning/execution states of the dialog runner.
 */

enum DIALOG_RUNNER
{
  // Argument positions
  ARG_DIALOG_MANAGER = 0,
  ARGS_COUNT,

  // History
  HISTORY_MAX_SIZE = 16,

  // Status info indices
  __BITMASK_STATUS_SHIFT = 0,
  __BITMASK_FLAG_INDEX_STATUS_UNINITIALIZED = DIALOG_RUNNER.__BITMASK_STATUS_SHIFT,
  __BITMASK_FLAG_INDEX_STATUS_FIRST_DIALOG,
  __BITMASK_FLAG_INDEX_STATUS_FIRST_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_FIRST_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_FIRST_OF_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_FIRST_OF_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_MIDDLE_OF_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_MIDDLE_OF_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_MIDDLE_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_LAST_DIALOG,
  __BITMASK_FLAG_INDEX_STATUS_LAST_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_LAST_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_LAST_OF_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_LAST_OF_SCENE,
  __BITMASK_STATUS_NO_AUTORESET_BITS,
  __BITMASK_FLAG_INDEX_STATUS_ADVANCED_DIALOG = DIALOG_RUNNER.__BITMASK_STATUS_NO_AUTORESET_BITS,
  __BITMASK_FLAG_INDEX_STATUS_ADVANCED_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_ADVANCED_SCENE,
  __BITMASK_FLAG_INDEX_STATUS_RECEDED_DIALOG,
  __BITMASK_FLAG_INDEX_STATUS_RECEDED_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_RECEDED_SCENE,
  __BITMASK_STATUS_MAINTAINED_SHIFT,
  __BITMASK_FLAG_INDEX_STATUS_MAINTAINED_DIALOG = DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_SHIFT,
  __BITMASK_FLAG_INDEX_STATUS_MAINTAINED_SEQUENCE,
  __BITMASK_FLAG_INDEX_STATUS_MAINTAINED_SCENE,
  __BITMASK_STATUS_MAINTAINED_BITS = DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MAINTAINED_SCENE - DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_SHIFT + 1,
  __BITMASK_STATUS_EXECUTED_FLOWRES_SHIFT = DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_SHIFT + DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_BITS,
  __BITMASK_FLAG_INDEX_STATUS_EXECUTED_JUMP = DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_SHIFT,
  __BITMASK_FLAG_INDEX_STATUS_EXECUTED_DISPATCH,
  __BITMASK_FLAG_INDEX_STATUS_EXECUTED_FALLBACK,
  __BITMASK_FLAG_INDEX_STATUS_EXECUTED_CHOICE,
  __BITMASK_STATUS_EXECUTED_FLOWRES_BITS = DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_EXECUTED_CHOICE - DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_SHIFT + 1,
  FLAG_STATUS_COUNT = DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_SHIFT + DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_BITS,
  __BITMASK_STATUS_AUTORESET_COUNT = DIALOG_RUNNER.FLAG_STATUS_COUNT - DIALOG_RUNNER.__BITMASK_STATUS_NO_AUTORESET_BITS,
  __BITMASK_STATUS_NO_AUTORESET_MASK = (1 << DIALOG_RUNNER.__BITMASK_STATUS_NO_AUTORESET_BITS) - 1,
  __BITMASK_STATUS_MASK_AUTORESET = (1 << DIALOG_RUNNER.__BITMASK_STATUS_AUTORESET_COUNT) - 1 << DIALOG_RUNNER.__BITMASK_STATUS_NO_AUTORESET_BITS,
  __BITMASK_STATUS_MAINTAINED_MASK = (1 << DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_BITS) - 1 << DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_SHIFT,
  __BITMASK_STATUS_EXECUTED_FLOWRES_MASK = (1 << DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_BITS) - 1 << DIALOG_RUNNER.__BITMASK_STATUS_EXECUTED_FLOWRES_SHIFT,
  __BITMASK_STATUS_MASK = (1 << DIALOG_RUNNER.FLAG_STATUS_COUNT) - 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT,

  // Status info values
  STATUS_UNINITIALIZED       = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_UNINITIALIZED,
  STATUS_FIRST_DIALOG        = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_FIRST_DIALOG,
  STATUS_FIRST_SEQUENCE      = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_FIRST_SEQUENCE,
  STATUS_FIRST_SCENE         = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_FIRST_SCENE,
  STATUS_FIRST_OF_SEQUENCE   = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_FIRST_OF_SEQUENCE,
  STATUS_FIRST_OF_SCENE      = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_FIRST_OF_SCENE,
  STATUS_MIDDLE_OF_SEQUENCE  = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MIDDLE_OF_SEQUENCE,
  STATUS_MIDDLE_OF_SCENE     = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MIDDLE_OF_SCENE,
  STATUS_MIDDLE_SCENE        = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MIDDLE_SCENE,
  STATUS_LAST_DIALOG         = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_LAST_DIALOG,
  STATUS_LAST_SEQUENCE       = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_LAST_SEQUENCE,
  STATUS_LAST_SCENE          = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_LAST_SCENE,
  STATUS_LAST_OF_SEQUENCE    = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_LAST_OF_SEQUENCE,
  STATUS_LAST_OF_SCENE       = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_LAST_OF_SCENE,
  STATUS_ADVANCED_DIALOG     = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_ADVANCED_DIALOG,
  STATUS_ADVANCED_SEQUENCE   = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_ADVANCED_SEQUENCE,
  STATUS_ADVANCED_SCENE      = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_ADVANCED_SCENE,
  STATUS_RECEDED_DIALOG      = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_RECEDED_DIALOG,
  STATUS_RECEDED_SEQUENCE    = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_RECEDED_SEQUENCE,
  STATUS_RECEDED_SCENE       = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_RECEDED_SCENE,
  STATUS_MAINTAINED_DIALOG   = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MAINTAINED_DIALOG,
  STATUS_MAINTAINED_SEQUENCE = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MAINTAINED_SEQUENCE,
  STATUS_MAINTAINED_SCENE    = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_MAINTAINED_SCENE,
  STATUS_EXECUTED_JUMP       = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_EXECUTED_JUMP,
  STATUS_EXECUTED_DISPATCH   = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_EXECUTED_DISPATCH,
  STATUS_EXECUTED_FALLBACK   = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_EXECUTED_FALLBACK,
  STATUS_EXECUTED_CHOICE     = 1 << DIALOG_RUNNER.__BITMASK_STATUS_SHIFT + DIALOG_RUNNER.__BITMASK_FLAG_INDEX_STATUS_EXECUTED_CHOICE,

  // Jump modes
  JUMP_TYPE_ABSOLUTE = 0,
  JUMP_TYPE_RELATIVE,
  JUMP_TYPES_COUNT,
  JUMP_UNIT_NONE = 0,
  JUMP_UNIT_DIALOG   = DIALOG_RUNNER.JUMP_UNIT_NONE + DIALOG_MANAGER.LEVEL_DIALOG,
  JUMP_UNIT_SEQUENCE = DIALOG_RUNNER.JUMP_UNIT_NONE + DIALOG_MANAGER.LEVEL_SEQUENCE,
  JUMP_UNIT_SCENE    = DIALOG_RUNNER.JUMP_UNIT_NONE + DIALOG_MANAGER.LEVEL_SCENE,
  JUMP_UNITS_COUNT,

  // Jump modes settings indices
  __BITMASK_JUMP_SETTINGS_RESOLUTION_SHIFT = 0,
  __BITMASK_JUMP_SETTINGS_TYPE_SHIFT = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESOLUTION_SHIFT,
  __BITMASK_JUMP_SETTINGS_TYPE_BITS = 1,
  __BITMASK_JUMP_SETTINGS_TYPE_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_SHIFT,
  JUMP_OPTION_TYPE_ABSOLUTE = DIALOG_RUNNER.JUMP_TYPE_ABSOLUTE << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_SHIFT,
  JUMP_OPTION_TYPE_RELATIVE = DIALOG_RUNNER.JUMP_TYPE_RELATIVE << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_SHIFT,
  __BITMASK_JUMP_SETTINGS_UNIT_SHIFT = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_SHIFT + DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_BITS,
  __BITMASK_JUMP_SETTINGS_UNIT_BITS = 2,
  __BITMASK_JUMP_SETTINGS_UNIT_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT,
  __BITMASK_JUMP_SETTING_MODE_BITS = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_BITS + DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_BITS,
  __BITMASK_JUMP_SETTING_MODE_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTING_MODE_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESOLUTION_SHIFT,

  // Jump behaviour settings indices
  __BITMASK_JUMP_SETTINGS_BEHAVIOUR_SHIFT = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESOLUTION_SHIFT + DIALOG_RUNNER.__BITMASK_JUMP_SETTING_MODE_BITS,
  __BITMASK_JUMP_SETTINGS_FX_SHIFT = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_BEHAVIOUR_SHIFT,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_ENTER,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_STAY,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_LEAVE,
  __BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT,
  __BITMASK_JUMP_SETTINGS_FX_BITS = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT - DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_SHIFT - 1,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_ENTER_IF_MAINTAINED = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_STAY_IF_MAINTAINED,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED,
  __BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED,
  __BITMASK_JUMP_SETTINGS_FX_MAINTAINED_BITS = DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED - DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT + 1,
  __BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT + DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_BITS,
  __BITMASK_JUMP_SETTINGS_RESTRICTION_BITS = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_BITS,
  __BITMASK_FLAG_INDEX_JUMP_INFO_MAINTAINED = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT + DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_BITS,
  __BITMASK_JUMP_SETTINGS_BEHAVIOUR_BITS,
  __BITMASK_JUMP_SETTINGS_BEHAVIOUR_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_BEHAVIOUR_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_BEHAVIOUR_SHIFT,
  __BITMASK_JUMP_SETTINGS_RESTRICTION_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT,
  __BITMASK_JUMP_SETTINGS_FX_MAINTAINED_MASK = (1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_BITS) - 1 << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT,

  // Jump behaviour settings
  JUMP_OPTION_UNIT_DIALOG                       = DIALOG_RUNNER.JUMP_UNIT_DIALOG   << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT | DIALOG_RUNNER.JUMP_OPTION_TYPE_RELATIVE,
  JUMP_OPTION_UNIT_SEQUENCE                     = DIALOG_RUNNER.JUMP_UNIT_SEQUENCE << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT | DIALOG_RUNNER.JUMP_OPTION_TYPE_RELATIVE,
  JUMP_OPTION_UNIT_SCENE                        = DIALOG_RUNNER.JUMP_UNIT_SCENE    << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT | DIALOG_RUNNER.JUMP_OPTION_TYPE_RELATIVE,
  JUMP_SETTING_BYPASS_FX_ON_ENTER               = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_ENTER,
  JUMP_SETTING_BYPASS_FX_ON_STAY                = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_STAY,
  JUMP_SETTING_BYPASS_FX_ON_LEAVE               = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_BYPASS_FX_ON_LEAVE,
  JUMP_SETTING_EXEC_FX_ON_ENTER_IF_MAINTAINED   = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_ENTER_IF_MAINTAINED,
  JUMP_SETTING_EXEC_FX_ON_STAY_IF_MAINTAINED    = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_STAY_IF_MAINTAINED,
  JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED   = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED,
  JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED  = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED,
  JUMP_OPTION_MAINTAIN_DIALOG                   = DIALOG_RUNNER.JUMP_UNIT_DIALOG   << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT,
  JUMP_OPTION_MAINTAIN_SEQUENCE                 = DIALOG_RUNNER.JUMP_UNIT_SEQUENCE << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT,
  JUMP_OPTION_MAINTAIN_SCENE                    = DIALOG_RUNNER.JUMP_UNIT_SCENE    << DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT,
  JUMP_INFO_MAINTAINED                          = 1 << DIALOG_RUNNER.__BITMASK_FLAG_INDEX_JUMP_INFO_MAINTAINED,
}












/**
 * @desc Contains all useful information about a dialog scene.
 * @desc `BG_*` options refer to the background index.
 * @desc `BGM_*` options refer to the background music index.
 * @desc `BGS_*` flags refer to the background sound index.
 * @desc `TAG_*` options refer to the scene type for categorization (useful for filtering).
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 */

enum DIALOG_SCENE // Edit as needed
{
  // Argument positions
  ARG_SEQUENCES = 0,
  ARG_SETTINGS_MASK,
  ARG_ID,
  ARGS_COUNT,
  ARG_COMMENT = DIALOG_SCENE.ARGS_COUNT,
  ARG_SEQUENCE_COUNT,
  ARGS_COUNT_DESERIALIZATION,

  // Scene bg
  BG_NONE = 0,
    // ...
  BGS_COUNT,
  BG_DEFAULT = DIALOG_SCENE.BG_NONE,

  // Scene bgm
  BGM_NONE = 0,
    // ...
  BGMS_COUNT,
  BGM_DEFAULT = DIALOG_SCENE.BGM_NONE,

  // Scene bgs
  BGS_NONE = 0,
    // ...
  BGSS_COUNT,
  BGS_DEFAULT = DIALOG_SCENE.BGS_NONE,

  // Scene tags
  TAG_NONE = 0,
    // ...
  TAGS_COUNT,
  TAG_DEFAULT = DIALOG_SCENE.TAG_NONE,

  // Settings masks
  __INITIAL_ID = DIALOG_MANAGER.__ID_SEPARATOR_AUTOINCREMENTAL * DIALOG_MANAGER.LEVEL_SCENE,
  __BITMASK_BG_SHIFT = 0,
  __BITMASK_BG_BITS = 7,
  __BITMASK_BG_MASK = (1 << DIALOG_SCENE.__BITMASK_BG_BITS) - 1 << DIALOG_SCENE.__BITMASK_BG_SHIFT,
  __BITMASK_BGM_SHIFT = DIALOG_SCENE.__BITMASK_BG_SHIFT + DIALOG_SCENE.__BITMASK_BG_BITS,
  __BITMASK_BGM_BITS = 8,
  __BITMASK_BGM_MASK = (1 << DIALOG_SCENE.__BITMASK_BGM_BITS) - 1 << DIALOG_SCENE.__BITMASK_BGM_SHIFT,
  __BITMASK_BGS_SHIFT = DIALOG_SCENE.__BITMASK_BGM_SHIFT + DIALOG_SCENE.__BITMASK_BGM_BITS,
  __BITMASK_BGS_BITS = 6,
  __BITMASK_BGS_MASK = (1 << DIALOG_SCENE.__BITMASK_BGS_BITS) - 1 << DIALOG_SCENE.__BITMASK_BGS_SHIFT,
  __BITMASK_TAG_SHIFT = DIALOG_SCENE.__BITMASK_BGS_SHIFT + DIALOG_SCENE.__BITMASK_BGS_BITS,
  __BITMASK_TAG_BITS = 5,
  __BITMASK_TAG_MASK = (1 << DIALOG_SCENE.__BITMASK_TAG_BITS) - 1 << DIALOG_SCENE.__BITMASK_TAG_SHIFT,
}












/**
 * @desc Contains all useful information about a dialog sequence.
 * @desc `TAG_*` options refer to the sequence type for categorization (useful for filtering).
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 */

enum DIALOG_SEQUENCE // Edit as needed
{
  // Argument positions
  ARG_DIALOGS = 0,
  ARG_SETTINGS_MASK,
  ARG_SPEAKERS,
  ARG_ID,
  ARGS_COUNT,
  ARG_COMMENT = DIALOG_SEQUENCE.ARGS_COUNT,
  ARG_DIALOG_COUNT,
  ARGS_COUNT_DESERIALIZATION,

  // Sequence tags
  TAG_NONE = 0,
    // ...
  TAGS_COUNT,
  TAG_DEFAULT = DIALOG_SEQUENCE.TAG_NONE,

  // Settings masks
  __INITIAL_ID = DIALOG_MANAGER.__ID_SEPARATOR_AUTOINCREMENTAL * DIALOG_MANAGER.LEVEL_SEQUENCE,
  __BITMASK_TAG_SHIFT = 0,
  __BITMASK_TAG_BITS = 5,
  __BITMASK_TAG_MASK = (1 << DIALOG_SEQUENCE.__BITMASK_TAG_BITS) - 1 << DIALOG_SEQUENCE.__BITMASK_TAG_SHIFT,
}












/**
 * @desc Contains all useful information about a dialog.
 * @desc `SPEAKER_*` options refer to the speakers (actors).
 * @desc `EMOTION_*` options refer to the emotions (frames or expressions).
 * @desc `ANCHOR_*` options refer to the dialog box positioning.
 * @desc `TEXTBOX_*` options refer to the dialog box style.
 * @desc `TAG_*` options refer to the dialog type for categorization (useful for filtering).
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 */

enum DIALOG // Edit as needed
{
  // Argument positions
  ARG_TEXT = 0,
  ARG_SETTINGS_MASK,
  ARG_FX_LIST,
  ARG_ID,
  ARGS_COUNT,
  ARG_COMMENT = DIALOG.ARGS_COUNT,
  ARG_FX_COUNT,
  ARGS_COUNT_DESERIALIZATION,

  // Speakers
  SPEAKER_NONE = 0,
  SPEAKER_SYSTEM,
  SPEAKER_NARRATOR,
    // ...
  SPEAKERS_COUNT,
  SPEAKER_DEFAULT = DIALOG.SPEAKER_NONE,

  // Emotions
  EMOTION_NONE = 0,
    // ...
  EMOTIONS_COUNT,
  EMOTION_DEFAULT = DIALOG.EMOTION_NONE,

  // Anchors
  ANCHOR_BOTTOM = 0,
  ANCHOR_CENTER,
  ANCHOR_TOP,
    // ...
  ANCHORS_COUNT,
  ANCHOR_DEFAULT = DIALOG.ANCHOR_BOTTOM,

  // Textbox types
  TEXTBOX_NONE = 0,
    // ...
  TEXTBOXES_COUNT,
  TEXTBOX_DEFAULT = DIALOG.TEXTBOX_NONE,

  // Dialog tags
  TAG_NONE = 0,
    // ...
  TAGS_COUNT,
  TAG_DEFAULT = DIALOG.TAG_NONE,

  // Settings masks
  __INITIAL_ID = DIALOG_MANAGER.__ID_SEPARATOR_AUTOINCREMENTAL * DIALOG_MANAGER.LEVEL_DIALOG,
  __BITMASK_SPEAKER_SHIFT = 0,
  __BITMASK_SPEAKER_BITS = 8,
  __BITMASK_SPEAKER_MASK = (1 << DIALOG.__BITMASK_SPEAKER_BITS) - 1 << DIALOG.__BITMASK_SPEAKER_SHIFT,
  __BITMASK_EMOTION_SHIFT = DIALOG.__BITMASK_SPEAKER_SHIFT + DIALOG.__BITMASK_SPEAKER_BITS,
  __BITMASK_EMOTION_BITS = 6,
  __BITMASK_EMOTION_MASK = (1 << DIALOG.__BITMASK_EMOTION_BITS) - 1 << DIALOG.__BITMASK_EMOTION_SHIFT,
  __BITMASK_ANCHOR_SHIFT = DIALOG.__BITMASK_EMOTION_SHIFT + DIALOG.__BITMASK_EMOTION_BITS,
  __BITMASK_ANCHOR_BITS = 4,
  __BITMASK_ANCHOR_MASK = (1 << DIALOG.__BITMASK_ANCHOR_BITS) - 1 << DIALOG.__BITMASK_ANCHOR_SHIFT,
  __BITMASK_TEXTBOX_SHIFT = DIALOG.__BITMASK_ANCHOR_SHIFT + DIALOG.__BITMASK_ANCHOR_BITS,
  __BITMASK_TEXTBOX_BITS = 4,
  __BITMASK_TEXTBOX_MASK = (1 << DIALOG.__BITMASK_TEXTBOX_BITS) - 1 << DIALOG.__BITMASK_TEXTBOX_SHIFT,
  __BITMASK_TAG_SHIFT = DIALOG.__BITMASK_TEXTBOX_SHIFT + DIALOG.__BITMASK_TEXTBOX_BITS,
  __BITMASK_TAG_BITS = 5,
  __BITMASK_TAG_MASK = (1 << DIALOG.__BITMASK_TAG_BITS) - 1 << DIALOG.__BITMASK_TAG_SHIFT,
}












/**
 * @desc Contains all the useful information about a dialog effect.
 * @desc `TYPE_*` options refer to the effect type. In particular, `FLOWRES_*` types refer to flow control effects.
 * @desc `TRIGGER_*` options refer to the effect trigger type.
 * @desc `SIGNAL_*` options refer to the return signals from effect execution.
 * @desc `TAG_*` options refer to the dialog fx type for categorization (useful for filtering).
 * @desc `FUNC_CONDITION_*` options refer to the condition functions used by effects.
 * @desc `FUNC_INDEXER_*` options refer to the indexer functions used by effects.
 * @desc `[FX_TYPE_NAME]_*` options refer to particular values for that type of fx.
 * @desc `ARG_*` options refer to the positions of the arguments passed to the fx.
 * @desc `FX_ARG_FLOWRES_*` options refer to the positions of the arguments passed to the flow resolver fx.
 * @desc `__BITMASK_*` settings are used to manage bitmasks and should not be referenced directly.
 */

enum DIALOG_FX // Edit as needed
{
  // Argument positions
  ARG_SETTINGS_MASK = 0,
  ARG_ARGV,
  ARG_ID,
  ARGS_COUNT,
  ARG_COMMENT = DIALOG_FX.ARGS_COUNT,
  ARGS_COUNT_DESERIALIZATION,

  // FX flowres argument positions
  FX_ARG_FLOWRES_DATA = 0,
  FX_ARG_FLOWRES_INDEXER_INDEX,
  FX_ARG_FLOWRES_CONDITION_INDEX,
  FX_ARG_FLOWRES_INDEXER_ARGV,
  FX_ARG_FLOWRES_CONDITION_ARGV,
  FX_ARG_FLOWRES_SETTINGS,
  FX_ARG_FLOWRES_COUNT,
  FX_ARG_FLOWRES_INDEX_UNSELECTED = -1,

  // FX flowres subargument positions
  FX_ARG_FLOWRES_DATA_POSITION = 0,
  FX_ARG_FLOWRES_DATA_PROMPT,
  FX_ARG_FLOWRES_DATA_METADATA,
  FX_ARG_FLOWRES_DATA_COUNT,
  FX_ARG_FLOWRES_DATA_POSITION_DESTINATION = 0,
  FX_ARG_FLOWRES_DATA_POSITION_SETTINGS,
  FX_ARG_FLOWRES_DATA_POSITIONS_COUNT,

  // FX types
  __BITMASK_TYPE_SHIFT = 0,
  __BITMASK_TYPE_BITS = 10,
  __BITMASK_TYPE_MAX_COUNT = (1 << DIALOG_FX.__BITMASK_TYPE_BITS) - 1,
  __BITMASK_TYPE_MASK = DIALOG_FX.__BITMASK_TYPE_MAX_COUNT << DIALOG_FX.__BITMASK_TYPE_SHIFT,
  TYPE_NONE = 0,
  TYPE_ANY = DIALOG_FX.TYPE_NONE,
  __TYPE_FLOWRES_START,
  TYPE_FLOWRES_JUMP = DIALOG_FX.__TYPE_FLOWRES_START,
  TYPE_FLOWRES_DISPATCH,
  TYPE_FLOWRES_FALLBACK,
  TYPE_FLOWRES_CHOICE,
  __TYPE_FLOWRES_END = DIALOG_FX.TYPE_FLOWRES_CHOICE,
  TYPES_FLOWRES_COUNT = DIALOG_FX.__TYPE_FLOWRES_END - DIALOG_FX.__TYPE_FLOWRES_START + 1,
  TYPE_STATE_MODIFIER,
  TYPE_TEXT_PARSE,
  TYPE_TEXT,
  TYPE_IMAGE,
  TYPE_VIDEO,
  TYPE_BGM,
  TYPE_BGS,
  TYPE_SFX,
    // ...
  TYPES_COUNT,
  TYPE_DEFAULT = DIALOG_FX.TYPE_ANY,

  // FX triggers
  __BITMASK_TRIGGER_SHIFT = DIALOG_FX.__BITMASK_TYPE_SHIFT + DIALOG_FX.__BITMASK_TYPE_BITS,
  __BITMASK_FLAG_INDEX_TRIGGER_ON_ENTER = 0,
  __BITMASK_FLAG_INDEX_TRIGGER_ON_STAY,
  __BITMASK_FLAG_INDEX_TRIGGER_ON_LEAVE,
  __BITMASK_FLAG_INDEX_TRIGGER_ON_MAINTAIN,
  __BITMASK_FLAG_INDEX_TRIGGER_ON_CUSTOM,
    // ...
  __BITMASK_TRIGGER_BITS,
  TRIGGERS_COUNT = DIALOG_FX.__BITMASK_TRIGGER_BITS,
  __BITMASK_TRIGGER_MASK = (1 << DIALOG_FX.__BITMASK_TRIGGER_BITS) - 1 << DIALOG_FX.__BITMASK_TRIGGER_SHIFT,
  TRIGGER_NONE = 0,
  TRIGGER_ON_ENTER    = 1 << DIALOG_FX.__BITMASK_FLAG_INDEX_TRIGGER_ON_ENTER,
  TRIGGER_ON_STAY     = 1 << DIALOG_FX.__BITMASK_FLAG_INDEX_TRIGGER_ON_STAY,
  TRIGGER_ON_LEAVE    = 1 << DIALOG_FX.__BITMASK_FLAG_INDEX_TRIGGER_ON_LEAVE,
  TRIGGER_ON_MAINTAIN = 1 << DIALOG_FX.__BITMASK_FLAG_INDEX_TRIGGER_ON_MAINTAIN,
  TRIGGER_ON_CUSTOM   = 1 << DIALOG_FX.__BITMASK_FLAG_INDEX_TRIGGER_ON_CUSTOM,
    // ...
  TRIGGER_DEFAULT = DIALOG_FX.TRIGGER_NONE,

  // Flow signals
  SIGNAL_NONE = 0,
  SIGNAL_REPEAT_CYCLE,
  SIGNAL_REPEAT_PREVIOUS_FX,
  SIGNAL_REPEAT_FX,
  SIGNAL_SKIP_NEXT_FX,
  SIGNAL_STOP_CYCLE,
  SIGNAL_STOP_RESOLUTION,
  SIGNALS_COUNT,
  SIGNAL_DEFAULT = DIALOG_FX.SIGNAL_NONE,

  // FX tags
  TAG_NONE = 0,
    // ...
  TAGS_COUNT,
  TAG_DEFAULT = DIALOG_FX.TAG_NONE,

  // FX map settings
  MAP_INDEX_NORMAL = 0,
  MAP_INDEX_CONDITION,
  MAP_INDEX_INDEXER,
  MAPS_COUNT,

  // FX condition indices
  FUNC_CONDITION_FALSE = 0,
  FUNC_CONDITION_TRUE,
    // ...
  FUNC_CONDITIONS_COUNT,
  FUNC_CONDITION_DEFAULT = DIALOG_FX.FUNC_CONDITION_TRUE,

  // FX indexers indices
  FUNC_INDEXER_RUNNER_CHOICE_INDEX = 0,
    // ...
  FUNC_INDEXERS_COUNT,
  FUNC_INDEXER_DEFAULT = DIALOG_FX.FUNC_INDEXER_RUNNER_CHOICE_INDEX,

  // Settings masks
  __INITIAL_ID = DIALOG_MANAGER.__ID_SEPARATOR_AUTOINCREMENTAL * DIALOG_MANAGER.LEVEL_FX,
  __BITMASK_SIGNAL_SHIFT = DIALOG_FX.__BITMASK_TRIGGER_SHIFT + DIALOG_FX.__BITMASK_TRIGGER_BITS,
  __BITMASK_SIGNAL_BITS = 3,
  __BITMASK_SIGNAL_MASK = (1 << DIALOG_FX.__BITMASK_SIGNAL_BITS) - 1 << DIALOG_FX.__BITMASK_SIGNAL_SHIFT,
  __BITMASK_TAG_SHIFT = DIALOG_FX.__BITMASK_SIGNAL_SHIFT + DIALOG_FX.__BITMASK_SIGNAL_BITS,
  __BITMASK_TAG_BITS = 4,
  __BITMASK_TAG_MASK = (1 << DIALOG_FX.__BITMASK_TAG_BITS) - 1 << DIALOG_FX.__BITMASK_TAG_SHIFT,
}












#endregion

// ----------------------------------------------------------------------------

#region Main classes












/**
 * @desc Provides shared dialog-manager configuration, registries, metadata, and error handling.
 * @returns {Struct.DialogManager}
 */

function DialogManager() constructor
{
  static ID_ASSIGNMENT_MODE = DIALOG_MANAGER.ID_ASSIGNMENT_MODE_DEFAULT;

  static link = __DIALOG_MANAGER_LINK__;
  static version = __DIALOG_MANAGER_VERSION__;
  static comparator = DialogComparator;
  static importer = DialogImporter;
  static exporter = DialogExporter;

  static DATA = {
    LANGS: {
      auto: 0,
      ISO_639_1: {
        afar: "aa", abkhazian: "ab", afrikaans: "af", akan: "ak", albanian: "sq", amharic: "am", arabic: "ar", aragonese: "an", armenian: "hy", assamese: "as", avaric: "av",
        avestan: "ae", aymara: "ay", azerbaijani: "az", bashkir: "ba", basque: "eu", belarusian: "be", bengali: "bn", bihari_languages: "bh", bislama: "bi", bosnian: "bs", breton: "br",
        bulgarian: "bg", burmese: "my", catalan: "ca", chamorro: "ch", chechen: "ce", chinese: "zh", church_slavic: "cu", chuvash: "cv", cornish: "kw", corsican: "co", cree: "cr", croatian: "hr", czech: "cs",
        danish: "da", divehi: "dv", dutch: "nl", dzongkha: "dz", english: "en", esperanto: "eo", estonian: "et", ewe: "ee", faroese: "fo", fijian: "fj", finnish: "fi", french: "fr", fulah: "ff",
        galician: "gl", ganda: "lg", georgian: "ka", german: "de", greek_modern: "el", kalaallisut: "kl", guarani: "gn", gujarati: "gu", haitian: "ht", hausa: "ha", hebrew: "he", herero: "hz", hindi: "hi", hiri_motu: "ho",
        hungarian: "hu", icelandic: "is", ido: "io", igbo: "ig", indonesian: "id", interlingua: "ia", interlingue: "ie", inuktitut: "iu", inupiaq: "ik", irish: "ga", italian: "it", japanese: "ja", kalaallisut: "kl", kannada: "kn",
        kashmiri: "ks", kazakh: "kk", khmer: "km", kikuyu: "ki", kinyarwanda: "rw", kirghiz: "ky", komi: "kv", kongo: "kg", korean: "ko", kuanyama: "kj", kurdish: "ku", lao: "lo", latin: "la", latvian: "lv",
        limburgan: "li", lingala: "ln", lithuanian: "lt", luxembourgish: "lb", macedonian: "mk", malagasy: "mg", malay: "ms", malayalam: "ml", maltese: "mt", manx: "gv", maori: "mi", marathi: "mr", marshallese: "mh", mongolian: "mn",
        nauru: "na", navajo: "nv", ndonga: "ng", nepali: "ne", north_ndebele: "nd", northern_sami: "se", norwegian: "no", norwegian_bokmal: "nb", norwegian_nynorsk: "nn", occitan: "oc", ojibwa: "oj", oriya: "or", oromo: "om", ossetian: "os",
        pali: "pi", panjabi: "pa", persian: "fa", polish: "pl", portuguese: "pt", pushto: "ps", quechua: "qu", romansh: "rm", romanian: "ro", rundi: "rn", russian: "ru", samoan: "sm", sango: "sg", sanskrit: "sa",
        sardinian: "sc", serbian: "sr", shona: "sn", sindhi: "sd", sinhala: "si", slovak: "sk", slovenian: "sl", somali: "so", sotho_southern: "st", spanish: "es", swahili: "sw", swati: "ss", swedish: "sv", tagalog: "tl", tahitian: "ty",
        tajik: "tg", tamil: "ta", tatar: "tt", telugu: "te", thai: "th", tibetan: "bo", tigrinya: "ti", tonga_tonga_islands: "to", tsonga: "ts", tswana: "tn", turkish: "tr", turkmen: "tk", uighur: "ug", ukrainian: "uk",
        urdu: "ur", uzbek: "uz", venda: "ve", vietnamese: "vi", volapuk: "vo", walloon: "wa", welsh: "cy", western_frisian: "fy", wolof: "wo", xhosa: "xh", yiddish: "yi", yoruba: "yo", zhuang: "za", zulu: "zu"
      },
      ISO_639_2: {
        afar: "aar", abkhazian: "abk", achinese: "ace", acoli: "ach", adangme: "ada", adyghe: "ady", afro_asiatic_languages: "afa", afrihili: "afh", afrikaans: "afr", ainu: "ain", akan: "aka", akkadian: "akk", albanian: "sqi", aleut: "ale",
        algonquian_languages: "alg", southern_altai: "alt", amharic: "amh", english_old: "ang", angika: "anp", apache_languages: "apa", arabic: "ara", aramaic_imperial: "arc", aragonese: "arg", armenian: "hye", artificial_languages: "art", assamese: "asm", asturian: "ast",
        athapascan_languages: "ath", australian_languages: "aus", avaric: "ava", avestan: "ave", awadhi: "awa", aymara: "aym", azerbaijani: "aze", bantu_languages: "bnt", basque: "eus", belarusian: "bel", bengali: "ben", berber_languages: "ber", bhojpuri: "bho", bosnian: "bos",
        breton: "bre", bulgarian: "bul", burmese: "mya", catalan: "cat", celtic_languages: "cel", central_khmer: "khm", chinese: "zho", church_slavic: "chu", corsican: "cos", croatian: "hrv", czech: "ces", danish: "dan", dutch: "nld", dzongkha: "dzo", english: "eng", esperanto: "epo",
        estonian: "est", ewe: "ewe", faroese: "fao", fijian: "fij", finnish: "fin", french: "fra", friulian: "fur", galician: "glg", georgian: "kat", german: "deu", gothic: "got", greek_ancient: "grc", greek_modern: "ell", guarani: "grn",
        gujarati: "guj", haitian: "hat", hausa: "hau", hebrew: "heb", hindi: "hin", hungarian: "hun", icelandic: "isl", igbo: "ibo", indonesian: "ind", iranian_languages: "ira", irish: "gle", italian: "ita", japanese: "jpn", kalaallisut: "kal",
        kannada: "kan", kashmiri: "kas", kazakh: "kaz", kalaallisut: "kal", korean: "kor", kurdish: "kur", lao: "lao", latin: "lat", latvian: "lav", lithuanian: "lit", luxembourgish: "ltz", macedonian: "mkd", malagasy: "mlg", malay: "msa", malayalam: "mal",
        maltese: "mlt", maori: "mri", marathi: "mar", mongolian: "mon", nepali: "nep", norwegian: "nor", occitan: "oci", persian: "fas", polish: "pol", portuguese: "por", romanian: "ron", russian: "rus", sanskrit: "san", serbian: "srp",
        slovak: "slk", slovenian: "slv", somali: "som", spanish: "spa", swahili: "swa", swedish: "swe", tamil: "tam", telugu: "tel", thai: "tha", tibetan: "bod", turkish: "tur", ukrainian: "ukr", urdu: "urd", uzbek: "uzb",
        vietnamese: "vie", welsh: "cym", yiddish: "yid", yoruba: "yor", zulu: "zul"
      },
    },
    LEVELS: {
      CONSTRUCTORS: [DialogFX, Dialog, DialogSequence, DialogScene],
      CONSTRUCTOR_NAMES: [nameof(DialogFX), nameof(Dialog),  nameof(DialogSequence),  nameof(DialogScene)],
    },
    DIFF: {
      OPERATIONS: [ "INSERTED", "DELETED", "MOVED", "MODIFIED", "MATCHED" ],
      NAMES: ["fx", "dialog", "sequence", "scene"],
    },
  };



  /** FX MAPS & FUNCTIONS ARE MAPPED BY INDEX - USE DIALOG_FX.TYPE/CONDITION/INDEXER VALUES FOR REFERENCE */
  static FX_MAPS = [
    /** Normal FX map */
    DialogFXMap.create([
      function(_argv, _ctx) { },
      function(_argv, _ctx) { return _ctx.getresolver().__fx_jump(_argv, _ctx);     },
      function(_argv, _ctx) { return _ctx.getresolver().__fx_dispatch(_argv, _ctx); },
      function(_argv, _ctx) { return _ctx.getresolver().__fx_fallback(_argv, _ctx); },
      function(_argv, _ctx) { return _ctx.getresolver().__fx_choice(_argv, _ctx);   },
    ]),
    /** Condition FX map */
    DialogFXMap.create([
      function(_argv, _ctx) { return false; },
      function(_argv, _ctx) { return true;  },
    ]),
    /** Indexer FX map */
    DialogFXMap.create([
      function(_argv, _ctx) { return _ctx.getresolver().getrunner().getchoiceindex(); },
    ]),
  ];



  /**
   * @desc Returns the configured maximum rendered width for a dialog's text.
   * @param {Struct.Dialog} _dialog The dialog whose text width is measured.
   * @returns {Real} The maximum rendered width.
   */

  static TEXT_WIDTH_MAX_FUNC = function(_dialog)
  {
    return 0;
  }



  /**
   * @desc Measures the rendered width of a dialog's text.
   * @param {Struct.Dialog} _dialog The dialog whose text width is measured.
   * @returns {Real} The rendered text width.
   */

  static TEXT_WIDTH_FUNC = function(_dialog)
  {
    return string_width(_dialog.gettext());
  }



  /**
   * @desc Returns the link for this dialog manager.
   * @returns {String}
   */

  static getlink = function()
  {
    return self.link;
  }



  /**
   * @desc Returns the version for this dialog manager.
   * @returns {String}
   */

  static getversion = function()
  {
    return self.version;
  }



  /**
   * @desc Returns the active automatic id-assignment mode.
   * @returns {Constant.DIALOG_MANAGER}
   */

  static getidassignmentmode = function()
  {
    return self.ID_ASSIGNMENT_MODE;
  }



  /**
   * @desc Sets the automatic id-assignment mode used when item ids are generated.
   * @param {Constant.DIALOG_MANAGER} [_id_assignment_mode] The assignment mode to apply.
   * @returns {Struct.DialogManager}
   */

  static setidassignmentmode = function(_id_assignment_mode = DIALOG_MANAGER.ID_ASSIGNMENT_MODE_DEFAULT)
  {
    self.ID_ASSIGNMENT_MODE = _id_assignment_mode;

    return self;
  }



  /**
   * @desc Registers the supplied fx and returns its index.
   * @param {Function} _func The function value.
   * @param {Constant.DIALOG_FX} [_map_idx] The effect-function map index.
   * @param {Real} [_func_idx] The function index value.
   * @returns {Real} The index the function gets registered at.
   */

  static registerfx = function(_func, _map_idx = DIALOG_FX.MAP_INDEX_NORMAL, _func_idx = undefined)
  {
    return self.FX_MAPS[_map_idx].register(_func, _func_idx);
  }



  /**
   * @desc Creates a formatted error message for the specified error type.
   * @param {Real} _type The error type.
   * @param {Any|Array<Any>} [_argv] The arguments for the message.
   * @returns {String} The formatted error message.
   */

  static ERROR = function(_type, _argv = [])
  {
    static messages = [
      "UNKNOWN ERROR TYPE: {0}",
      "INVALID ARGUMENT PROVIDED ({0} = {1})",
      "INVALID POSITION - INDEX OUT OF BOUNDS: ERROR WHILE ATTEMPTING ACCESS TO:\n< SCENE {0} | SEQUENCE {1} | DIALOG {2} >",
      "INVALID CONTAINER ACCESS: ERROR WHILE ATTEMPTING ACCESS FROM:\n< {0} >",
      "INVALID ACCESS OPERATION: CONTAINER IS UNDEFINED\n< {0} >",
      "FAILED SERIALIZATION - INVALID DATA:\nENSURE PRESENCE OF ALL REFERENCED \{Struct.{0}\} OBJECTS",
      "FAILED DESERIALIZATION - A PROBLEM OCCURRED WHILE OPENING FILE <{0}>:\nENSURE INTEGRITY OF FILE NAME/PATH OR FILE HANDLE",
      "FAILED PARSING - INVALID DATA: ENSURE INTEGRITY OF SERIALIZED DATA",
      "POSITION RESOLUTION FAILED FROM \{Struct.{0}\} - UNDEFINED \{Struct.{1}\} CONTAINER OBJECT:\nENSURE EXISTENCE OF BACK-REFERENCE AND AVOIDAL OF USAGE OF variable_clone()'d RECURSIVE COMPONENT REFERENCES (\{Struct.{2}\}, \{Struct.{3}\}) AS VALID OBJECTS.\n\nSTRUCTURE INFO: {4}",
      "POSITION RESOLUTION FAILED FROM \{Struct.{0}\} - UNDEFINED \{Struct.{1}\} CONTAINER OBJECT:\nENSURE EXISTENCE OF BACK-REFERENCE AND AVOIDAL OF USAGE OF variable_clone()'d RECURSIVE COMPONENT REFERENCES (\{Struct.{2}\}, \{Struct.{3}\}) AS VALID OBJECTS.\n\nSTRUCTURE INFO: {4}\n\nCONTAINER STRUCTURE INFO: {5}",
      "EMPTY CONTAINER OBJECT OF TYPE \{Struct.{0}\} INVALID FOR STRUCTURE FORM",
      "FX LIMIT EXCEEDED - MAX FX MAP CAPACITY REACHED WHILE REGISTERING FX {0}\n(TOTAL CAPACITY: {1})",
      "POTENTIAL TEXT OVERFLOW DETECTED (W: {0}/{1}): SPLIT INTO MULTIPLE DIALOG OBJECTS\n\nVIOLATOR DATA: {2}",
      "INFINITE JUMP LOOP DETECTED - ITERATION {0}: ENSURE JUMP EFFECTS DO NOT POINT TO LOOPING LOCATIONS\n\nCRASH POSITION DATA: {1}",
      "INFINITE FX RESOLUTION LOOP DETECTED - ITERATION {0}: ENSURE FX SIGNALS ALLOW CORRECTNESS IN EXECUTION\n\nCRASH CONTEXT DATA: {1}",
    ];

    if (_type < 0 || _type >= DIALOG_MANAGER.ERRS_COUNT) {
      _argv = [_type];
      _type = DIALOG_MANAGER.ERR_UNDEFINED_ERROR_TYPE;
    }

    if (!is_array(_argv)) {
      _argv = [_argv];
    }

    return string_ext($"\n\n\n<<Dialog Manager>>:\n{messages[_type]}\n\n", _argv);
  }
}












/**
 * @desc Runs a dialog structure and tracks its current position, status, choices, and history.
 * @param {Struct.DialogStructure} _dialog_structure The dialog structure value.
 * @returns {Struct.DialogRunner}
 */

function DialogRunner(_dialog_structure) : DialogBitmaskRegionWorker() constructor
{
  static __bitmaskregion_status_all       = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_STATUS_SHIFT, DIALOG_RUNNER.__BITMASK_STATUS_NO_AUTORESET_BITS);
  static __bitmaskregion_status_autoreset = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_STATUS_SHIFT, DIALOG_RUNNER.__BITMASK_STATUS_AUTORESET_COUNT);



  self.structure = _dialog_structure;
  self.status = DIALOG_RUNNER.STATUS_UNINITIALIZED;
  self.currentlink = _dialog_structure.getlinkfromposition(DIALOG_MANAGER.POSITION_CODE_NONE);

  self.choice_index = DIALOG_FX.FX_ARG_FLOWRES_INDEX_UNSELECTED;
  self.history = DialogHistory.from([]);



  /**
   * @desc Creates a runner for the supplied dialog structure.
   * @param {Struct.DialogStructure} _dialog_structure The dialog structure value.
   * @returns {Struct.DialogRunner}
   */

  static create = function(_dialog_structure)
  {
    return new DialogRunner(_dialog_structure);
  }



  /**
   * @desc Creates a copy of this dialog runner and its cl on e.
   * @returns {Struct.DialogRunner}
   */

  static clone = function()
  {
    return DialogRunner.create(self.structure)
      .setchoiceindex(self.choice_index)
      .setposition(self.position)
      .setstatus(self.status)
    ;
  }



  /**
   * @desc Returns the structure for this dialog runner.
   * @returns {Struct.DialogStructure}
   */

  static getstructure = function()
  {
    return self.structure;
  }



  /**
   * @desc Returns the position for this dialog runner.
   * @param {Struct.DialogLinkInterface} [_link] The link object.
   * @returns {Real}
   */

  static getposition = function(_link = self.getcurrentlink())
  {
    return int64(self.getstructure().getpositionfromlink(_link));
  }



  /**
   * @desc Returns the current link for this dialog runner.
   * @returns {Struct.DialogLinkInterface}
   */

  static getcurrentlink = function()
  {
    return self.currentlink;
  }



  /**
   * @desc Returns the choice index for this dialog runner.
   * @returns {Real}
   */

  static getchoiceindex = function()
  {
    return int64(self.choice_index);
  }



  /**
   * @desc Returns the status for this dialog runner.
   * @returns {Real}
   */

  static getstatus = function()
  {
    return int64(self.status);
  }



  /**
   * @desc Returns whether a flag is currently active in this dialog runner.
   * @param {Constant.DIALOG_RUNNER|Real} _flag The flag to check for.
   * @returns {Bool}
   */

  static getstatusflag = function(_flag)
  {
    return DialogBitmaskResolver.getflag(self.getstatus(), _flag);
  }



  /**
   * @desc Returns the history for this dialog runner.
   * @returns {Struct.DialogHistory}
   */

  static gethistory = function()
  {
    return self.history;
  }



  /**
   * @desc Sets the current link for this dialog runner.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @returns {Struct.DialogRunner}
   */

  static setcurrentlink = function(_link)
  {
    self.currentlink = _link;

    return self;
  }



  /**
   * @desc Sets the choice index for this dialog runner.
   * @param {Real} _choice_index The choice index value.
   * @returns {Struct.DialogRunner}
   */

  static setchoiceindex = function(_choice_index)
  {
    self.choice_index = _choice_index;

    return self;
  }



  /**
   * @desc Sets the status for this dialog runner.
   * @param {Real} _status The status value.
   * @returns {Struct.DialogRunner}
   */

  static setstatus = function(_status)
  {
    self.status = _status;

    return self;
  }



  /**
   * @desc Composes the status from the supplied values.
   * @param {Real} _status The status value.
   * @returns {Struct.DialogRunner}
   */

  static composestatus = function(_status)
  {
    return self.setstatus(DialogBitmaskResolver.compose(self.getstatus(), _status));
  }



  /**
   * @desc Composes the position status from the supplied values.
   * @param {Struct.DialogLinkInterface} _link_target The link target value.
   * @param {Struct.DialogLinkInterface} [_link_start] The link start value.
   * @param {Constant.DIALOG_RUNNER|Real} [_execution_mask] The runner value.
   * @param {Real} [_shift] The shift value.
   * @returns {Real}
   */

  static composepositionstatus = function(_link_target, _link_start = self.getcurrentlink(), _execution_mask = 0, _shift = 0)
  {
    var _structure = self.getstructure()
      , _link_dialog = _link_target.todialog()
      , _link_sequence = _link_dialog.getparent()
      , _link_scene = _link_sequence.getparent()
      , _idx_dialog = _link_dialog.getindex()
      , _idx_sequence = _link_sequence.getindex()
      , _idx_scene = _link_scene.getindex()
      , _count_dialog = _link_sequence.getitemcount()
      , _count_sequence = _link_scene.getitemcount()
      , _count_scene = _structure.getitemcount()
      , _is_first_scene = _idx_scene == 0
      , _is_first_of_scene = _idx_sequence == 0
      , _is_first_of_sequence = _idx_dialog == 0
      , _is_first_sequence = _is_first_scene && _is_first_of_scene
      , _is_first_dialog = _is_first_sequence && _is_first_of_sequence
      , _is_last_scene = _idx_scene == _count_scene - 1
      , _is_last_of_scene = _idx_sequence == _count_sequence - 1
      , _is_last_of_sequence = _idx_dialog == _count_dialog - 1
      , _is_last_sequence = _is_last_scene && _is_last_of_scene
      , _is_last_dialog = _is_last_sequence && _is_last_of_sequence
      , _link_start_dialog = _link_start.todialog()
      , _link_start_sequence = _link_start_dialog.getparent()
      , _link_start_scene = _link_start_sequence.getparent()
      , _idx_start_dialog = _link_start_dialog.getindex()
      , _idx_start_sequence = _link_start_sequence.getindex()
      , _idx_start_scene = _link_start_scene.getindex()
      , _shift_sign = sign(_shift)
      , _diff_dialog = _shift_sign * (_idx_dialog != _idx_start_dialog)
      , _diff_sequence = _shift_sign * (_idx_sequence != _idx_start_sequence)
      , _diff_scene = _shift_sign * (_idx_scene != _idx_start_scene)
    ;

    return self.composestatus([
      DIALOG_RUNNER.STATUS_FIRST_DIALOG       * (_is_first_dialog                     ),
      DIALOG_RUNNER.STATUS_FIRST_SEQUENCE     * (_is_first_sequence                   ),
      DIALOG_RUNNER.STATUS_FIRST_SCENE        * (_is_first_scene                      ),
      DIALOG_RUNNER.STATUS_FIRST_OF_SEQUENCE  * (_is_first_of_sequence                ),
      DIALOG_RUNNER.STATUS_FIRST_OF_SCENE     * (_is_first_of_scene                   ),
      DIALOG_RUNNER.STATUS_MIDDLE_OF_SEQUENCE * (_idx_dialog == _count_dialog >> 1    ),
      DIALOG_RUNNER.STATUS_MIDDLE_OF_SCENE    * (_idx_sequence == _count_sequence >> 1),
      DIALOG_RUNNER.STATUS_MIDDLE_SCENE       * (_idx_scene == _count_scene >> 1      ),
      DIALOG_RUNNER.STATUS_LAST_DIALOG        * (_is_last_dialog                      ),
      DIALOG_RUNNER.STATUS_LAST_SEQUENCE      * (_is_last_sequence                    ),
      DIALOG_RUNNER.STATUS_LAST_SCENE         * (_is_last_scene                       ),
      DIALOG_RUNNER.STATUS_LAST_OF_SEQUENCE   * (_is_last_of_sequence                 ),
      DIALOG_RUNNER.STATUS_LAST_OF_SCENE      * (_is_last_of_scene                    ),
      DIALOG_RUNNER.STATUS_ADVANCED_DIALOG    * (_diff_dialog > 0                     ),
      DIALOG_RUNNER.STATUS_ADVANCED_SEQUENCE  * (_diff_sequence > 0                   ),
      DIALOG_RUNNER.STATUS_ADVANCED_SCENE     * (_diff_scene > 0                      ),
      DIALOG_RUNNER.STATUS_RECEDED_DIALOG     * (_diff_dialog < 0                     ),
      DIALOG_RUNNER.STATUS_RECEDED_SEQUENCE   * (_diff_sequence < 0                   ),
      DIALOG_RUNNER.STATUS_RECEDED_SCENE      * (_diff_scene < 0                      ),
      _execution_mask
    ]);
  }



  /**
   * @desc Clears the status of the dialog runner.
   * @param {Boolean} [_autoreset_only] Whether to only clear auto-reset statuses.
   * @returns {Struct.DialogRunner}
   */

  static clearstatus = function(_autoreset_only = false)
  {
    return self.setstatus(DialogBitmaskResolver.filterout(self.getstatus(),
      _autoreset_only
        ? DIALOG_RUNNER.__BITMASK_STATUS_MASK_AUTORESET
        : DIALOG_RUNNER.__BITMASK_STATUS_MASK
    ));
  }



  /**
   * @desc Loads the dialog runner to a given position and status.
   * @param {Struct.DialogLinkInterface} [_link] The link to load the dialog runner to. Defaults to the current link.
   * @param {Real} [_status] The status to set the dialog runner to.
   * @returns {Struct.DialogRunner}
   */

  static load = function(_link = self.getcurrentlink(), _status = 0)
  {
    return self.setcurrentlink(_link).setstatus(_status).composepositionstatus(_link, _link, 0, 0);
  }



  /**
   * @desc Advances the dialog runner by a specified shift and jump settings.
   * @param {Real} [_shift] The shift amount.
   * @param {Constant.DIALOG_RUNNER|Real} [_jump_settings] The jump settings.
   * @param {Struct.DialogLinkInterface} [_link_start] The starting link.
   * @param {Function} [_filter_fn] The dialog effect filter function.
   * @param {Array} [_argv_exec] The arguments for dialog effect execution.
   * @returns {Struct.DialogRunner}
   */

  static advance = function(_shift = 1, _jump_settings = DIALOG_RUNNER.JUMP_OPTION_UNIT_DIALOG, _link_start = self.getcurrentlink(), _filter_fn = undefined, _argv_exec = undefined)
  {
    var _should_stay = _shift == 0
      , _link_start_dialog = _link_start.todialog()
      , _flow_resolver = DialogResolver.from(self.clearstatus(_should_stay))
      , _exec_fx_on_stay = !DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_BYPASS_FX_ON_STAY)
      , _exec_fx_on_stay_if_maintained = DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_EXEC_FX_ON_STAY_IF_MAINTAINED)
      , _exec_fx_on_custom_if_maintained = DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_EXEC_FX_ON_CUSTOM_IF_MAINTAINED)
    ;

    if (_should_stay)
    {
      if (_exec_fx_on_stay) {
        _flow_resolver.executeallfxwhere(_link_start_dialog.getallfxoftrigger(DIALOG_FX.TRIGGER_ON_STAY), _filter_fn, _argv_exec);
      }

      return self;
    }

    var _shift_result = _flow_resolver.resolvelinkrelative(_link_start, _shift, _jump_settings)
      , _shift_is_maintained = DialogBitmaskResolver.filter(_shift_result.getstatus(), DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_MASK)
      , _advance_result = !_shift_is_maintained || DialogBitmaskResolver.filter(_jump_settings, DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_MASK)
          ? _flow_resolver.resolvejump(_shift_result.getlink(), _link_start, DialogBitmaskResolver.composeif(_jump_settings, DIALOG_RUNNER.JUMP_INFO_MAINTAINED, _shift_is_maintained), _argv_exec)
          : _shift_result
      , _link_target = _advance_result.getlink()
      , _status_target = DialogBitmaskResolver.compose(_advance_result.getstatus(), _shift_result.getstatus())
    ;

    if (_shift_is_maintained)
    {
      _flow_resolver.executeallfxwhere(_link_start_dialog.getallfxoftrigger(DIALOG_FX.TRIGGER_ON_MAINTAIN), _filter_fn, _argv_exec);

      if (_exec_fx_on_stay_if_maintained) {
        _flow_resolver.executeallfxwhere(_link_start_dialog.getallfxoftrigger(DIALOG_FX.TRIGGER_ON_STAY), _filter_fn, _argv_exec);
      }

      if (_exec_fx_on_custom_if_maintained) {
        _flow_resolver.executeallfxwhere(_link_start_dialog.getallfxoftrigger(DIALOG_FX.TRIGGER_ON_CUSTOM), _filter_fn, _argv_exec);
      }
    }

    if (!_link_target.equals(_link_start)) {
      self.gethistory().add(_link_start);
    }

    return self.load(_link_target).composepositionstatus(
      _link_target, _link_start, _status_target, _shift
    );
  }



  /**
   * @desc Advances the dialog runner using the supplied next.
   * @param {Constant.DIALOG_RUNNER|Real} [_jump_settings] The runner value.
   * @returns {Struct.DialogRunner}
   */

  static advancenext = function(_jump_settings = undefined)
  {
    return self.advance(+1, _jump_settings);
  }



  /**
   * @desc Advances the dialog runner using the supplied previous.
   * @param {Constant.DIALOG_RUNNER|Real} [_jump_settings] The runner value.
   * @returns {Struct.DialogRunner}
   */

  static advanceprevious = function(_jump_settings = undefined)
  {
    return self.advance(-1, _jump_settings);
  }
}












/**
 * @desc Represents the root collection of dialog scenes and the structure language.
 * @param {Array<Struct.DialogScene>} _dialog_scene_list The dialog scenes in the structure.
 * @param {Real} _scene_count The number of scenes of the collection.
 * @returns {Struct.DialogStructure}
 */

function DialogStructure(_dialog_scene_list, _scene_count) : DialogItemCollection(_dialog_scene_list, self, _scene_count) constructor
{
  self.__bitmaskregion_scene    = undefined;
  self.__bitmaskregion_sequence = undefined;
  self.__bitmaskregion_dialog   = undefined;

  self.IDS = self.generatebaseids();
  self.BITS = self.generatelinkencodingsizes()

  self.lang = DialogManager.DATA.LANGS.auto;
  self.idgeneratormode = DIALOG_MANAGER.ID_GENERATOR_MODE_DEFAULT;
  self.commentprefix = __DIALOG_STRUCTURE_COMMENT_PREFIX_DEFAULT__;

  self.setlinkencodingsizes(self.BITS);



  /**
   * @desc Creates a dialog structure from its scene list and language.
   * @param {Array<Struct.DialogScene>} [_dialog_scene_list] The scenes to include in the structure.
   * @param {Real} [_scene_count] The number of scenes in the supplied list.
   * @param {String|Real} [_lang] The language code or identifier for the structure.
   * @returns {Struct.DialogStructure}
   */

  static create = function(_dialog_scene_list = [], _scene_count = undefined, _lang = undefined)
  {
    return new DialogStructure(_dialog_scene_list, _scene_count).setlang(_lang);
  }



  /**
   * @desc Assigns stable ids to all items contained in the structure.
   * @returns {Struct.DialogStructure}
   */

  static finalize = function()
  {
    array_foreach(self.getitems(), __finalize_id_assignment);

    return self;
  }



  /**
   * @desc Returns the default counter values used to begin id generation for each structure level.
   * @returns {Array<Real>}
   */

  static generatebaseids = function()
  {
    return [ DIALOG_FX.__INITIAL_ID, DIALOG.__INITIAL_ID, DIALOG_SEQUENCE.__INITIAL_ID, DIALOG_SCENE.__INITIAL_ID ];
  }



  /**
   * @desc Returns the default bit sizes used when packing dialog link positions for each structure level.
   * @returns {Array<Real>}
   */

  static generatelinkencodingsizes = function()
  {
    return [ DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_BITS, DIALOG_MANAGER.__BITMASK_POSITION_SEQUENCE_BITS, DIALOG_MANAGER.__BITMASK_POSITION_SCENE_BITS ];
  }



  /**
   * @desc Returns the current counters used for generated ids at each structure level.
   * @returns {Array<Real>}
   */

  static getids = function()
  {
    return array_map(self.IDS, int64);
  }



  /**
   * @desc Returns the bit sizes currently used to encode scene, sequence, and dialog positions.
   * @returns {Array<Real>}
   */

  static getlinkencodingsizes = function()
  {
    return array_map(self.BITS, int64);
  }



  /**
   * @desc Returns the automatic id-generation mode configured for this structure.
   * @returns {Constant.DIALOG_MANAGER}
   */

  static getidgeneratormode = function()
  {
    return int64(self.idgeneratormode);
  }



  /**
   * @desc Returns the language code for this localized dialog structure.
   * @returns {String|Real}
   */

  static getlang = function()
  {
    return is_string(self.lang) ? self.lang : int64(self.lang);
  }



  /**
   * @desc Returns the configured global comment prefix used for localized comments.
   * @returns {String}
   */

  static getcommentprefix = function()
  {
    return self.commentprefix;
  }



  /**
   * @desc Sets the current id counters used for each structure level.
   * @param {Array<Real>} [_ids] The id counters to assign.
   * @returns {Struct.DialogStructure}
   */

  static setids = function(_ids = self.generatebaseids())
  {
    self.IDS = _ids;

    return self;
  }



  /**
   * @desc Sets the bit sizes used when packing scene, sequence, and dialog positions into a link mask.
   * @param {Array<Real>} [_bit_encoding_sizes] The bit sizes to assign to each level.
   * @returns {Struct.DialogStructure}
   */

  static setlinkencodingsizes = function(_bit_encoding_sizes = self.generatelinkencodingsizes())
  {
    self.BITS = _bit_encoding_sizes;

    var _s = DIALOG_MANAGER.__LEVELS_LINKABLE_START
      , _dialog_bits = _bit_encoding_sizes[DIALOG_MANAGER.LEVEL_DIALOG - _s]
      , _sequence_bits = _bit_encoding_sizes[DIALOG_MANAGER.LEVEL_SEQUENCE - _s]
      , _scene_bits = _bit_encoding_sizes[DIALOG_MANAGER.LEVEL_SCENE - _s]
      , _dialog_shift = DIALOG_MANAGER.__BITMASK_POSITION_DIALOG_SHIFT
      , _sequence_shift = _dialog_shift + _dialog_bits
      , _scene_shift = _sequence_shift + _sequence_bits
    ;

    self.__bitmaskregion_dialog   = DialogBitmaskRegion.from(_dialog_shift  , _dialog_bits  );
    self.__bitmaskregion_sequence = DialogBitmaskRegion.from(_sequence_shift, _sequence_bits);
    self.__bitmaskregion_scene    = DialogBitmaskRegion.from(_scene_shift   , _scene_bits   );

    return self;
  }



  /**
   * @desc Sets the automatic id-generation mode used when ids are created for items.
   * @param {Constant.DIALOG_MANAGER} [_id_generator_mode] The generation mode to apply.
   * @returns {Struct.DialogStructure}
   */

  static setidgeneratormode = function(_id_generator_mode = DIALOG_MANAGER.ID_GENERATOR_MODE_DEFAULT)
  {
    self.idgeneratormode = _id_generator_mode;

    return self;
  }



  /**
   * @desc Resets the id counters to their initial base values.
   * @returns {Struct.DialogStructure}
   */

  static resetids = function()
  {
    return self.setids(self.generatebaseids());
  }



  /**
   * @desc Sets the language code for this dialog structure.
   * @param {String|Real} [_lang] The language code or identifier for the structure.
   * @returns {Struct.DialogStructure}
   */

  static setlang = function(_lang = DialogManager.DATA.LANGS.auto)
  {
    self.lang = _lang;

    return self;
  }



  /**
   * @desc Sets the comment prefix used for localized comments in this structure.
   * @param {String} [_comment_prefix] The prefix to prepend to stored comments.
   * @returns {Struct.DialogStructure}
   */

  static setcommentprefix = function(_comment_prefix = __DIALOG_STRUCTURE_COMMENT_PREFIX_DEFAULT__)
  {
    self.commentprefix = _comment_prefix;

    return self;
  }



  /**
   * @desc Returns the scene using the absolute position for this dialog structure.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.DialogScene}
   */

  static getsceneabsolute = function(_scene_idx)
  {
    try {
      return self.getitem(_scene_idx);
    }
    catch (_ex) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_POSITION, [
        _scene_idx, 0, 0
      ]);
    }
  }



  /**
   * @desc Returns the sequence using the absolute position for this dialog structure.
   * @param {Real} _sequence_idx The sequence index value.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.DialogSequence}
   */

  static getsequenceabsolute = function(_sequence_idx, _scene_idx)
  {
    try {
      return self.getsceneabsolute(_scene_idx).getsequence(_sequence_idx);
    }
    catch (_ex) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_POSITION, [
        _scene_idx, _sequence_idx, 0
      ]);
    }
  }



  /**
   * @desc Returns the dialog using the absolute position for this dialog structure.
   * @param {Real} _dialog_idx The dialog index value.
   * @param {Real} _sequence_idx The sequence index value.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.Dialog}
   */

  static getdialogabsolute = function(_dialog_idx, _sequence_idx, _scene_idx)
  {
    try {
      return self.getsequenceabsolute(_sequence_idx, _scene_idx).getdialog(_dialog_idx);
    }
    catch (_ex) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_POSITION, [
        _scene_idx, _sequence_idx, _dialog_idx
      ]);
    }
  }



  /**
   * @desc Returns the scene at the supplied absolute scene index.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.DialogScene}
   */

  static getscene = self.getsceneabsolute;



  /**
   * @desc Returns the sequence at the supplied absolute scene/sequence indices.
   * @param {Real} _sequence_idx The sequence index value.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.DialogSequence}
   */

  static getsequence = self.getsequenceabsolute;



  /**
   * @desc Returns the dialog at the supplied absolute scene/sequence/dialog indices.
   * @param {Real} _dialog_idx The dialog index value.
   * @param {Real} _sequence_idx The sequence index value.
   * @param {Real} _scene_idx The scene index value.
   * @returns {Struct.Dialog}
   */

  static getdialog = self.getdialogabsolute;



  /**
   * @desc Returns the link relative for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} _shift The shift value.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkrelative = function(_link, _shift)
  {
    if (!is_instanceof(_link, DialogLinkInterface)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_link), _link
      ]);
    }

    if (_shift == 0)
      return _link;

    var _cycle_link = _link
      , _remaining = abs(_shift)
      , _shift_dir = sign(_shift)
        // *: +-inf shift guarantees retrieval of frontier links of adjacient +-container
      , _cycle_shift = _shift_dir * infinity
      , _pool_remaining = _cycle_link.getpoolremainingcount(_shift_dir)
    ;

    while (_remaining > _pool_remaining) {
      _remaining -= _pool_remaining + 1;
      _cycle_link = self.getadjacentlink(_cycle_link, _cycle_shift);
      _pool_remaining = _cycle_link.getpoolremainingcount(_shift_dir);
    }

    return _cycle_link.getinpoolrelative(_remaining * _shift_dir);
  }



  /**
   * @desc Returns the adjacent link for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} _shift The shift value.
   * @returns {Struct.DialogLinkInterface}
   */

  static getadjacentlink = function(_link, _shift)
  {
    if (!is_instanceof(_link, DialogLinkInterface)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_link), _link
      ]);
    }

    if (!_link.islinkablelevel(_link.getlevel() + 1))
      return _link.getinpoolrelative(abs(_shift) == infinity ? sign(_shift) : _shift);

    var _parent = _link.getparent()
      , _item_idx = _link.getindex()
      , _new_idx = _item_idx + _shift
    ;

    if (_new_idx >= _parent.getitemcount())
      return self.getadjacentlink(_parent, +1).getitemfirst();
    else if (_new_idx < 0)
      return self.getadjacentlink(_parent, -1).getitemlast();

    return _parent.getitem(_new_idx);
  }



  /**
   * @desc Returns the scene relative for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} [_shift] The shift value.
   * @returns {Struct.DialogScene}
   */

  static getscenerelative = function(_link, _shift = 1)
  {
    return self.getlinkrelative(_link.toscene(), _shift);
  }



  /**
   * @desc Returns the sequence relative for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} [_shift] The shift value.
   * @returns {Struct.DialogSequence}
   */

  static getsequencerelative = function(_link, _shift = 1)
  {
    return self.getlinkrelative(_link.tosequence(), _shift);
  }



  /**
   * @desc Returns the dialog relative for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} [_shift] The shift value.
   * @returns {Struct.Dialog}
   */

  static getdialogrelative = function(_link, _shift = 1)
  {
    return self.getlinkrelative(_link.todialog(), _shift);
  }



  /**
   * @desc Returns the link given a position for this dialog structure.
   * @param {Real} [_position] The position value.
   * @returns {Struct.Dialog}
   */

  static getlinkfromposition = function(_position = DIALOG_MANAGER.POSITION_CODE_NONE)
  {
    return self.getdialogabsolute(
      self.__bitmaskregion_dialog.decode(_position),
      self.__bitmaskregion_sequence.decode(_position),
      self.__bitmaskregion_scene.decode(_position)
    );
  }



  /**
   * @desc Returns the link given a position code for this dialog structure.
   * @param {Constant.DIALOG_MANAGER} _position_code The position code.
   * @param {Struct.DialogLinkInterface} [_link] The link object.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkfrompositioncode = function(_position_code, _link = self.getlinkfromposition())
  {
    if (!is_instanceof(_link, DialogLinkInterface)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_link), _link
      ]);
    }

    var _sequence_link = _link.tosequence()
      , _scene_link = _sequence_link.getparent()
    ;

    switch (_position_code)
    {
      case DIALOG_MANAGER.POSITION_CODE_SCENE_FIRST:
        return self.getsceneabsolute(0);
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_FIRST:
        return self.getsequenceabsolute(0, 0);
      case DIALOG_MANAGER.POSITION_CODE_SCENE_LAST:
        return self.getsceneabsolute(-1);
      case DIALOG_MANAGER.POSITION_CODE_SCENE_NEXT:
        return self.getscenerelative(_scene_link, +1);
      case DIALOG_MANAGER.POSITION_CODE_SCENE_END:
        return _scene_link.getitemlast();
      case DIALOG_MANAGER.POSITION_CODE_SCENE_MIDDLE:
        return _scene_link.getitemmiddle();
      case DIALOG_MANAGER.POSITION_CODE_SCENE_START:
        return _scene_link.getitemfirst();
      case DIALOG_MANAGER.POSITION_CODE_SCENE_PREVIOUS:
        return self.getscenerelative(_scene_link, -1);
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_LAST:
        return self.getsequenceabsolute(-1, -1);
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_NEXT:
        return self.getsequencerelative(_sequence_link, +1);
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_END:
        return _sequence_link.getitemlast();
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_MIDDLE:
        return _sequence_link.getitemmiddle();
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_START:
        return _sequence_link.getitemfirst();
      case DIALOG_MANAGER.POSITION_CODE_SEQUENCE_PREVIOUS:
        return self.getsequencerelative(_sequence_link, -1);
    }

    return undefined;
  }



  /**
   * @desc Returns the link given the supplied indices for this dialog structure.
   * @param {Real} _scene_idx The scene index value.
   * @param {Real} [_sequence_idx] The sequence index value.
   * @param {Real} [_dialog_idx] The dialog index value.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkfromindices = function(_scene_idx, _sequence_idx = undefined, _dialog_idx = undefined)
  {
    if (is_undefined(_sequence_idx) && is_undefined(_dialog_idx))
      return self.getsceneabsolute(_scene_idx);

    if (is_undefined(_dialog_idx))
      return self.getsequenceabsolute(_sequence_idx, _scene_idx);

    return self.getdialogabsolute(_dialog_idx, _sequence_idx ?? 0, _scene_idx);
  }



  /**
   * @desc Returns the position given a link object of this dialog structure.
   * @param {Any} _link The link object.
   * @returns {Real}
   */

  static getpositionfromlink = function(_link)
  {
    var _indices = {};

    for (var _level = _link.getlevel(); _level < DIALOG_MANAGER.LEVEL_STRUCTURE; ++_level) {
      _indices[$ _level] = _link.getindex();
      _link = _link.getparent();
    }

    return self.getpositionfromindices(
      variable_struct_get(_indices, DIALOG_MANAGER.LEVEL_SCENE) ?? 0,
      variable_struct_get(_indices, DIALOG_MANAGER.LEVEL_SEQUENCE) ?? 0,
      variable_struct_get(_indices, DIALOG_MANAGER.LEVEL_DIALOG) ?? 0
    );
  }



  /**
   * @desc Returns the position given the indices for this dialog structure.
   * @param {Real} _scene_idx The scene index value.
   * @param {Real} _sequence_idx The sequence index value.
   * @param {Real} _dialog_idx The dialog index value.
   * @returns {Real}
   */

  static getpositionfromindices = function(_scene_idx, _sequence_idx, _dialog_idx)
  {
    return DialogBitmaskResolver.compose(0, [
      self.__bitmaskregion_scene.encode(_scene_idx),
      self.__bitmaskregion_sequence.encode(_sequence_idx),
      self.__bitmaskregion_dialog.encode(_dialog_idx)
    ]);
  }



  /**
   * @desc Returns the indices given a position for this dialog structure.
   * @param {Real} _position The position value.
   * @returns {Array<Real>}
   */

  static getindicesfromposition = function(_position)
  {
    return [
      self.__bitmaskregion_scene.decode(_position),
      self.__bitmaskregion_sequence.decode(_position),
      self.__bitmaskregion_dialog.decode(_position)
    ];
  }



  /**
   * @desc Returns the indices given a link for this dialog structure.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @returns {Array<Real>}
   */

  static getindicesfromlink = function(_link)
  {
    return self.getindicesfromposition(self.getpositionfromlink(_link));
  }



  /**
   * @desc Returns the link from any data supplied for this dialog structure.
   * @param {Struct.DialogLinkInterface|Constant.DIALOG_MANAGER|Real|Array<Real>} _position_or_link The link object retrieval data.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkfromdata = function(_position_or_link)
  {
    if (is_instanceof(_position_or_link, DialogLinkInterface))
      return _position_or_link;

    if (is_array(_position_or_link))
      return self.getlinkfromindices(_position_or_link);

    return _position_or_link < DIALOG_MANAGER.POSITION_CODE_NONE
      ? self.getlinkfrompositioncode(_position_or_link)
      : self.getlinkfromposition(_position_or_link)
    ;
  }



  /**
   * @desc Returns the assigned id for a DialogItem, generating one when needed.
   * @param {Struct.DialogItem} _item The item to get the unique id for.
   * @returns {Constant.DIALOG_MANAGER|Real}
   */

  static generateid = function(_item)
  {
    if (_item.hasid())
      return _item.getid();

    switch (self.getidgeneratormode())
    {
      case DIALOG_MANAGER.ID_GENERATOR_MODE_AUTOINCREMENTAL:
        return self.assignglobalid(_item);

      case DIALOG_MANAGER.ID_GENERATOR_MODE_PARTITIONED:
        return _item.getpool().assignlocalid(_item);
    }

    return DIALOG_MANAGER.ID_UNASSIGNED;
  }



  /**
   * @desc Calculates the autoincrementing id ensuring uniqueness for generation.
   * @param {Struct.DialogItem} _item The the item to calculate the id for.
   * @returns {Real}
   */

  static assignglobalid = function(_item)
  {
    var _global_item_uids = self.IDS
      , _item_level = _item.getlevel()
      , _item_id = _item.getid()
    ;

    _global_item_uids[_item_level] = max(_global_item_uids[_item_level] + 1, _item_id);

    return _item_id < 0 ? _global_item_uids[_item_level] : _item_id;
  }



  /**
   * @desc Internal recursive method for assignment of stable ids to all items contained.
   * @param {Struct.DialogItem} _i The item to assign an id to.
   * @returns {Bool} Whether the function has operated recursively (`true`) or not (`false`).
   */

  static __finalize_id_assignment = function(_i)
  {
    var _recursion = is_instanceof(_i, DialogLinkInterface);

    _i.obtainid();

    if (_recursion) {
      array_foreach(_i.getitems(), __finalize_id_assignment);
    }

    return _recursion;
  }
}












/**
 * @desc Represents a scene containing ordered dialog sequences and scene settings.
 * @param {Array<Struct.DialogSequence>} _dialog_sequence_list The sequences contained in the scene.
 * @param {Any} _settings_mask The settings mask value.
 * @param {Any} _id The identifier value.
 * @param {Any} _sequence_count The number of sequences of the collection.
 * @returns {Struct.DialogScene}
 */

function DialogScene(_dialog_sequence_list, _settings_mask, _id, _sequence_count) : DialogLinkInterface(_dialog_sequence_list, _settings_mask, _id, _sequence_count) constructor
{
  static LEVEL = DIALOG_MANAGER.LEVEL_SCENE;

  static __bitmaskregion_bg  = DialogBitmaskRegion.from(DIALOG_SCENE.__BITMASK_BG_SHIFT , DIALOG_SCENE.__BITMASK_BG_BITS , DIALOG_SCENE.BG_DEFAULT );
  static __bitmaskregion_bgm = DialogBitmaskRegion.from(DIALOG_SCENE.__BITMASK_BGM_SHIFT, DIALOG_SCENE.__BITMASK_BGM_BITS, DIALOG_SCENE.BGM_DEFAULT);
  static __bitmaskregion_bgs = DialogBitmaskRegion.from(DIALOG_SCENE.__BITMASK_BGS_SHIFT, DIALOG_SCENE.__BITMASK_BGS_BITS, DIALOG_SCENE.BGS_DEFAULT);
  static __bitmaskregion_tag = DialogBitmaskRegion.from(DIALOG_SCENE.__BITMASK_TAG_SHIFT, DIALOG_SCENE.__BITMASK_TAG_BITS, DIALOG_SCENE.TAG_DEFAULT);

  static __bitmaskregions = [
    self.__bitmaskregion_bg, self.__bitmaskregion_bgm, self.__bitmaskregion_bgs, self.__bitmaskregion_tag
  ];

  static __bitmaskregions_count = array_length(self.__bitmaskregions);



  self.initialize();



  /**
   * @desc Creates a scene from its sequence list and settings.
   * @param {Array<Struct.DialogSequence>} [_dialog_sequence_list] The sequences to include in the scene.
   * @param {Real} [_settings_mask] The settings mask value.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The scene identifier.
   * @param {String} [_comment] The comment for the structure.
   * @param {Real} [_sequence_count] The number of sequences in the supplied list.
   * @returns {Struct.DialogScene}
   */

  static create = function(_dialog_sequence_list = [], _settings_mask = undefined, _id = undefined, _comment = undefined, _sequence_count = undefined)
  {
    return new DialogScene(_dialog_sequence_list, _settings_mask, _id, _sequence_count).addcomment(_comment);
  }



  /**
   * @desc Returns the sequence for this dialog scene.
   * @param {Real} [_n] The index value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogSequence}
   */

  static getsequence = function(_n = 0, _filter_fn = undefined, _argv = undefined)
  {
    return self.getitem(_n, _filter_fn, _argv);
  }



  /**
   * @desc Decodes the bg from its settings mask.
   * @param {Real} [_scene_mask] The scene mask value.
   * @returns {Constant.DIALOG_SCENE}
   */

  static decodebg = function(_scene_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_bg, _scene_mask);
  }



  /**
   * @desc Decodes the bgm from its settings mask.
   * @param {Real} [_scene_mask] The scene mask value.
   * @returns {Constant.DIALOG_SCENE}
   */

  static decodebgm = function(_scene_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_bgm, _scene_mask);
  }



  /**
   * @desc Decodes the bgs from its settings mask.
   * @param {Real} [_scene_mask] The scene mask value.
   * @returns {Constant.DIALOG_SCENE}
   */

  static decodebgs = function(_scene_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_bgs, _scene_mask);
  }



  /**
   * @desc Decodes the tag from its settings mask.
   * @param {Real} [_scene_mask] The scene mask value.
   * @returns {Constant.DIALOG_SCENE}
   */

  static decodetag = function(_scene_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_tag, _scene_mask);
  }



  /**
   * @desc Encodes the bg as a settings-mask value.
   * @param {Constant.DIALOG_SCENE} [_scene_bg] The scene bg value.
   * @returns {Real}
   */

  static encodebg = function(_scene_bg = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_bg, _scene_bg);
  }



  /**
   * @desc Encodes the bgm as a settings-mask value.
   * @param {Constant.DIALOG_SCENE} [_scene_bgm] The scene bgm value.
   * @returns {Real}
   */

  static encodebgm = function(_scene_bgm = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_bgm, _scene_bgm);
  }



  /**
   * @desc Encodes the bgs as a settings-mask value.
   * @param {Constant.DIALOG_SCENE} [_scene_bgs] The scene bgs value.
   * @returns {Real}
   */

  static encodebgs = function(_scene_bgs = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_bgs, _scene_bgs);
  }



  /**
   * @desc Encodes the tag as a settings-mask value.
   * @param {Constant.DIALOG_SCENE} [_scene_tag] The scene tag value.
   * @returns {Real}
   */

  static encodetag = function(_scene_tag = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_tag, _scene_tag);
  }



  /**
   * @desc Replaces the bg settings on this dialog scene.
   * @param {Constant.DIALOG_SCENE} [_scene_bg] The scene bg value.
   * @returns {Struct.DialogScene}
   */

  static replacebg = function(_scene_bg = DIALOG_SCENE.BG_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_bg, _scene_bg);
  }



  /**
   * @desc Replaces the bgm settings on this dialog scene.
   * @param {Constant.DIALOG_SCENE} [_scene_bgm] The scene bgm value.
   * @returns {Struct.DialogScene}
   */

  static replacebgm = function(_scene_bgm = DIALOG_SCENE.BGM_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_bgm, _scene_bgm);
  }



  /**
   * @desc Replaces the bgs settings on this dialog scene.
   * @param {Constant.DIALOG_SCENE} [_scene_bgs] The scene bgs value.
   * @returns {Struct.DialogScene}
   */

  static replacebgs = function(_scene_bgs = DIALOG_SCENE.BGS_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_bgs, _scene_bgs);
  }



  /**
   * @desc Replaces the tag settings on this dialog scene.
   * @param {Constant.DIALOG_SCENE} [_scene_tag] The scene tag value.
   * @returns {Struct.DialogScene}
   */

  static replacetag = function(_scene_tag = DIALOG_SCENE.TAG_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_tag, _scene_tag);
  }



  /**
   * @desc Checks whether this dialog scene contains the bg.
   * @param {Constant.DIALOG_SCENE} [_scene_bg] The scene bg value.
   * @returns {Bool}
   */

  static hasbg = function(_scene_bg = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_bg, _scene_bg);
  }



  /**
   * @desc Checks whether this dialog scene contains the bgm.
   * @param {Constant.DIALOG_SCENE} [_scene_bgm] The scene bgm value.
   * @returns {Bool}
   */

  static hasbgm = function(_scene_bgm = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_bgm, _scene_bgm);
  }



  /**
   * @desc Checks whether this dialog scene contains the bgs.
   * @param {Constant.DIALOG_SCENE} [_scene_bgs] The scene bgs value.
   * @returns {Bool}
   */

  static hasbgs = function(_scene_bgs = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_bgs, _scene_bgs);
  }



  /**
   * @desc Checks whether this dialog scene contains the tag.
   * @param {Constant.DIALOG_SCENE} [_scene_tag] The scene tag value.
   * @returns {Bool}
   */

  static hastag = function(_scene_tag = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_tag, _scene_tag);
  }
}












/**
 * @desc Represents an ordered group of dialogs with speaker metadata and sequence settings.
 * @param {Array<Struct.Dialog>} _dialog_list The dialogs contained in the sequence.
 * @param {Any} _settings_mask The settings mask value.
 * @param {Array<Any>} _speaker_list The speakers associated with the sequence.
 * @param {Any} _id The identifier value.
 * @param {Any} _dialog_count The number of dialogs of the collection.
 * @returns {Struct.DialogSequence}
 */

function DialogSequence(_dialog_list, _settings_mask, _speaker_list, _id, _dialog_count) : DialogLinkInterface(_dialog_list, _settings_mask, _id, _dialog_count) constructor
{
  static LEVEL = DIALOG_MANAGER.LEVEL_SEQUENCE;

  static __bitmaskregion_tag = DialogBitmaskRegion.from(DIALOG_SEQUENCE.__BITMASK_TAG_SHIFT, DIALOG_SEQUENCE.__BITMASK_TAG_BITS, DIALOG_SEQUENCE.TAG_DEFAULT);

  static __bitmaskregions = [
    self.__bitmaskregion_tag
  ];

  static __bitmaskregions_count = array_length(self.__bitmaskregions);



  self.initialize();
  self.speakers = DialogItemCollection.normalize(_speaker_list);
  self.speaker_count = array_length(self.speakers);



  /**
   * @desc Creates a sequence from its dialog list, speakers, and settings.
   * @param {Array<Struct.Dialog>} [_dialog_list] The dialogs to include in the sequence.
   * @param {Constant.DIALOG_SEQUENCE|Real} [_settings_mask] The sequence value.
   * @param {Array<Any>} [_speaker_list] The speakers associated with the dialogs.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @param {Real} [_dialog_count] The number of dialogs in the supplied list.
   * @returns {Struct.DialogSequence}
   */

  static create = function(_dialog_list = [], _settings_mask = undefined, _speaker_list = undefined, _id = undefined, _comment = undefined, _dialog_count = undefined)
  {
    return new DialogSequence(_dialog_list, _settings_mask, _speaker_list, _id, _dialog_count).addcomment(_comment);
  }



  /**
   * @desc Returns the dialog for this dialog sequence.
   * @param {Real} [_n] The index value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.Dialog}
   */

  static getdialog = function(_n = 0, _filter_fn = undefined, _argv = undefined)
  {
    return self.getitem(_n, _filter_fn, _argv);
  }



  /**
   * @desc Returns the speakers for this dialog sequence.
   * @returns {Array<Any>}
   */

  static getspeakers = function()
  {
    return self.speakers;
  }



  /**
   * @desc Returns a speaker for this dialog sequence.
   * @param {Real} _idx The index value.
   * @returns {Any}
   */

  static getspeaker = function(_idx)
  {
    return self.speakers[_idx + self.getspeakercount() * (_idx < 0)];
  }



  /**
   * @desc Returns the number of speakers for this dialog sequence.
   * @returns {Real}
   */

  static getspeakercount = function()
  {
    return self.speaker_count;
  }



  /**
   * @desc Decodes the tag from its settings mask.
   * @param {Real} [_sequence_mask] The sequence mask value.
   * @returns {Constant.DIALOG_SEQUENCE} The decoded sequence tag.
   */

  static decodetag = function(_sequence_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_tag, _sequence_mask);
  }



  /**
   * @desc Encodes the tag as a settings-mask value.
   * @param {Constant.DIALOG_SEQUENCE} [_sequence_tag] The sequence tag value.
   * @returns {Real}
   */

  static encodetag = function(_sequence_tag = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_tag, _sequence_tag);
  }



  /**
   * @desc Replaces the tag settings on this dialog sequence.
   * @param {Constant.DIALOG_SEQUENCE} [_sequence_tag] The sequence tag value.
   * @returns {Struct.DialogSequence}
   */

  static replacetag = function(_sequence_tag = DIALOG_SEQUENCE.TAG_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_tag, _sequence_tag);
  }



  /**
   * @desc Checks whether this dialog sequence contains the tag.
   * @param {Constant.DIALOG_SEQUENCE} [_sequence_tag] The sequence tag value.
   * @returns {Bool}
   */

  static hastag = function(_sequence_tag = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_tag, _sequence_tag);
  }



  /**
   * @desc Substitutes all the dialog encoded speakers with a relative index, mapping them inside this dialog sequence's speaker list.
   * @returns {Struct.DialogSequence}
   */

  static rescript = function()
  {
    self.speakers = [];

    var _map = {}
      , _new_speaker_id = 0
      , _dialog_count = self.getitemcount()
    ;

    for (var _i = 0; _i < _dialog_count; ++_i)
    {
      var _dialog = self.getdialog(_i)
        , _speaker = _dialog.decodespeaker()
      ;

      if (!variable_struct_exists(_map, _speaker)) {
        variable_struct_set(_map, _speaker, _new_speaker_id);
        self.speakers[_new_speaker_id++] = _speaker;
      }

      _dialog.replacespeaker(variable_struct_get(_map, _speaker));
    }

    return self;
  }
}












/**
 * @desc Represents a dialog line with text, settings, and attached effects.
 * @param {String} _text The dialog line.
 * @param {Any} _settings_mask The settings mask value.
 * @param {Array<Struct.DialogFX>} _dialog_fx_list The effects attached to the dialog.
 * @param {Any} _id The identifier value.
 * @param {Any} _fx_count The number of effects of the collection.
 * @returns {Struct.Dialog}
 */

function Dialog(_text, _settings_mask, _dialog_fx_list, _id, _fx_count) : DialogLinkInterface(_dialog_fx_list, _settings_mask, _id, _fx_count) constructor
{
  static LEVEL = DIALOG_MANAGER.LEVEL_DIALOG;

  static __bitmaskregion_speaker = DialogBitmaskRegion.from(DIALOG.__BITMASK_SPEAKER_SHIFT, DIALOG.__BITMASK_SPEAKER_BITS, DIALOG.SPEAKER_DEFAULT);
  static __bitmaskregion_emotion = DialogBitmaskRegion.from(DIALOG.__BITMASK_EMOTION_SHIFT, DIALOG.__BITMASK_EMOTION_BITS, DIALOG.EMOTION_DEFAULT);
  static __bitmaskregion_anchor  = DialogBitmaskRegion.from(DIALOG.__BITMASK_ANCHOR_SHIFT , DIALOG.__BITMASK_ANCHOR_BITS , DIALOG.ANCHOR_DEFAULT );
  static __bitmaskregion_textbox = DialogBitmaskRegion.from(DIALOG.__BITMASK_TEXTBOX_SHIFT, DIALOG.__BITMASK_TEXTBOX_BITS, DIALOG.TEXTBOX_DEFAULT);
  static __bitmaskregion_tag     = DialogBitmaskRegion.from(DIALOG.__BITMASK_TAG_SHIFT    , DIALOG.__BITMASK_TAG_BITS    , DIALOG.TAG_DEFAULT    );

  static __bitmaskregions = [
    self.__bitmaskregion_speaker, self.__bitmaskregion_emotion, self.__bitmaskregion_anchor, self.__bitmaskregion_textbox, self.__bitmaskregion_tag
  ];

  static __bitmaskregions_count = array_length(self.__bitmaskregions);

  self.initialize();
  self.text = _text;

  if (DialogManager.TEXT_WIDTH_MAX_FUNC(self) > 0)
  {
    var _text_width = DialogManager.TEXT_WIDTH_FUNC(self);

    if (_text_width > DialogManager.TEXT_WIDTH_MAX) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_TEXT_OVERFLOW, [
        _text_width, Dialog.TEXT_WIDTH_MAX, _text
      ]);
    }
  }



  /**
   * @desc Creates a dialog line from its text, settings, and effects.
   * @param {String} [_text] The dialog line.
   * @param {Constant.DIALOG|Real} [_settings_mask] The settings mask value.
   * @param {Array<Struct.DialogFX>} [_dialog_fx_list] The effects attached to the dialog.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @param {Any} [_fx_count] The number of effects of the collection.
   * @returns {Struct.Dialog}
   */

  static create = function(_text = "", _settings_mask = undefined, _dialog_fx_list = [], _id = undefined, _comment = undefined, _fx_count = undefined)
  {
    return new Dialog(_text, _settings_mask, _dialog_fx_list, _id, _fx_count).addcomment(_comment);
  }



  /**
   * @desc Returns the selected fx for this dialog.
   * @param {Real} [_n] The index value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfx = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getitem(_n, _filter_fn, _argv);
  }



  /**
   * @desc Returns the text for this dialog.
   * @returns {String}
   */

  static gettext = function()
  {
    return self.text;
  }



  /**
   * @desc Returns the selected flow-resolver fx for this dialog.
   * @param {Real} [_n] The index value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxflowresolver = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfx(_n, function(_fx, _argv, _idx) {
      return _fx.isflowresolver() && (!is_callable(_argv[0]) || _argv[0](_fx, _argv[1]));
    }, [_filter_fn, _argv]);
  }



  /**
   * @desc Returns the selected fx of the specified type for this dialog.
   * @param {Constant.DIALOG_FX} [_type] The type of the fx to look for.
   * @param {Real} [_n] The index value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxoftype = function(_type = DIALOG_FX.TYPE_ANY, _n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfx(_n, function(_fx, _argv, _idx) {
      return _fx.hastype(_argv[2]) && (!is_callable(_argv[0]) || _argv[0](_fx, _argv[1]));
    }, [_filter_fn, _argv, _type]);
  }



  /**
   * @desc Returns the selected fx of the specified trigger for this dialog.
   * @param {Constant.DIALOG_FX} [_trigger] The trigger of the fx to look for.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Array<Struct.DialogFX>}
   */

  static getallfxoftrigger = function(_trigger = DIALOG_FX.TRIGGER_DEFAULT, _filter_fn = undefined, _argv = undefined)
  {
    return self.getcollection().getitemswhere(function(_fx, _argv, _idx) {
      return _fx.hastrigger(_argv[2]) && (!is_callable(_argv[0]) || _argv[0](_fx, _argv[1]));
    }, [_filter_fn, _argv, _trigger]);
  }



  /**
   * @desc Returns the selected jump fx for this dialog.
   * @param {Real} [_n] The occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxjump = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfxoftype(DIALOG_FX.TYPE_FLOWRES_JUMP, _n, _filter_fn, _argv);
  }



  /**
   * @desc Returns the selected dispatch fx for this dialog.
   * @param {Real} [_n] The occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxdispatch = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfxoftype(DIALOG_FX.TYPE_FLOWRES_DISPATCH, _n, _filter_fn, _argv);
  }



  /**
   * @desc Returns the selected fallback fx for this dialog.
   * @param {Real} [_n] The occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxfallback = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfxoftype(DIALOG_FX.TYPE_FLOWRES_FALLBACK, _n, _filter_fn, _argv);
  }



  /**
   * @desc Returns the selected choice fx for this dialog.
   * @param {Real} [_n] The occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogFX}
   */

  static getfxchoice = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return self.getfxoftype(DIALOG_FX.TYPE_FLOWRES_CHOICE, _n, _filter_fn, _argv);
  }



  /**
   * @desc Decodes the speaker from its settings mask.
   * @param {Real} [_dialog_mask] The dialog mask value.
   * @returns {Constant.DIALOG}
   */

  static decodespeaker = function(_dialog_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_speaker, _dialog_mask);
  }



  /**
   * @desc Decodes the emotion from its settings mask.
   * @param {Real} [_dialog_mask] The dialog mask value.
   * @returns {Constant.DIALOG}
   */

  static decodeemotion = function(_dialog_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_emotion, _dialog_mask);
  }



  /**
   * @desc Decodes the anchor from its settings mask.
   * @param {Real} [_dialog_mask] The dialog mask value.
   * @returns {Constant.DIALOG}
   */

  static decodeanchor = function(_dialog_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_anchor, _dialog_mask);
  }



  /**
   * @desc Decodes the textbox from its settings mask.
   * @param {Real} [_dialog_mask] The dialog mask value.
   * @returns {Constant.DIALOG}
   */

  static decodetextbox = function(_dialog_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_textbox, _dialog_mask);
  }



  /**
   * @desc Decodes the tag from its settings mask.
   * @param {Real} [_dialog_mask] The dialog mask value.
   * @returns {Constant.DIALOG}
   */

  static decodetag = function(_dialog_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_tag, _dialog_mask);
  }



  /**
   * @desc Encodes the speaker as a settings-mask value.
   * @param {Constant.DIALOG} [_dialog_speaker] The dialog speaker value.
   * @returns {Real}
   */

  static encodespeaker = function(_dialog_speaker = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_speaker, _dialog_speaker);
  }



  /**
   * @desc Encodes the emotion as a settings-mask value.
   * @param {Constant.DIALOG} [_dialog_emotion] The dialog emotion value.
   * @returns {Real}
   */

  static encodeemotion = function(_dialog_emotion = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_emotion, _dialog_emotion);
  }



  /**
   * @desc Encodes the anchor as a settings-mask value.
   * @param {Constant.DIALOG} [_dialog_anchor] The dialog anchor value.
   * @returns {Real}
   */

  static encodeanchor = function(_dialog_anchor = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_anchor, _dialog_anchor);
  }



  /**
   * @desc Encodes the textbox as a settings-mask value.
   * @param {Constant.DIALOG} [_dialog_textbox] The dialog textbox value.
   * @returns {Real}
   */

  static encodetextbox = function(_dialog_textbox = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_textbox, _dialog_textbox);
  }



  /**
   * @desc Encodes the tag as a settings-mask value.
   * @param {Constant.DIALOG} [_dialog_tag] The dialog tag value.
   * @returns {Real}
   */

  static encodetag = function(_dialog_tag = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_tag, _dialog_tag);
  }



  /**
   * @desc Replaces the speaker settings on this dialog.
   * @param {Constant.DIALOG} [_dialog_speaker] The dialog speaker value.
   * @returns {Struct.Dialog}
   */

  static replacespeaker = function(_dialog_speaker = DIALOG.SPEAKER_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_speaker, _dialog_speaker);
  }



  /**
   * @desc Replaces the emotion settings on this dialog.
   * @param {Constant.DIALOG} [_dialog_emotion] The dialog emotion value.
   * @returns {Struct.Dialog}
   */

  static replaceemotion = function(_dialog_emotion = DIALOG.EMOTION_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_emotion, _dialog_emotion);
  }



  /**
   * @desc Replaces the anchor settings on this dialog.
   * @param {Constant.DIALOG} [_dialog_anchor] The dialog anchor value.
   * @returns {Struct.Dialog}
   */

  static replaceanchor = function(_dialog_anchor = DIALOG.ANCHOR_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_anchor, _dialog_anchor);
  }



  /**
   * @desc Replaces the textbox settings on this dialog.
   * @param {Constant.DIALOG} [_dialog_textbox] The dialog textbox value.
   * @returns {Struct.Dialog}
   */

  static replacetextbox = function(_dialog_textbox = DIALOG.TEXTBOX_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_textbox, _dialog_textbox);
  }



  /**
   * @desc Replaces the tag settings on this dialog.
   * @param {Constant.DIALOG} [_dialog_tag] The dialog tag value.
   * @returns {Struct.Dialog}
   */

  static replacetag = function(_dialog_tag = DIALOG.TAG_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_tag, _dialog_tag);
  }



  /**
   * @desc Checks whether this dialog contains the speaker.
   * @param {Constant.DIALOG} [_dialog_speaker] The dialog speaker value.
   * @returns {Bool}
   */

  static hasspeaker = function(_dialog_speaker = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_speaker, _dialog_speaker);
  }



  /**
   * @desc Checks whether this dialog contains the emotion.
   * @param {Constant.DIALOG} [_dialog_emotion] The dialog emotion value.
   * @returns {Bool}
   */

  static hasemotion = function(_dialog_emotion = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_emotion, _dialog_emotion);
  }



  /**
   * @desc Checks whether this dialog contains the anchor.
   * @param {Constant.DIALOG} [_dialog_anchor] The dialog anchor value.
   * @returns {Bool}
   */

  static hasanchor = function(_dialog_anchor = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_anchor, _dialog_anchor);
  }



  /**
   * @desc Checks whether this dialog contains the textbox.
   * @param {Constant.DIALOG} [_dialog_textbox] The dialog textbox value.
   * @returns {Bool}
   */

  static hastextbox = function(_dialog_textbox = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_textbox, _dialog_textbox);
  }



  /**
   * @desc Checks whether this dialog contains the tag.
   * @param {Constant.DIALOG} [_dialog_tag] The dialog tag value.
   * @returns {Bool}
   */

  static hastag = function(_dialog_tag = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_tag, _dialog_tag);
  }
}












/**
 * @desc Represents a dialog effect, its settings, and its effect arguments.
 * @param {Constant.DIALOG_FX|Real} _settings_mask The effect settings bitmask.
 * @param {Any} _fx_argv The arguments consumed by the effect.
 * @param {Constant.DIALOG_MANAGER|Real} _id The effect identifier.
 * @returns {Struct.DialogFX}
 */

function DialogFX(_settings_mask, _fx_argv, _id) : DialogItem(_settings_mask, _id) constructor
{
  static LEVEL = DIALOG_MANAGER.LEVEL_FX;

  static __bitmaskregion_type    = DialogBitmaskRegion.from(DIALOG_FX.__BITMASK_TYPE_SHIFT   , DIALOG_FX.__BITMASK_TYPE_BITS   , DIALOG_FX.TYPE_DEFAULT   );
  static __bitmaskregion_trigger = DialogBitmaskRegion.from(DIALOG_FX.__BITMASK_TRIGGER_SHIFT, DIALOG_FX.__BITMASK_TRIGGER_BITS, DIALOG_FX.TRIGGER_DEFAULT);
  static __bitmaskregion_signal  = DialogBitmaskRegion.from(DIALOG_FX.__BITMASK_SIGNAL_SHIFT , DIALOG_FX.__BITMASK_SIGNAL_BITS , DIALOG_FX.SIGNAL_DEFAULT );
  static __bitmaskregion_tag     = DialogBitmaskRegion.from(DIALOG_FX.__BITMASK_TAG_SHIFT    , DIALOG_FX.__BITMASK_TAG_BITS    , DIALOG_FX.TAG_DEFAULT    );

  static __bitmaskregions = [
    self.__bitmaskregion_type, self.__bitmaskregion_trigger, self.__bitmaskregion_signal, self.__bitmaskregion_tag
  ];

  static __bitmaskregions_count = array_length(self.__bitmaskregions);



  self.initialize();
  self.argv = DialogItemCollection.normalize(_fx_argv);

  if (self.isflowresolver()) {
    self.replacesignal(DIALOG_FX.SIGNAL_STOP_CYCLE);
    self.argv = is_undefined(_fx_argv) ? DialogFlowOptionDTO.create() : _fx_argv;
  }



  /**
   * @desc Creates a dialog effect from its settings and effect arguments.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask value.
   * @param {Any} [_fx_argv] The arguments consumed by the effect.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static create = function(_settings_mask = undefined, _fx_argv = undefined, _id = undefined, _comment = undefined)
  {
    return new DialogFX(_settings_mask, _fx_argv, _id).addcomment(_comment);
  }



  /**
   * @desc Creates the flow resolver from the supplied values.
   * @param {Constant.DIALOG_FX} _type The flowres type of the fx.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The settings mask value.
   * @param {Array} [_flow_option_list] The list of flow options.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static createflowresolver = function(_type, _settings_mask = undefined, _flow_option_list = undefined, _id = undefined, _comment = undefined)
  {
    return self.create(
      self.encodetype(_type) | DialogBitmaskResolver.filterout(_settings_mask ?? 0, self.__bitmaskregion_type.getmask()),
      _flow_option_list,
      _id,
      _comment
    );
  }



  /**
   * @desc Creates the jump from the supplied values.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The fx settings mask value.
   * @param {Array} [_flow_option] The effect flow option.
   * @param {Any} [_flow_settings] The flow settings value.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static createjump = function(_settings_mask = undefined, _flow_option = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
  {
    var _argv = DialogFlowOptionDTO.create([_flow_option], undefined, undefined, undefined, undefined, _flow_settings);

    return self.createflowresolver(DIALOG_FX.TYPE_FLOWRES_JUMP, _settings_mask, _argv, _id, _comment);
  }



  /**
   * @desc Creates the dispatch from the supplied values.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The fx settings mask value.
   * @param {Constant.DIALOG_FX|Real} [_fx_condition_map_idx] The condition-function map index.
   * @param {Constant.DIALOG_FX|Real} [_fx_indexer_map_idx] The indexer-function map index.
   * @param {Any} [_fx_condition_map_argv] The condition function arguments value.
   * @param {Any} [_fx_indexer_map_argv] The indexer function arguments value.
   * @param {Array} [_flow_option_list] The list of flow options.
   * @param {Any} [_flow_settings] The flow settings value.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static createdispatch = function(_settings_mask = undefined, _fx_condition_map_idx = DIALOG_FX.FUNC_CONDITION_DEFAULT, _fx_indexer_map_idx = DIALOG_FX.FUNC_INDEXER_DEFAULT, _fx_condition_map_argv = undefined, _fx_indexer_map_argv = undefined, _flow_option_list = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
  {
    var _argv = DialogFlowOptionDTO.create(_flow_option_list, _fx_condition_map_idx, _fx_indexer_map_idx, _fx_condition_map_argv, _fx_indexer_map_argv, _flow_settings);

    return self.createflowresolver(DIALOG_FX.TYPE_FLOWRES_DISPATCH, _settings_mask, _argv, _id, _comment);
  }



  /**
   * @desc Creates a fallback effect from its condition and flow option.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The fx settings mask value.
   * @param {Constant.DIALOG_FX|Real} [_fx_condition_map_idx] The condition function index.
   * @param {Any} [_fx_condition_map_argv] The condition function arguments value.
   * @param {Array} [_flow_option] The effect flow option.
   * @param {Any} [_flow_settings] The flow settings value.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static createfallback = function(_settings_mask = undefined, _fx_condition_map_idx = DIALOG_FX.FUNC_CONDITION_DEFAULT, _fx_condition_map_argv = undefined, _flow_option = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
  {
    var _argv = DialogFlowOptionDTO.create([_flow_option], _fx_condition_map_idx, undefined, _fx_condition_map_argv, undefined, _flow_settings);

    return self.createflowresolver(DIALOG_FX.TYPE_FLOWRES_FALLBACK, _settings_mask, _argv, _id, _comment);
  }



  /**
   * @desc Creates the choice from the supplied values.
   * @param {Constant.DIALOG_FX|Real} [_settings_mask] The fx settings mask value.
   * @param {Constant.DIALOG_FX|Real} [_fx_indexer_map_idx] The indexer-function map index.
   * @param {Any} [_fx_indexer_map_argv] The indexer function arguments value.
   * @param {Array} [_flow_option_list] The list of flow options.
   * @param {Any} [_flow_settings] The flow settings value.
   * @param {Constant.DIALOG_MANAGER|Real} [_id] The identifier for the item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogFX}
   */

  static createchoice = function(_settings_mask = undefined, _fx_indexer_map_idx = DIALOG_FX.FUNC_INDEXER_DEFAULT, _fx_indexer_map_argv = undefined, _flow_option_list = undefined, _flow_settings = undefined, _id = undefined, _comment = undefined)
  {
    var _argv = DialogFlowOptionDTO.create(_flow_option_list, undefined, _fx_indexer_map_idx, undefined, _fx_indexer_map_argv, _flow_settings);

    return self.createflowresolver(DIALOG_FX.TYPE_FLOWRES_CHOICE, _settings_mask, _argv, _id, _comment);
  }



  /**
   * @desc Returns the consumed arguments for this dialog fx.
   * @returns {Any}
   */

  static getargv = function()
  {
    return self.argv;
  }



  /**
   * @desc Returns the flow options for this dialog fx.
   * @returns {Array}
   */

  static getflowoptions = function()
  {
    return self.isflowresolver()
      ? DialogFlowOptionDTO.getflowoptions(self.getargv())
      : []
    ;
  }



  /**
   * @desc Returns the flow settings for this dialog fx.
   * @returns {Array}
   */

  static getflowsettings = function()
  {
    return DialogFlowOptionDTO.getsettings(self.getargv());
  }



  /**
   * @desc Returns the number of flow options for this dialog fx.
   * @returns {Array}
   */

  static getflowoptioncount = function()
  {
    return array_length(self.getflowoptions());
  }



  /**
   * @desc Returns the flow option prompt for this dialog fx.
   * @param {Real} _idx The flow option index.
   * @returns {String}
   */

  static getflowoptionprompt = function(_idx)
  {
    if (!self.isflowresolver())
      return "";

    var _flow_option = DialogFlowOptionDTO.getflowoption(self.getargv(), _idx);

    return DialogFlowOptionDTO.getflowprompt(_flow_option);
  }



  /**
   * @desc Returns the flow option metadata for this dialog fx.
   * @param {Real} _idx The flow option index.
   * @returns {Any}
   */

  static getflowoptionmetadata = function(_idx)
  {
    if (!self.isflowresolver())
      return undefined;

    var _flow_option = DialogFlowOptionDTO.getflowoption(self.getargv(), _idx);

    return DialogFlowOptionDTO.getflowmetadata(_flow_option);
  }



  /**
   * @desc Adds the supplied flow option to this dialog fx.
   * @param {Array} _flow_option The flow option value.
   * @param {Real} [_index] The index value.
   * @returns {Struct.DialogFX}
   */

  static insertflowoption = function(_flow_option, _index = undefined)
  {
    var _flow_option_list = self.getflowoptions()
      , _flow_option_count = self.getflowoptioncount()
    ;

    switch (self.decodetype())
    {
      case DIALOG_FX.TYPE_FLOWRES_JUMP:
      case DIALOG_FX.TYPE_FLOWRES_FALLBACK:
        _flow_option_list[DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION] = _flow_option;
      break;

      case DIALOG_FX.TYPE_FLOWRES_CHOICE:
      case DIALOG_FX.TYPE_FLOWRES_DISPATCH:
      {
        _index ??= _flow_option_count;

        if (_index >= _flow_option_count || is_array(_flow_option_list[_index]))
          array_insert(_flow_option_list, _index, _flow_option);
        else
          _flow_option_list[_index] = _flow_option;
      }
      break;
    }

    return self;
  }



  /**
   * @desc Decodes the type from its settings mask.
   * @param {Real} [_fx_mask] The fx mask value.
   * @returns {Constant.DIALOG_FX}
   */

  static decodetype = function(_fx_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_type, _fx_mask);
  }



  /**
   * @desc Decodes the trigger from its settings mask.
   * @param {Real} [_fx_mask] The fx mask value.
   * @returns {Constant.DIALOG_FX}
   */

  static decodetrigger = function(_fx_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_trigger, _fx_mask);
  }



  /**
   * @desc Decodes the signal from its settings mask.
   * @param {Real} [_fx_mask] The fx mask value.
   * @returns {Constant.DIALOG_FX}
   */

  static decodesignal = function(_fx_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_signal, _fx_mask);
  }



  /**
   * @desc Decodes the tag from its settings mask.
   * @param {Real} [_fx_mask] The fx mask value.
   * @returns {Constant.DIALOG_FX}
   */

  static decodetag = function(_fx_mask = undefined)
  {
    return self.decodesettingsmaskregion(self.__bitmaskregion_tag, _fx_mask);
  }



  /**
   * @desc Encodes the type as a settings-mask value.
   * @param {Constant.DIALOG_FX} [_fx_type] The fx type value.
   * @returns {Real}
   */

  static encodetype = function(_fx_type = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_type, _fx_type);
  }



  /**
   * @desc Encodes the trigger as a settings-mask value.
   * @param {Constant.DIALOG_FX} [_fx_trigger] The fx trigger value.
   * @returns {Real}
   */

  static encodetrigger = function(_fx_trigger = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_trigger, _fx_trigger);
  }



  /**
   * @desc Encodes the signal as a settings-mask value.
   * @param {Constant.DIALOG_FX} [_fx_signal] The fx signal value.
   * @returns {Real}
   */

  static encodesignal = function(_fx_signal = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_signal, _fx_signal);
  }



  /**
   * @desc Encodes the tag as a settings-mask value.
   * @param {Constant.DIALOG_FX} [_fx_tag] The fx tag value.
   * @returns {Real}
   */

  static encodetag = function(_fx_tag = undefined)
  {
    return self.encodesettingsmaskregion(self.__bitmaskregion_tag, _fx_tag);
  }



  /**
   * @desc Replaces the type settings on this dialog fx.
   * @param {Constant.DIALOG_FX} [_fx_type] The fx type value.
   * @returns {Struct.DialogFX}
   */

  static replacetype = function(_fx_type = DIALOG_FX.TYPE_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_type, _fx_type);
  }



  /**
   * @desc Replaces the trigger settings on this dialog fx.
   * @param {Constant.DIALOG_FX} [_fx_trigger] The fx trigger value.
   * @returns {Struct.DialogFX}
   */

  static replacetrigger = function(_fx_trigger = DIALOG_FX.TRIGGER_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_trigger, _fx_trigger);
  }



  /**
   * @desc Replaces the signal settings on this dialog fx.
   * @param {Constant.DIALOG_FX} [_fx_signal] The fx signal value.
   * @returns {Struct.DialogFX}
   */

  static replacesignal = function(_fx_signal = DIALOG_FX.SIGNAL_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_signal, _fx_signal);
  }



  /**
   * @desc Replaces the tag settings on this dialog fx.
   * @param {Constant.DIALOG_FX} [_fx_tag] The fx tag value.
   * @returns {Struct.DialogFX}
   */

  static replacetag = function(_fx_tag = DIALOG_FX.TAG_DEFAULT)
  {
    return self.replacesettingsmaskregion(self.__bitmaskregion_tag, _fx_tag);
  }



  /**
   * @desc Checks whether this dialog fx contains the type.
   * @param {Constant.DIALOG_FX} [_fx_type] The fx type value.
   * @returns {Bool}
   */

  static hastype = function(_fx_type = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_type, _fx_type);
  }



  /**
   * @desc Checks whether this dialog fx contains the trigger.
   * @param {Constant.DIALOG_FX} [_fx_trigger] The fx trigger value.
   * @returns {Bool}
   */

  static hastrigger = function(_fx_trigger = undefined)
  {
    return self.hassettingsmaskregionflag(self.__bitmaskregion_trigger, _fx_trigger);
  }



  /**
   * @desc Checks whether this dialog fx contains the signal.
   * @param {Constant.DIALOG_FX} [_fx_signal] The fx signal value.
   * @returns {Bool}
   */

  static hassignal = function(_fx_signal = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_signal, _fx_signal);
  }



  /**
   * @desc Checks whether this dialog fx contains the tag.
   * @param {Constant.DIALOG_FX} [_fx_tag] The fx tag value.
   * @returns {Bool}
   */

  static hastag = function(_fx_tag = undefined)
  {
    return self.hassettingsmaskregionvalue(self.__bitmaskregion_tag, _fx_tag);
  }



  /**
   * @desc Checks whether a dialog fx type is a flow resolver.
   * @param {Constant.DIALOG_FX} [_fx_type] The fx type value.
   * @returns {Bool}
   */

  static isflowresolver = function(_fx_type = self.decodetype())
  {
    return _fx_type >= DIALOG_FX.__TYPE_FLOWRES_START && _fx_type <= DIALOG_FX.__TYPE_FLOWRES_END;
  }
}












#endregion

// ----------------------------------------------------------------------------

#region Secondary functions












/**
 * @desc Stores a bounded history of dialog links visited by a runner.
 * @param {Array} _items The history items.
 * @param {Real} _size The history size.
 * @returns {Struct.DialogHistory}
 */

function DialogHistory(_items, _size) constructor
{
  if (_size <= 0) {
    throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
      nameof(_size), _size
    ]);
  }

  self.items = _items;
  self.size = _size;

  if (array_length(_items) > _size) {
    self.resize(_size);
  }



  /**
   * @desc Creates this dialog history from the supplied values.
   * @param {Array<Struct.DialogLinkInterface} _items The list of history entries.
   * @param {Real} [_size] The maximum history size.
   * @returns {Struct.DialogHistory}
   */

  static from = function(_items, _size = DIALOG_RUNNER.HISTORY_MAX_SIZE)
  {
    return new DialogHistory(_items, _size);
  }



  /**
   * @desc Returns the size for this dialog history.
   * @returns {Real}
   */

  static getsize = function()
  {
    return self.size;
  }



  /**
   * @desc Returns the selected entry for this dialog history.
   * @param {Real} _idx The index value.
   * @returns {Struct.DialogItem}
   */

  static getentry = function(_idx)
  {
    return self.items[_idx + self.getsize() * (_idx < 0)];
  }



  /**
   * @desc Adds the supplied entry to this dialog history.
   * @param {Struct.DialogLinkInterface} _entry The entry to add.
   * @returns {Struct.DialogHistory}
   */

  static add = function(_entry)
  {
    array_insert(self.items, 0, _entry);

    return self.resize(self.getsize());
  }



  /**
   * @desc Resizes the dialog history to a specified amount of elements.
   * @param {Real} _size The new size.
   * @returns {Struct.DialogHistory}
   */

  static resize = function(_size)
  {
    array_resize(self.items, _size);

    return self;
  }
}












/**
 * @desc Converts raw dialog data into dialog-manager structures.
 * @returns {Struct.DialogImporter}
 */

function DialogImporter() : DialogRawInterface() constructor
{
  /**
   * @desc Reads text from a file path or an already open text file handle.
   * @param {String|Id.TextFile} _file_path The file path or open file handle to read.
   * @returns {String} The complete text read from the source.
   */

  static read = function(_file_path)
  {
    var _file = _file_path
      , _filename = _file_path
      , _autoclose = !is_numeric(_file)
    ;

    try
    {
      if (_autoclose)
        _file = file_text_open_read(_filename);

      for (_file_path = ""; !file_text_eof(_file); file_text_readln(_file))
        _file_path += file_text_read_string(_file);

      if (_autoclose)
        file_text_close(_file);
    }
    catch (_ex) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_FAILED_DESERIALIZATION, [_filename]);
    }

    return _file_path;
  }



  /**
   * @desc Parses JSON text or reads and parses JSON from a file.
   * @param {String} [_data_string] The data string to parse.
   * @param {Bool} [_is_file] Specifies whether the data string is a file name to read from (`true`) or not (`false`). Defaults to `false`.
   * @returns {Struct}
   */

  static readjson = function(_data_string = "", _is_file = false)
  {
    try {
      return json_parse(_is_file ? self.read(_data_string) : _data_string);
    }
    catch (_ex) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_FAILED_PARSING);
    }
  }



  /**
   * @desc Reads JSON data and wraps it as a raw dialog source.
   * @param {String} [_data_string] The data string to parse.
   * @param {Bool} [_is_file] Specifies whether the data string is a file name to read from (`true`) or not (`false`). Defaults to `false`.
   * @returns {Struct.DialogRawSource}
   */

  static readsource = function(_data_string = "", _is_file = false)
  {
    return DialogRawSource.from(self.readjson(_data_string, _is_file));
  }



  /**
   * @desc Parses a string loading all the data in a dialog structure. Throws DIALOG_MANAGER.ERR_FAILED_DESERIALIZATION if deserialization fails.
   * @param {String|Id.TextFile} [_data_string] The data string to parse.
   * @param {Bool} [_is_file] Specifies whether the data string is a file name to read from (`true`) or not (`false`). Defaults to `false`.
   * @param {Constant.DIALOG_MANAGER} [_import_format] The data format used to import the structure.
   * @returns {Struct.DialogStructure} The imported dialog structure.
   */

  static importstructure = function(_data_string = "", _is_file = false, _import_format = DIALOG_MANAGER.FORMAT_DEFAULT)
  {
    var _structure_source = self.readsource(_data_string, _is_file)
      , _import_mode = _import_format == DIALOG_MANAGER.FORMAT_ARRAY
        ? self.array2scene
        : self.struct2scene
    ;

    return DialogStructure.create(
        array_map(_structure_source.get(__DIALOG_CONTAINER_FIELD_ITEMS__), _import_mode),
        _structure_source.get(__DIALOG_CONTAINER_FIELD_ITEMCOUNT__),
        _structure_source.get(__DIALOG_STRUCTURE_FIELD_LANG__)
      )
      .setcommentprefix(_structure_source.get(__DIALOG_STRUCTURE_FIELD_COMMENT_PREFIX__))
      .setlinkencodingsizes(_structure_source.get(__DIALOG_STRUCTURE_FIELD_LINK_ENCODING_SIZES__))
      .setidgeneratormode(_structure_source.get(__DIALOG_STRUCTURE_FIELD_ID_GENERATOR_MODE__))
      .setids(_structure_source.get(__DIALOG_STRUCTURE_FIELD_MAX_IDS__))
    ;
  }



  /**
   * @desc Converts an array-form scene into a DialogScene.
   * @param {Array|Struct} _scene_data The raw scene data to convert.
   * @returns {Struct.DialogScene} The converted scene.
   */

  static array2scene = function(_scene_data)
  {
    var _scene_source = DialogRawSource.from(_scene_data);

    return DialogScene.create(
      array_map(_scene_source.get(DIALOG_SCENE.ARG_SEQUENCES), self.array2sequence),
      _scene_source.get(DIALOG_SCENE.ARG_SETTINGS_MASK),
      _scene_source.get(DIALOG_SCENE.ARG_ID),
      _scene_source.get(DIALOG_SCENE.ARG_COMMENT),
      _scene_source.get(DIALOG_SCENE.ARG_SEQUENCE_COUNT)
    );
  }



  /**
   * @desc Converts an array-form sequence into a DialogSequence.
   * @param {Array|Struct} _sequence_data The raw sequence data to convert.
   * @returns {Struct.DialogSequence} The converted sequence.
   */

  static array2sequence = function(_sequence_data)
  {
    var _sequence_source = DialogRawSource.from(_sequence_data);

    return DialogSequence.create(
      array_map(_sequence_source.get(DIALOG_SEQUENCE.ARG_DIALOGS), self.array2dialog),
      _sequence_source.get(DIALOG_SEQUENCE.ARG_SETTINGS_MASK),
      _sequence_source.get(DIALOG_SEQUENCE.ARG_SPEAKERS),
      _sequence_source.get(DIALOG_SEQUENCE.ARG_ID),
      _sequence_source.get(DIALOG_SEQUENCE.ARG_COMMENT),
      _sequence_source.get(DIALOG_SEQUENCE.ARG_DIALOG_COUNT)
    );
  }



  /**
   * @desc Converts an array-form dialog into a Dialog.
   * @param {Array|Struct} _dialog_data The raw dialog data to convert.
   * @returns {Struct.Dialog} The converted dialog.
   */

  static array2dialog = function(_dialog_data)
  {
    var _dialog_source = DialogRawSource.from(_dialog_data);

    return Dialog.create(
      _dialog_source.get(DIALOG.ARG_TEXT),
      _dialog_source.get(DIALOG.ARG_SETTINGS_MASK),
      array_map(_dialog_source.get(DIALOG.ARG_FX_LIST), self.array2fx),
      _dialog_source.get(DIALOG.ARG_ID),
      _dialog_source.get(DIALOG.ARG_COMMENT),
      _dialog_source.get(DIALOG.ARG_FX_COUNT)
    );
  }



  /**
   * @desc Converts an array-form effect into a DialogFX.
   * @param {Array|Struct} _fx_data The raw effect data to convert.
   * @returns {Struct.DialogFX} The converted effect.
   */

  static array2fx = function(_fx_data)
  {
    var _fx_source = DialogRawSource.from(_fx_data);

    return DialogFX.create(
      _fx_source.get(DIALOG_FX.ARG_SETTINGS_MASK),
      _fx_source.get(DIALOG_FX.ARG_ARGV),
      _fx_source.get(DIALOG_FX.ARG_ID),
      _fx_source.get(DIALOG_FX.ARG_COMMENT)
    );
  }



  /**
   * @desc Converts a struct-form scene into a DialogScene.
   * @param {Struct} _scene_data The raw scene data to convert.
   * @returns {Struct.DialogScene} The converted scene.
   */

  static struct2scene = function(_scene_data)
  {
    var _scene_source = DialogRawSource.from(_scene_data);

    return DialogScene.create(
      array_map(_scene_source.get(__DIALOG_CONTAINER_FIELD_ITEMS__), self.struct2sequence),
      _scene_source.get(__DIALOG_ITEM_FIELD_SETTINGS__),
      _scene_source.get(__DIALOG_ITEM_FIELD_ID__),
      _scene_source.get(__DIALOG_ITEM_FIELD_COMMENT__),
      _scene_source.get(__DIALOG_CONTAINER_FIELD_ITEMCOUNT__)
    );
  }



  /**
   * @desc Converts a struct-form sequence into a DialogSequence.
   * @param {Struct} _sequence_data The raw sequence data to convert.
   * @returns {Struct.DialogSequence} The converted sequence.
   */

  static struct2sequence = function(_sequence_data)
  {
    var _sequence_source = DialogRawSource.from(_sequence_data);

    return DialogSequence.create(
      array_map(_sequence_source.get(__DIALOG_CONTAINER_FIELD_ITEMS__), self.struct2dialog),
      _sequence_source.get(__DIALOG_ITEM_FIELD_SETTINGS__),
      _sequence_source.get(__DIALOG_SEQUENCE_FIELD_SPEAKERS__),
      _sequence_source.get(__DIALOG_ITEM_FIELD_ID__),
      _sequence_source.get(__DIALOG_ITEM_FIELD_COMMENT__),
      _sequence_source.get(__DIALOG_CONTAINER_FIELD_ITEMCOUNT__)
    );
  }



  /**
   * @desc Converts a struct-form dialog into a Dialog.
   * @param {Struct} _dialog_data The raw dialog data to convert.
   * @returns {Struct.Dialog} The converted dialog.
   */

  static struct2dialog = function(_dialog_data)
  {
    var _dialog_source = DialogRawSource.from(_dialog_data);

    return Dialog.create(
      _dialog_source.get(__DIALOG_FIELD_TEXT__),
      _dialog_source.get(__DIALOG_ITEM_FIELD_SETTINGS__),
      array_map(_dialog_source.get(__DIALOG_CONTAINER_FIELD_ITEMS__), self.struct2fx),
      _dialog_source.get(__DIALOG_ITEM_FIELD_ID__),
      _dialog_source.get(__DIALOG_ITEM_FIELD_COMMENT__),
      _dialog_source.get(__DIALOG_CONTAINER_FIELD_ITEMCOUNT__)
    );
  }



  /**
   * @desc Converts a struct-form effect into a DialogFX.
   * @param {Struct} _fx_data The raw effect data to convert.
   * @returns {Struct.DialogFX} The converted effect.
   */

  static struct2fx = function(_fx_data)
  {
    var _fx_source = DialogRawSource.from(_fx_data);

    return DialogFX.create(
      _fx_source.get(__DIALOG_ITEM_FIELD_SETTINGS__),
      _fx_source.get(__DIALOG_FX_FIELD_ARGV__),
      _fx_source.get(__DIALOG_ITEM_FIELD_ID__),
      _fx_source.get(__DIALOG_ITEM_FIELD_COMMENT__)
    );
  }
}












/**
 * @desc Converts dialog-manager structures into supported raw formats.
 * @returns {Struct.DialogExporter}
 */

function DialogExporter() : DialogRawInterface() constructor
{
  /**
   * @desc Exports the supplied structure to the requested format.
   * @param {Struct.DialogStructure} _dialog_structure The structure to export.
   * @param {Constant.DIALOG_MANAGER} [_export_format] The output format.
   * @returns {Struct}
   */

  static exportstructure = function(_dialog_structure, _export_format = DIALOG_MANAGER.FORMAT_DEFAULT)
  {
    var _export_mode = _export_format == DIALOG_MANAGER.FORMAT_ARRAY
      ? self.scene2array
      : self.scene2struct
    ;

    return {
      __DIALOG_MANAGER_FIELD_LINK__: DialogManager.getlink(),
      __DIALOG_MANAGER_FIELD_VERSION__: DialogManager.getversion(),
      __DIALOG_STRUCTURE_FIELD_LANG__: _dialog_structure.getlang(),
      __DIALOG_CONTAINER_FIELD_ITEMS__: array_map(_dialog_structure.getitems(), _export_mode),
      __DIALOG_CONTAINER_FIELD_ITEMCOUNT__: _dialog_structure.getitemcount(),
      __DIALOG_STRUCTURE_FIELD_COMMENT_PREFIX__: _dialog_structure.getcommentprefix(),
      __DIALOG_STRUCTURE_FIELD_MAX_IDS__: _dialog_structure.getids(),
      __DIALOG_STRUCTURE_FIELD_ID_GENERATOR_MODE__: _dialog_structure.getidgeneratormode(),
      __DIALOG_STRUCTURE_FIELD_LINK_ENCODING_SIZES__: _dialog_structure.getlinkencodingsizes(),
    };
  }



  /**
   * @desc Exports the supplied diff to the requested format.
   * @param {Struct.DialogDiffResultDTO} _diff The diff value.
   * @returns {Struct}
   */

  static exportdiff = function(_diff)
  {
    return {
      __DIALOG_DIFF_FIELD_TREE__: self.exportdifftree(_diff.gettree()),
      __DIALOG_DIFF_FIELD_SUMMARY__: self.exportdiffsummary(_diff.getsummary()),
    };
  }



  /**
   * @desc Exports the supplied diff tree to the requested format.
   * @param {Struct.DialogDiffResultLevelDTO} _diff_tree The diff tree value.
   * @returns {Struct}
   */

  static exportdifftree = function(_diff_tree)
  {
    return {
      __DIALOG_DIFF_TREE_FIELD_NODECOUNT__: _diff_tree.getnodecount(),
      __DIALOG_DIFF_TREE_FIELD_DIFFCOUNT__: _diff_tree.getdiffcount(),
      __DIALOG_DIFF_TREE_FIELD_DIFFCOUNTSUB__: _diff_tree.getdiffcountsub(),
      __DIALOG_DIFF_TREE_FIELD_NODES__: array_map(_diff_tree.getnodes(), self.exportdifftreenode),
    };
  }



  /**
   * @desc Exports the supplied diff tree node to the requested format.
   * @param {Struct.DialogDiffNodeDTO} _diff_tree_node The diff tree node value.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static exportdifftreenode = function(_diff_tree_node)
  {
    variable_struct_remove(_diff_tree_node, __DIALOG_DIFF_TREE_NODE_FIELD_STATS__);
    array_foreach(_diff_tree_node.getitems(), self.exportdifftreenode);

    return _diff_tree_node.usereadabledata();
  }



  /**
   * @desc Exports the supplied diff summary to the requested format.
   * @param {Struct.DialogDiffSummaryDTO} _diff_summary The diff summary value.
   * @returns {Struct}
   */

  static exportdiffsummary = function(_diff_summary)
  {
    return {
      __DIALOG_DIFF_SUMMARY_FIELD_SEVERITY__: _diff_summary.getseverity(),
      __DIALOG_DIFF_SUMMARY_FIELD_NODES__: _diff_summary.getsummarynodes(),
      __DIALOG_DIFF_SUMMARY_FIELD_LEVELS__: array_map(_diff_summary.getsummarylevels(), function(_slv) {
        variable_struct_remove(_slv.gettolerance(), __DIALOG_DIFF_SUMMARY_LEVEL_FIELD_PARAM_TYPES__);
        return _slv.usereadabledata();
      }),
    };
  }



  /**
   * @desc Exports the supplied effect argument value to the requested format.
   * @param {Any} _arg The effect argument to convert.
   * @returns {Real|String}
   */

  static exportarg = function(_arg)
  {
    if (is_array(_arg))
      return array_map(_arg, self.exportarg);

    if (is_instanceof(_arg, DialogLinkInterface))
      return _arg.getposition();

    if (is_handle(_arg))
    {
      var _name_getters = {
        asset_font: font_get_name,
        asset_path: path_get_name,
        asset_room: room_get_name,
        asset_sound: audio_get_name,
        asset_sprite: sprite_get_name,
        asset_object: object_get_name,
        asset_script: script_get_name,
        asset_shader: shader_get_name,
        asset_tiles: tileset_get_name,
        asset_timeline: timeline_get_name,
      };

      var _getter = variable_struct_get(_name_getters, asset_get_type(_arg));

      if (_getter)
        return _getter(_arg);
    }

    return is_numeric(_arg) && frac(_arg) == 0
      ? int64(_arg)
      : _arg
    ;
  }



  /**
   * @desc Converts the scene to an array-form raw structure.
   * @param {Struct.DialogScene} _scene The scene object.
   * @returns {Array}
   */

  static scene2array = function(_scene)
  {
    var _ret = [];

    _ret[DIALOG_SCENE.ARG_SEQUENCES] = array_map(_scene.getitems(), self.sequence2array);
    _ret[DIALOG_SCENE.ARG_SETTINGS_MASK] = _scene.getsettingsmask();
    _ret[DIALOG_SCENE.ARG_ID] = _scene.getid();
    _ret[DIALOG_SCENE.ARG_COMMENT] = _scene.getcomment();
    _ret[DIALOG_SCENE.ARG_SEQUENCE_COUNT] = _scene.getitemcount();

    return _ret;
  }



  /**
   * @desc Converts the sequence to an array-form raw structure.
   * @param {Struct.DialogSequence} _sequence The sequence object.
   * @returns {Array}
   */

  static sequence2array = function(_sequence)
  {
    var _ret = [];

    _ret[DIALOG_SEQUENCE.ARG_DIALOGS] = array_map(_sequence.getitems(), self.dialog2array);
    _ret[DIALOG_SEQUENCE.ARG_SETTINGS_MASK] = _sequence.getsettingsmask();
    _ret[DIALOG_SEQUENCE.ARG_SPEAKERS] = self.exportarg(_sequence.getspeakers());
    _ret[DIALOG_SEQUENCE.ARG_ID] = string(_sequence.getid());
    _ret[DIALOG_SEQUENCE.ARG_COMMENT] = _sequence.getcomment();
    _ret[DIALOG_SEQUENCE.ARG_DIALOG_COUNT] = _sequence.getitemcount();

    return _ret;
  }



  /**
   * @desc Converts the dialog to an array-form raw structure.
   * @param {Struct.Dialog} _dialog The dialog object.
   * @returns {Array}
   */

  static dialog2array = function(_dialog)
  {
    var _ret = [];

    _ret[DIALOG.ARG_TEXT] = _dialog.gettext();
    _ret[DIALOG.ARG_SETTINGS_MASK] = _dialog.getsettingsmask();
    _ret[DIALOG.ARG_FX_LIST] = array_map(_dialog.getitems(), self.fx2array);
    _ret[DIALOG.ARG_ID] = string(_dialog.getid());
    _ret[DIALOG.ARG_COMMENT] = _dialog.getcomment();
    _ret[DIALOG.ARG_FX_COUNT] = _dialog.getitemcount();

    return _ret;
  }



  /**
   * @desc Converts the dialog effect to an array-form raw structure.
   * @param {Struct.DialogFX} _fx The fx object.
   * @returns {Array}
   */

  static fx2array = function(_fx)
  {
    var _ret = [];

    _ret[DIALOG_FX.ARG_SETTINGS_MASK] = _fx.getsettingsmask();
    _ret[DIALOG_FX.ARG_ARGV] = self.exportarg(_fx.getargv());
    _ret[DIALOG_FX.ARG_ID] = string(_fx.getid());
    _ret[DIALOG_FX.ARG_COMMENT] = _fx.getcomment();

    return _ret;
  }



  /**
   * @desc Converts the scene to a struct-form raw structure.
   * @param {Struct.DialogScene} _scene The scene object.
   * @returns {Struct}
   */

  static scene2struct = function(_scene)
  {
    return {
      __DIALOG_CONTAINER_FIELD_ITEMS__: array_map(_scene.getitems(), self.sequence2struct),
      __DIALOG_ITEM_FIELD_SETTINGS__: _scene.getsettingsmask(),
      __DIALOG_ITEM_FIELD_ID__: string(_scene.getid()),
      __DIALOG_ITEM_FIELD_COMMENT__: _scene.getcomment(),
      __DIALOG_CONTAINER_FIELD_ITEMCOUNT__: _scene.getitemcount(),
    };
  }



  /**
   * @desc Converts the sequence to a struct-form raw structure.
   * @param {Struct.DialogSequence} _sequence The sequence object.
   * @returns {Struct}
   */

  static sequence2struct = function(_sequence)
  {
    return {
      __DIALOG_CONTAINER_FIELD_ITEMS__: array_map(_sequence.getitems(), self.dialog2struct),
      __DIALOG_ITEM_FIELD_SETTINGS__: _sequence.getsettingsmask(),
      __DIALOG_SEQUENCE_FIELD_SPEAKERS__: self.exportarg(_sequence.getspeakers()),
      __DIALOG_ITEM_FIELD_ID__: string(_sequence.getid()),
      __DIALOG_ITEM_FIELD_COMMENT__: _sequence.getcomment(),
      __DIALOG_CONTAINER_FIELD_ITEMCOUNT__: _sequence.getitemcount(),
    };
  }



  /**
   * @desc Converts the dialog to a struct-form raw structure.
   * @param {Struct.Dialog} _dialog The dialog object.
   * @returns {Struct}
   */

  static dialog2struct = function(_dialog)
  {
    return {
      __DIALOG_FIELD_TEXT__: _dialog.gettext(),
      __DIALOG_ITEM_FIELD_SETTINGS__: _dialog.getsettingsmask(),
      __DIALOG_CONTAINER_FIELD_ITEMS__: array_map(_dialog.getitems(), self.fx2struct),
      __DIALOG_ITEM_FIELD_ID__: string(_dialog.getid()),
      __DIALOG_ITEM_FIELD_COMMENT__: _dialog.getcomment(),
      __DIALOG_CONTAINER_FIELD_ITEMCOUNT__: _dialog.getitemcount(),
    };
  }



  /**
   * @desc Converts the dialog effect to a struct-form raw structure.
   * @param {Struct.DialogFX} _fx The fx object.
   * @returns {Struct}
   */

  static fx2struct = function(_fx)
  {
    return {
      __DIALOG_ITEM_FIELD_SETTINGS__: _fx.getsettingsmask(),
      __DIALOG_FX_FIELD_ARGV__: self.exportarg(_fx.getargv()),
      __DIALOG_ITEM_FIELD_ID__: string(_fx.getid()),
      __DIALOG_ITEM_FIELD_COMMENT__: _fx.getcomment(),
    };
  }
}












/**
 * @desc Resolves dialog jumps, effects and flow options for a dialog runner.
 * @param {Struct.DialogRunner} _runner The runner object.
 * @param {Struct.DialogLinkInterface} _link_start The link start object.
 * @param {Struct.DialogLinkInterface} _link_target The link target object.
 * @returns {Struct.DialogResolver}
 */

function DialogResolver(_runner, _link_start, _link_target) : DialogBitmaskRegionWorker() constructor
{
  static __bitmaskregion_jump_mode_type              = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_SHIFT         , DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_TYPE_BITS         , DIALOG_RUNNER.JUMP_OPTION_TYPE_RELATIVE);
  static __bitmaskregion_jump_mode_unit              = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT         , DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_BITS         , DIALOG_RUNNER.JUMP_OPTION_UNIT_DIALOG  );
  static __bitmaskregion_jump_behavior_fx            = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_SHIFT           , DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_BITS           , 0                                      );
  static __bitmaskregion_jump_behavior_fx_maintained = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_SHIFT, DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_FX_MAINTAINED_BITS, 0                                      );
  static __bitmaskregion_jump_behavior_restriction   = DialogBitmaskRegion.from(DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT  , DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_BITS  , 0                                      );



  self.runner = _runner;
  self.context = DialogJumpContextDTO.from(self, _link_start, _link_target);



  /**
   * @desc Creates a dialog resolver from the supplied from.
   * @param {Struct.DialogRunner} _runner The runner object.
   * @param {Any} [_link_start] The link start object.
   * @param {Any} [_link_target] The link target object.
   * @returns {Struct.DialogResolver}
   */

  static from = function(_runner, _link_start = undefined, _link_target = undefined)
  {
    return new DialogResolver(_runner, _link_start, _link_target);
  }



  /**
   * @desc Returns the runner for this dialog resolver.
   * @returns {Struct.DialogRunner}
   */

  static getrunner = function()
  {
    return self.runner;
  }



  /**
   * @desc Returns the structure for this dialog resolver.
   * @returns {Struct.DialogStructure}
   */

  static getstructure = function()
  {
    return self.getrunner().getstructure();
  }



  /**
   * @desc Returns the context for this dialog resolver.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static getcontext = function()
  {
    return self.context;
  }



  /**
   * @desc Sets the context for this dialog resolver.
   * @param {Struct.DialogJumpContextDTO} _context The context object.
   * @returns {Struct.DialogResolver}
   */

  static setcontext = function(_context)
  {
    if (!is_instanceof(_context, DialogJumpContextDTO)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_context), _context
      ]);
    }

    self.context = _context;

    return self;
  }



  /**
   * @desc Evaluates a signal for the current flow and determines whether it must interrupt a resolution cycle.
   * @param {Constant.DIALOG_FX} _signal The dialog effect signal value to check.
   * @returns {Bool}
   */

  static signalinterrupts = function(_signal)
  {
    return _signal >= DIALOG_FX.SIGNAL_STOP_RESOLUTION;
  }



  /**
   * @desc Decodes the jump unit from a jump settings mask.
   * @param {Real} _settings_mask The settings mask value.
   * @param {Constant.DIALOG_RUNNER} [_shift] The shift of the dialog runner constant mask.
   * @returns {Constant.DIALOG_RUNNER}
   */

  static decodejumpunit = function(_settings_mask, _shift = DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_SHIFT)
  {
    return DialogBitmaskResolver.decodemask(_settings_mask, _shift, DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_UNIT_BITS);
  }



  /**
   * @desc Resolves a link object relative to a starting position and a shift for the current dialog flow.
   * @param {Struct.DialogLinkInterface} _link_start The link start object.
   * @param {Real} _shift The shift value.
   * @param {Real} _jump_settings The jump settings value.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static resolvelinkrelative = function(_link_start, _shift, _jump_settings)
  {
    var _jump_unit = self.decodejumpunit(_jump_settings)
      , _jump_unit_restrict = self.decodejumpunit(_jump_settings, DIALOG_RUNNER.__BITMASK_JUMP_SETTINGS_RESTRICTION_SHIFT)
    ;

    _jump_unit = _jump_unit != DIALOG_RUNNER.JUMP_UNIT_NONE ? _jump_unit : _link_start.getlevel();
    _link_start = _link_start.getlinkoflevel(_jump_unit);

    var _structure = self.getstructure()
      , _link_target = _structure.getlinkrelative(_link_start, _shift)
      , _link_result = _link_target
      , _bit_count = 0
      , _bit_rpad = 0
    ;

    // *: No restrictions ==> return retrieved target link
    if (!_jump_unit_restrict)
      return self.jumpresult(_link_result, 0);

    // *: restriction.unit <= jump.unit ==> maintain start link and set all [restriction, unit] bits
    if (_jump_unit_restrict <= _jump_unit) {
      _bit_count = _jump_unit - _jump_unit_restrict + 1;
      _bit_rpad = _jump_unit_restrict - DIALOG_MANAGER.__LEVELS_LINKABLE_START;
      _link_result = _link_start;
    }
    // *: restriction.unit > jump.unit ==> if exists top container level maintained set all [unit, maintained] bits
    else
    {
      var _link_start_restrict = _link_start.getlinkoflevel(_jump_unit_restrict)
        , _link_target_restrict = _link_target.getlinkoflevel(_jump_unit_restrict)
        , _link_should_maintain = _link_start_restrict != _link_target_restrict
        , _maintain_unit = _link_should_maintain
            ? _link_start_restrict.getlinksharedlevel(_link_target_restrict) - 1
            : 0
      ;

      if (_link_should_maintain)
      {
        _link_result = _link_start_restrict;

        while (_link_result.getlevel() > _jump_unit) {
          _link_result = _link_result.getitemextrema(_shift);
        }

        _bit_count = _maintain_unit - _jump_unit_restrict + 1;
        _bit_rpad = _jump_unit_restrict - DIALOG_MANAGER.__LEVELS_LINKABLE_START;
      }
    }

    return self.jumpresult(
      _link_result, DialogBitmaskResolver.createmask(_bit_count, DIALOG_RUNNER.__BITMASK_STATUS_MAINTAINED_SHIFT + _bit_rpad)
    );
  }



  /**
   * @desc Resolves the jump for the current dialog flow.
   * @param {Struct.DialogLinkInterface} _link_target The link target object.
   * @param {Struct.DialogLinkInterface} _link_start The link start object.
   * @param {Real} _jump_settings The jump settings value.
   * @param {Any} _argv_exec The arguments for dialog effect execution.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static resolvejump = function(_link_target, _link_start, _jump_settings, _argv_exec)
  {
    var _link_current = _link_start
      , _jump_is_maintained = DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_INFO_MAINTAINED)
      , _jump_should_execute_on_leave_maintained = DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_EXEC_FX_ON_LEAVE_IF_MAINTAINED)
      , _jump_should_execute_on_enter_maintained = DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_EXEC_FX_ON_ENTER_IF_MAINTAINED)
      , _jump_should_execute_on_leave = !DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_BYPASS_FX_ON_LEAVE)
      , _jump_should_execute_on_enter = !DialogBitmaskResolver.getflag(_jump_settings, DIALOG_RUNNER.JUMP_SETTING_BYPASS_FX_ON_ENTER)
      , _jump_context = self.getcontext().setlinks(_link_start, _link_target)
      , _jump_result = _jump_context.getresult()
      , _jump_flow = _jump_context
    ;

    for (var _jump_count = 0; !is_undefined(_jump_flow); ++_jump_count)
    {
      if (_jump_count > DIALOG_MANAGER.ERRCHECK_JUMP_INFINITE_LOOP_TRESHOLD) {
        throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INFINITE_JUMP_LOOP_DETECTED, [
          _jump_count, _link_current
        ]);
      }

      _jump_is_maintained *= !_jump_count;

      _jump_flow = self.resolvefxcycle(
        _link_current,
        DIALOG_FX.TRIGGER_ON_LEAVE,
        _argv_exec,
        _jump_is_maintained && _link_current.equals(_link_start)
          ? _jump_should_execute_on_leave_maintained
          : _jump_should_execute_on_leave
      );

      if (_jump_flow && self.signalinterrupts(_jump_flow.getsignal()))
        break;

      _jump_flow = self.resolvefxcycle(
        _jump_context.getlinktarget(),
        DIALOG_FX.TRIGGER_ON_ENTER,
        _argv_exec,
        _jump_is_maintained && _jump_context.getlinktarget().equals(_link_start)
          ? _jump_should_execute_on_enter_maintained
          : _jump_should_execute_on_enter
      );

      if (_jump_flow && self.signalinterrupts(_jump_flow.getsignal()))
        break;

      _link_current = _jump_context.getlinktarget();
    }

    return _jump_result;
  }


  /**
   * @desc Returns a jump result.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Constant.DIALOG_RUNNER|Real} [_status] The runner status value.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static jumpresult = function(_link, _status = 0)
  {
    return DialogJumpResultDTO.from(_link, _status);
  }



  /**
   * @desc Resolves triggered effects for the current dialog when the condition is satisfied.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Constant.DIALOG_FX} _trigger The fx trigger value.
   * @param {Any} _argv_exec The arguments for dialog effect execution.
   * @param {Bool} _condition_exec The condition for executing the provided link's effect list.
   * @returns {Struct.DialogJumpContextDTO|undefined} The resolved context, or undefined when skipped.
   */

  static resolvefxcycle = function(_link, _trigger, _argv_exec, _condition_exec)
  {
    return _condition_exec
      ? self.executefxcycle(_link.todialog().getallfxoftrigger(_trigger), _argv_exec)
      : undefined
    ;
  }



  /**
   * @desc Executes all the dialog effects of the cycle for the current dialog flow.
   * @param {Array<Struct.DialogFX>} _fx_list The dialog effects to run.
   * @param {Any} [_argv_exec] The argument for dialog effect execution.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static executefxcycle = function(_fx_list, _argv_exec = undefined)
  {
    var _fx_count = array_length(_fx_list)
      , _cycle_is_resolved = false
      , _fx_cycle_skip_next = false
      , _fx_cycle_idx_first_exec = -1
      , _fx_cycle_idx_last_exec = _fx_cycle_idx_first_exec
      , _fx_cycle_idx_previous_exec = _fx_cycle_idx_last_exec
      , _fx_cycle_loop_goto_next = false
      , _ctx = self.getcontext()
    ;

    for (var _i = 0; _i < _fx_count; ++_i)
    {
      var _fx_exec_count = _ctx.getfxexecutedcount();

      if (_fx_exec_count > DIALOG_MANAGER.ERRCHECK_FX_INFINITE_LOOP_TRESHOLD) {
        throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INFINITE_FX_LOOP_DETECTED, [
          _fx_exec_count, _ctx
        ]);
      }

      if (_fx_cycle_idx_first_exec < 0) {
        _fx_cycle_idx_first_exec = _i;
      }

      if (_fx_cycle_skip_next) {
        _fx_cycle_skip_next = false;
        continue;
      }

      self.executefx(_fx_list[_i], _argv_exec, _i);
      _fx_cycle_idx_previous_exec = _fx_cycle_idx_last_exec;
      _fx_cycle_idx_last_exec = _i;

      var _signal = _ctx.getsignal();

      switch (_signal)
      {
        case DIALOG_FX.SIGNAL_STOP_RESOLUTION:
        case DIALOG_FX.SIGNAL_STOP_CYCLE:
          _cycle_is_resolved = true;
        break;

        case DIALOG_FX.SIGNAL_REPEAT_CYCLE:
          _i = _fx_cycle_idx_first_exec - 1;
          _fx_cycle_loop_goto_next = true;
        break;

        case DIALOG_FX.SIGNAL_REPEAT_PREVIOUS_FX:
          _i = (_fx_cycle_idx_previous_exec < 0 ? _fx_cycle_idx_last_exec : _fx_cycle_idx_previous_exec) - 1;
          _fx_cycle_loop_goto_next = true;
        break;

        case DIALOG_FX.SIGNAL_REPEAT_FX:
          _i -= 1;
          _fx_cycle_loop_goto_next = true;
        break;
      }

      if (_cycle_is_resolved)
        break;

      if (_fx_cycle_loop_goto_next) {
        _fx_cycle_loop_goto_next = false;
        continue;
      }

      _fx_cycle_skip_next = _signal == DIALOG_FX.SIGNAL_SKIP_NEXT_FX;
    }

    return _cycle_is_resolved ? _ctx : undefined;
  }



  /**
   * @desc Executes effects accepted by the filter function.
   * @param {Array<Struct.DialogFX>} _fx_list The dialog effects to execute.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv_exec] The arguments for filtering and dialog effect execution.
   * @returns {Struct.DialogResolver}
   */

  static executeallfxwhere = function(_fx_list, _filter_fn = function(_fx, _argv, _idx) { return true; }, _argv_exec = undefined)
  {
    return self.executeallfxuntil(_fx_list, undefined, _filter_fn, _argv_exec);
  }



  /**
   * @desc Executes effects until the stop function matches an effect.
   * @param {Array<Struct.DialogFX>} _fx_list The dialog effects to execute.
   * @param {Function} [_stop_fn] The stopping function.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv_exec] The arguments for filtering and dialog effect execution.
   * @returns {Struct.DialogResolver}
   */

  static executeallfxuntil = function(_fx_list, _stop_fn = function(_fx, _argv, _idx) { return false; }, _filter_fn = function(_fx, _argv, _idx) { return true; }, _argv_exec = undefined)
  {
    var _fx_count = array_length(_fx_list);

    for (var _i = 0; _i < _fx_count; ++_i)
    {
      var _fx = _fx_list[_i];

      if (_stop_fn(_fx, _argv_exec, _i))
        return self;

      if (_filter_fn(_fx, _argv_exec, _i)) {
        self.executefx(_fx, _argv_exec, _i);
      }
    }

    return self;
  }



  /**
   * @desc Executes one effect using its registered function.
   * @param {Struct.DialogFX} _fx The fx object.
   * @param {Any} _argv The arguments for the effect.
   * @param {Real} _idx The index value.
   * @returns {Any} The value returned by the effect function.
   */

  static executefx = function(_fx, _argv, _idx)
  {
    var _fx_func = DialogManager.FX_MAPS[DIALOG_FX.MAP_INDEX_NORMAL].getfunc(_fx.decodetype());

    return _fx_func(_argv ?? _fx.getargv(), self.getcontext().countexecution(_fx, +1, _idx));
  }



  /**
   * @desc Resolves the flow option for the current dialog flow.
   * @param {Array} _flow_option The flow option to resolve.
   * @returns {Struct.DialogJumpResultDTO} The result of the flow resolution.
   */

  static resolveflowoption = function(_flow_option)
  {
    var _runner = self.getrunner()
      , _structure = _runner.getstructure()
      , _ctx = self.getcontext()
    ;

    if (!_ctx)
      return undefined;

    var _flow_source = _runner.getcurrentlink()
      , _flow_destination = DialogFlowOptionDTO.getflowpositiondestination(_flow_option)
      , _flow_settings = DialogFlowOptionDTO.getflowpositionsettings(_flow_option)
    ;

    if (!DialogBitmaskResolver.getflag(_flow_settings, DIALOG_RUNNER.JUMP_OPTION_TYPE_RELATIVE))
      return self.jumpresult(_structure.getlinkfromdata(_flow_destination));

    return self.resolvelinkrelative(_flow_source, _flow_destination, _flow_settings);
  }



  /**
   * @desc Executes the jump flow effect using its flow-option arguments.
   * @param {Any} _argv The arguments for the effect.
   * @param {Struct.DialogCycleContext} _ctx The ctx object.
   * @returns {Struct.DialogLinkInterface}
   */

  static __fx_jump = function(_argv, _ctx)
  {
    return _ctx.success(
      self.resolveflowoption(DialogFlowOptionDTO.getflowoption(_argv, 0))
        .composestatus(DIALOG_RUNNER.STATUS_EXECUTED_JUMP)
    );
  }



  /**
   * @desc Executes the dispatch flow effect and resolves its selected option.
   * @param {Any} _argv The arguments for the effect.
   * @param {Struct.DialogCycleContext} _ctx The ctx object.
   * @returns {Struct.DialogLinkInterface}
   */

  static __fx_dispatch = function(_argv, _ctx)
  {
    var _condition_idx = DialogFlowOptionDTO.getconditionindex(_argv)
      , _condition_argv = DialogFlowOptionDTO.getconditionargv(_argv)
      , _indexer_idx = DialogFlowOptionDTO.getindexerindex(_argv)
      , _indexer_argv = DialogFlowOptionDTO.getindexerargv(_argv)
    ;

    if (!_ctx.evaluatecondition(_condition_idx, _condition_argv))
      return _ctx.fail();

    var _idx = _ctx.evaluateindexer(_indexer_idx, _indexer_argv);

    if (self.indexunselected(_idx))
      return _ctx.fail();

    return _ctx.success(
      self.resolveflowoption(DialogFlowOptionDTO.getflowoption(_argv, _idx))
        .composestatus(DIALOG_RUNNER.STATUS_EXECUTED_DISPATCH)
    );
  }



  /**
   * @desc Executes the fallback flow effect when its condition is satisfied.
   * @param {Any} _argv The arguments for the effect.
   * @param {Struct.DialogCycleContext} _ctx The ctx object.
   * @returns {Struct.DialogLinkInterface}
   */

  static __fx_fallback = function(_argv, _ctx)
  {
    var _condition_idx = DialogFlowOptionDTO.getconditionindex(_argv)
      , _condition_argv = DialogFlowOptionDTO.getconditionargv(_argv)
    ;

    if (!_ctx.evaluatecondition(_condition_idx, _condition_argv))
      return _ctx.fail();

    return _ctx.success(
      self.resolveflowoption(DialogFlowOptionDTO.getflowoption(_argv, 0))
        .composestatus(DIALOG_RUNNER.STATUS_EXECUTED_FALLBACK)
    );
  }



  /**
   * @desc Executes the choice flow effect and resolves the selected option.
   * @param {Any} _argv The arguments for the effect.
   * @param {Struct.DialogCycleContext} _ctx The ctx object.
   * @returns {Struct.DialogLinkInterface}
   */

  static __fx_choice = function(_argv, _ctx)
  {
    var _indexer_idx = DialogFlowOptionDTO.getindexerindex(_argv)
      , _indexer_argv = DialogFlowOptionDTO.getindexerargv(_argv)
      , _idx = _ctx.evaluateindexer(_indexer_idx, _indexer_argv)
    ;

    if (self.indexunselected(_idx))
      return _ctx.fail();

    return _ctx.success(
      self.resolveflowoption(DialogFlowOptionDTO.getflowoption(_argv, _idx))
        .composestatus(DIALOG_RUNNER.STATUS_EXECUTED_DISPATCH)
    );
  }



  /**
   * @desc Checks whether a provided index value is counted as an index not selected.
   * @param {Real} [_idx] The index value.
   * @returns {Bool}
   */

  static indexunselected = function(_idx = DIALOG_FX.FX_ARG_FLOWRES_INDEX_UNSELECTED)
  {
    return _idx <= DIALOG_FX.FX_ARG_FLOWRES_INDEX_UNSELECTED;
  }
}












/**
 * @desc Compares dialog structures and produces a structured difference result.
 * @returns {Struct.DialogComparator}
 */

function DialogComparator() constructor
{
  /**
   * @desc Calculates the differences between two dialog structures, returning a tree of differences with stats and severity calculated based on the provided tolerance parameters.
   * @param {Struct.DialogStructure} _dialog_structure_source The source dialog structure.
   * @param {Struct.DialogStructure} _dialog_structure_candidate The candidate dialog structure.
   * @param {Array<Struct.DialogDiffParamGroupDTO|Array<Array<Real>>} [_diff_param_group] The parameters to use for calculating the differences. Defaults to `DialogDiffParamGroupDTO.from()`.
   * @returns {Struct.DialogDiffResultDTO}
   */

  static diff = function(_dialog_structure_source, _dialog_structure_candidate, _diff_param_group = DialogDiffParamGroupDTO.from())
  {
    if (!is_instanceof(_diff_param_group, DialogDiffParamGroupDTO)) {
      _diff_param_group = DialogDiffParamGroupDTO.from(_diff_param_group);
    }

    return DialogDiffResultDTO.from(self.difflevel(_dialog_structure_source, _dialog_structure_candidate, DIALOG_MANAGER.__LEVELS_LINKABLE_END - 1, $"DialogStructure\{{_dialog_structure_source.getlang()}\}"), _diff_param_group);
  }



  /**
   * @desc Calculates the differences between two lists of items, returning a tree of differences with stats and severity calculated based on the provided tolerance parameters.
   * @param {Struct.DialogItemCollection} _c1 The first container of items.
   * @param {Struct.DialogItemCollection} _c2 The second container of items.
   * @param {Real} [_lv] The current level of the recursion, used for path generation. Defaults to `0`.
   * @param {String} [_path] The current path in the tree, used for node identification. Defaults to `"DialogManager.{self.lang}"`.
   * @returns {Struct.DiffResultLevelDTO}
   */

  static difflevel = function(_c1, _c2, _lv = infinity, _path = "")
  {
    var _l1 = _c1.getitems()
      , _l2 = _c2.getitems()
      , _diff_data = self.difflist(_l1, _c1.getitemcount(), _l2, _c2.getitemcount())
      , _diff_data_count = _diff_data.getoperationcount()
      , _has_direct_structural_changes = false
      , _diff_count_sub = 0
      , _diff_count = 0
      , _node_count = 0
      , _node_array = []
    ;

    for (var _i = 0; _i < _diff_data_count; ++_i)
    {
      var _op = _diff_data.getoperation(_i)
        , _op_type = _op.gettype()
        , _node = DialogDiffNodeDTO.from(_op, _lv, $"{_path}.{DialogDiffDTO.getlevelname(_lv)}({_op.getindex()})")
        , _diff_incr = 1
      ;

      _has_direct_structural_changes |= _op_type < DIALOG_MANAGER.DIFF_OP_MODIFIED;

      if (_op_type == DIALOG_MANAGER.DIFF_OP_MATCHED)
      {
        var _l1_item = _l1[_op.getindex()]
          , _l2_item = _l2[_op.getindexmatch()]
          , _recursion = DialogLinkInterface.islinkablelevel(_lv)
          , _level_data = _recursion
              ? self.difflevel(_l1_item.getcollection(), _l2_item.getcollection(), _lv - 1, _node.getpath())
              : undefined
        ;

        _diff_incr &= _recursion && _level_data.getdiffcount();

        if (_diff_incr)
        {
          if (_level_data.hasdirectstructuralchanges()) {
            _node.setoperationtype(DIALOG_MANAGER.DIFF_OP_MODIFIED);
          }

          _node.setitems(_level_data.getnodes());
          _diff_count_sub += _level_data.getdiffcountsub();
        }
      }

      if (_diff_incr) {
        _node_array[_node_count++] = _node;
      }

      _diff_count += _diff_incr;
    }

    return DialogDiffResultLevelDTO.from(
      _node_array, _node_count, _diff_count, _diff_count_sub, _has_direct_structural_changes
    );
  }



  /**
   * @desc Calculates the longest common subsequence between two lists of items, returning a list of operations to transform the first list into the second list.
   * @param {Array<Struct.DialogItem>} _l1 The first list of items.
   * @param {Real} _n The number of items in the first list.
   * @param {Array<Struct.DialogItem>} _l2 The second list of items.
   * @param {Real} _m The number of items in the second list.
   * @returns {Struct.DialogDiffResultListDTO}
   */

  static difflist = function(_l1, _n, _l2, _m)
  {
    var _w = _m + 1
      , _dp = array_create((_n + 1) * _w, 0)
    ;

    for (var _i = 1; _i <= _n; ++_i) {
      for (var _j = 1; _j <= _m; ++_j) {
        if (_l1[_i - 1].getid() == _l2[_j - 1].getid()) {
          _dp[_i * _w + _j] = _dp[(_i - 1) * _w + _j - 1] + 1;
        }
        else {
          _dp[_i * _w + _j] = max(_dp[(_i - 1) * _w + _j], _dp[_i * _w + _j - 1]);
        }
      }
    }

    var _i = _n, _j = _m, _f
      , _operations = []
    ;

    for (_f = 0; _i || _j; ++_f)
    {
      var _l1i = _i - 1, _l2j = _j - 1;

      if (_i && _j && _l1[_l1i].getid() == _l2[_l2j].getid())
      {
        var _type = _l1i == _l2j
          ? DIALOG_MANAGER.DIFF_OP_MATCHED
          : DIALOG_MANAGER.DIFF_OP_MOVED
        ;

        _operations[_f] = DialogDiffOperationDTO.from(_l1[_l1i].id, _type, _l1i, _l2j);
        --_i;
        --_j;
      }
      else if (_j && (!_i || _dp[_i * _w + _l2j] >= _dp[_l1i * _w + _j])) {
        _operations[_f] = DialogDiffOperationDTO.from(_l2[_l2j].getid(), DIALOG_MANAGER.DIFF_OP_INSERTED, _l2j);
        --_j;
      }
      else {
        _operations[_f] = DialogDiffOperationDTO.from(_l1[_l1i].getid(), DIALOG_MANAGER.DIFF_OP_DELETED, _l1i);
        --_i;
      }
    }

    return self.diffresolvemoves(array_reverse(_operations), _f);
  }



  /**
   * @desc Resolves MOVE operations in a list of diff nodes.
   * @param {Array<Struct.DialogDiffOperationDTO>} _operations_array The list of operation nodes to resolve.
   * @param {Real} [_node_count] The number of operations of the list.
   * @returns {Struct.DialogDiffResultListDTO}
   */

  static diffresolvemoves = function(_operations_array, _node_count = 0)
  {
    var _insertions = {}
      , _deletions = {}
    ;

    for (var _i = 0; _i < _node_count; ++_i)
    {
      var _op = _operations_array[_i];

      switch (_op.gettype())
      {
        case DIALOG_MANAGER.DIFF_OP_INSERTED:
          _insertions[$ _op.getid()] = _i;
        break;

        case DIALOG_MANAGER.DIFF_OP_DELETED:
          _deletions[$ _op.getid()] = _i;
        break;
      }
    }

    var _keys = variable_struct_get_names(_insertions)
      , _to_remove = array_create(ceil(_node_count / 64), 0)
    ;

    for (var _i = array_length(_keys) - 1; _i >= 0; --_i)
    {
      var _id = _keys[_i];

      if (variable_struct_exists(_deletions, _id))
      {
        var _index_ins = _insertions[$ _id]
          , _index_del = _deletions[$ _id]
          , _ins = _operations_array[_index_ins]
          , _del = _operations_array[_index_del]
        ;

        _to_remove[_index_del >> 6] |= 1 << (_index_del & 0x3F);
        _ins.settype(DIALOG_MANAGER.DIFF_OP_MOVED)
          .setindexmatch(_ins.getindex())
          .setindex(_del.getindex())
        ;
      }
    }

    var _resolved = []
      , _resolved_count = 0
    ;

    for (var _i = 0; _i < _node_count; ++_i) {
      if (!(_to_remove[_i >> 6] >> (_i & 0x3F) & 1)) {
        _resolved[_resolved_count++] = _operations_array[_i];
      }
    }

    return DialogDiffResultListDTO.from(_resolved, _resolved_count);
  }
}












#endregion

// ----------------------------------------------------------------------------

#region Abstractions












/**
 * @desc Provides shared level and parent behavior for dialog data objects.
 * @param {Struct.DialogItemInterface} _parent The parent object.
 * @returns {Struct.DialogItemInterface}
 */

function DialogItemInterface(_parent) : DialogBitmaskRegionWorker() constructor
{
  self.parent = _parent;



  /**
   * @desc Returns the parent for this dialog level item.
   * @returns {Struct.DialogItemInterface}
   */

  static getparent = function()
  {
    return self.parent;
  }



  /**
   * @desc Sets the parent for this dialog level item.
   * @param {Any} _parent The parent object.
   * @returns {Struct.DialogItemInterface}
   */

  static setparent = function(_parent)
  {
    if (is_undefined(_parent)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_parent), _parent
      ]);
    }

    self.parent = _parent;

    return self;
  }
}












/**
 * @desc Provides indexed collection behavior for dialog items.
 * @param {Array} _items The item list.
 * @param {Struct.DialogItemInterface} _parent The parent object.
 * @param {Real} _item_count The number of items of the collection.
 * @returns {Struct.DialogItemCollection}
 */

function DialogItemCollection(_items, _parent, _item_count) : DialogItemInterface(_parent) constructor
{
  _items = self.normalize(_items);
  _item_count ??= array_length(_items);

  if (_item_count && is_undefined(_items[0])) {
    throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
      nameof(_items), _items
    ]);
  }

  self.maxid = DIALOG_MANAGER.ID_UNASSIGNED;
  self.maxidindex = DIALOG_MANAGER.ID_UNASSIGNED;

  self.items = [];
  self.item_count = 0;
  self.add(_items, 0, undefined, _item_count);



  /**
   * @desc Creates this dialog item collection from the supplied from.
   * @param {Array<Struct.DialogItem>} _items The item list.
   * @param {Struct.DialogItemInterface} _parent The parent object.
   * @param {Real} [_item_count] The number of items of the collection.
   * @returns {Struct.DialogItemCollection}
   */

  static from = function(_items, _parent, _item_count = undefined)
  {
    return new DialogItemCollection(_items, _parent, _item_count);
  }



  /**
   * @desc Calculates the max id of the pool of a given item.
   * @param {Struct.DialogItem} _item The item to assign the id to.
   * @returns {Real}
   */

  static assignlocalid = function(_item)
  {
    if (_item.getpool() != self)
      return DIALOG_MANAGER.ID_UNASSIGNED;

    self.maxidindex = _item.getindex();
    self.maxid += 1;

    var _id_current = self.maxid + 1
      , _item_level = _item.getlevel()
      , _item_level_parent = _item_level + 1
      , _item_level_string = max(DIALOG_MANAGER.__LEVELS_LINKABLE_START, _item_level)
      , _id_prefix = _item_level_parent < DIALOG_MANAGER.__LEVELS_LINKABLE_END
          ? string_delete($"{_item.getparent().getid()}", 1, 1)
          : ""
      , _id_digits = floor(log10(_id_current)) + 1
      , _zero_lpad = DIALOG_MANAGER.__ID_SEPARATOR_PARTITIONED_DIGITS - _id_digits
      , _id_current_string = string_repeat("0", _zero_lpad) + string(_id_current)
    ;

    return int64($"{_item_level_string}{_id_prefix}{_id_current_string}");
  }



  /**
   * @desc Returns the wrapped index for this dialog item collection.
   * @param {Real} _idx The index value.
   * @returns {Real}
   */

  static getwrappedindex = function(_idx)
  {
    return (_idx % self.item_count + self.item_count * (_idx < 0)) % self.item_count;
  }



  /**
   * @desc Returns the index bounded for this dialog item collection.
   * @param {Real} _idx The index value.
   * @param {Real} [_range] The range value.
   * @returns {Real}
   */

  static getindexbounded = function(_idx, _range = 0)
  {
    _range = abs(_range);

    return clamp(_idx, -_range, self.item_count + _range);
  }



  /**
   * @desc Returns the item count for this dialog item collection.
   * @returns {Real}
   */

  static getitemcount = function()
  {
    return int64(self.item_count);
  }



  /**
   * @desc Returns the remaining item count from a provided index for this dialog item collection.
   * @param {Real} _idx The index value.
   * @param {Real} [_dir] The direction value.
   * @returns {Real}
   */

  static getremainingitemcount = function(_idx, _dir = 1)
  {
    return _dir > 0
      ? self.item_count - _idx - 1
      : _idx
    ;
  }



  /**
   * @desc Returns the item list of this collection.
   * @returns {Array<Struct.DialogItem>}
   */

  static getitems = function()
  {
    return self.items;
  }



  /**
   * @desc Returns the collection for this dialog item collection. USED FOR DialogStructure COMPATIBILITY IN POSITION RESOLUTION. DO NOT REMOVE.
   * @returns {Struct.DialogItemCollection}
   */

  static getcollection = function()
  {
    return self;
  }



  /**
   * @desc Returns the selected item for this dialog item collection.
   * @param {Real} [_idx] The index value.
   * @returns {Struct.DialogItem}
   */

  static getitem = function(_idx = 0)
  {
    return self.items[self.getwrappedindex(_idx)];
  }



  /**
   * @desc Returns the selected bounded item for this dialog item collection.
   * @param {Real} _idx The index value.
   * @param {Real} [_range] The range value.
   * @returns {Struct.DialogItem}
   */

  static getitembounded = function(_idx, _range = 0)
  {
    return self.getitem(self.getindexbounded(_idx, _range));
  }



  /**
   * @desc Checks whether this dialog item collection contains items matching a filter function.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering function.
   * @returns {Bool}
   */

  static hasitemsof = function(_filter_fn = function(_item, _argv, _idx) { return true; }, _argv = undefined)
  {
    return !is_undefined(self.getitemfirstof(_filter_fn, _argv));
  }



  /**
   * @desc Returns the first item matching a filter for this dialog item collection.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogItem}
   */

  static getitemfirstof = function(_filter_fn = function(_item, _argv, _idx) { return true; }, _argv = undefined)
  {
    for (var _i = 0; _i < self.item_count; ++_i)
      if (_filter_fn(self.items[_i], _argv, _i))
        return self.items[_i];

    return undefined;
  }



  /**
   * @desc Returns the last item matching a filter for this dialog item collection.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogItem}
   */

  static getitemlastof = function(_filter_fn = function(_item, _argv, _idx) { return true; }, _argv = undefined)
  {
    var _item = undefined;

    for (var _i = 0; _i < self.item_count; ++_i)
      if (_filter_fn(self.items[_i], _argv, _i))
        _item = self.items[_i];

    return _item;
  }



  /**
   * @desc Returns the selected item matching a filter for this dialog item collection.
   * @param {Real} [_n] The occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogItem}
   */

  static getitemnthof = function(_n = 1, _filter_fn = function(_item, _argv, _idx) { return true; }, _argv = undefined)
  {
    var _item = undefined
      , _idx_shift_sign = sign(_n)
      , _start_idx = (self.item_count - 1) * (_n < 0)
      , _end_idx = (self.item_count - 1) * (_n > 0) + _idx_shift_sign
    ;

    _n = abs(_n);

    for (var _i = _start_idx; _n && _i != _end_idx; _i += _idx_shift_sign)
      if (_filter_fn(self.items[_i], _argv, _i) && _n--)
        _item = self.items[_i];

    return _n ? undefined : _item;
  }



  /**
   * @desc Returns the items accepted by the supplied filter function.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering function.
   * @returns {Array<Struct.DialogItem>}
   */

  static getitemswhere = function(_filter_fn = function(_item, _argv) { return true; }, _argv = undefined)
  {
    return self.getitemsuntil(undefined, _filter_fn, _argv);
  }



  /**
   * @desc Returns filtered items up to the first item accepted by the stop function.
   * @param {Function} [_stop_fn] The stop function value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any|Array<Any>} [_argv] The arguments for the filtering and stopping function.
   * @returns {Array<Struct.DialogItem>}
   */

  static getitemsuntil = function(_stop_fn = function(_item, _argv, _idx) { return false; }, _filter_fn = function(_item, _argv, _idx) { return true; }, _argv = undefined)
  {
    var _filtered = [];

    for (var _i = 0; _i < self.item_count; ++_i)
    {
      var _item = self.items[_i];

      if (_stop_fn(_item, _argv, _i))
        break;

      if (_filter_fn(_item, _argv, _i)) {
        array_push(_filtered, _item);
      }
    }

    return _filtered;
  }



  /**
   * @desc Adds the supplied item list to this dialog item collection.
   * @param {Array<Struct.DialogItem>} _items The item list to insert.
   * @param {Real} [_idx] The index value where to insert the new items.
   * @param {Function} [_item_map_fn] The function to map the items with before insertion.
   * @param {Real} [_item_count] The number of items in the supplied list.
   * @returns {Struct.DialogItemCollection}
   */

  static add = function(_items, _idx = self.item_count, _item_map_fn = undefined, _item_count = undefined)
  {
    _items = self.normalize(_items);
    _item_count ??= array_length(_items);

    for (var _i = _idx; _i < self.item_count; ++_i) {
      self.items[_i].shiftidx(_item_count);
    }

    for (var _i = 0; _i < _item_count; ++_i)
    {
      var _insertion_idx = _idx + _i
        , _item = self.mapitem(_items[_i], _insertion_idx, _item_map_fn)
      ;

      if (_item.iscomplete()) {
        array_insert(self.items, _insertion_idx, _item);
      }
    }

    self.item_count += _item_count;

    return self;
  }



  /**
   * @desc Removes the selected items from this dialog item collection.
   * @param {Real} [_item_count] The number of items to remove.
   * @param {Real} [_idx] The index value.
   * @returns {Struct.DialogItemCollection}
   */

  static remove = function(_item_count = -1, _idx = self.item_count - 1)
  {
    if (_item_count != 0)
    {
      var _count_abs = abs(_item_count)
        , _count_is_negative = _item_count < 0
      ;

      self.item_count -= _count_abs;
      _idx -= _count_abs * _count_is_negative - _count_is_negative;
      array_delete(self.items, _idx, _count_abs);

      for (var _i = _idx; _i < self.item_count; ++_i) {
        self.items[_i].shiftidx(-_count_abs);
      }
    }

    return self;
  }



  /**
   * @desc Replaces this item collection's list with the supplied one.
   * @param {Array<Struct.DialogItem>} _items The new item list.
   * @param {Function} [_item_map_fn] The function to map the new items with.
   * @param {Real} [_item_count] The number of items of the new list.
   * @returns {Strict.DialogItemCollection}
   */

  static replace = function(_items, _item_map_fn = undefined, _item_count = undefined)
  {
    return self.empty().add(_items, undefined, _item_map_fn, _item_count);
  }



  /**
   * @desc Empties this dialog item collection.
   * @returns {Struct.DialogItemCollection}
   */

  static empty = function()
  {
    self.item_count = 0;
    self.items = [];

    return self;
  }



  /**
   * @desc Maps the supplied item with the supplied function.
   * @param {Struct.DialogItem} _item The item to map.
   * @param {Real} _item_idx The item index.
   * @param {Function} [_item_map_fn] The item mapping function.
   * @returns {Struct.DialogItem}
   */

  static mapitem = function(_item, _item_idx, _item_map_fn = undefined)
  {
    if (is_callable(_item_map_fn)) {
      _item = _item_map_fn(_item);
    }

    return _item.setidx(_item_idx).setparent(self.parent);
  }



  /**
   * @desc Normalizes the supplied item list for consistent dialog-manager use.
   * @param {Any} _items The item list.
   * @returns {Array<Any>}
   */

  static normalize = function(_items)
  {
    return is_array(_items)
      ? _items
      : (is_undefined(_items) ? [] : [_items])
    ;
  }
}












/**
 * @desc Provides shared settings, identifiers, and hierarchy behavior for dialog items.
 * @param {Any} _settings_mask The settings mask value.
 * @param {Any} _id The identifier for the item.
 * @returns {Struct.DialogItem}
 */

function DialogItem(_settings_mask, _id) : DialogItemInterface(undefined) constructor
{
  static LEVEL = -infinity;

  static __bitmaskregions = [];
  static __bitmaskregions_count = 0;



  self.id = (DialogManager.getidassignmentmode() == DIALOG_MANAGER.ID_ASSIGNMENT_MODE_ON_INSTANTIATION ? int64(_id) : DIALOG_MANAGER.ID_UNASSIGNED) ?? DIALOG_MANAGER.ID_UNASSIGNED;
  self.settings_mask = _settings_mask ?? 0;
  self.comment = undefined;
  self.item_idx = 0;



  /**
   * @desc Initializes this dialog item id and settings mask.
   * @returns {Struct.DialogLinkInterface}
   */

  static initialize = function()
  {
    return self.initializesettingsmask();
  }



  /**
   * @desc Initializes the settings mask for this dialog item.
   * @returns {Struct.DialogItem}
   */

  static initializesettingsmask = function()
  {
    for (var _i = 0; _i < self.__bitmaskregions_count; ++_i) {
      if (!self.decodesettingsmaskregion(self.__bitmaskregions[_i])) {
        self.replacesettingsmaskregion(self.__bitmaskregions[_i]);
      }
    }

    return self;
  }



  /**
   * @desc Returns the id for this dialog item.
   * @returns {Real}
   */

  static getid = function()
  {
    return int64(self.id ?? DIALOG_MANAGER.ID_UNASSIGNED);
  }



  /**
   * @desc
   * @returns {Struct.DialogItem}
   */

  static obtainid = function()
  {
    if (!self.getid()) {
      self.setid(self.getstructure().generateid(self));
    }

    return self;
  }



  /**
   * @desc Returns the level for this dialog item.
   * @returns {Constant.DIALOG_MANAGER}
   */

  static getlevel = function()
  {
    return self.LEVEL;
  }



  /**
   * @desc Returns the structure of this dialog link interface.
   * @returns {Struct.DialogStructure}
   */

  static getstructure = function()
  {
    var _item = self;

    while (_item && !is_instanceof(_item, DialogStructure)) {
      _item = _item.getparent();
    }

    return _item;
  }



  /**
   * @desc Returns the relative parent collection index for this dialog item.
   * @returns {Real}
   */

  static getindex = function()
  {
    return self.item_idx;
  }



  /**
   * @desc Returns the comment for this dialog item.
   * @param {Bool} [_add_prefix] Whether the comment should be prefixed (`true`) or not (`false).
   * @returns {String}
   */

  static getcomment = function(_add_prefix = true)
  {
    var _prefix = self.getstructure().getcommentprefix();

    return (
      _add_prefix && string_length(self.comment ?? "") && !string_starts_with(self.comment, _prefix)
      ? (_prefix ?? "")
      : ""
    ) + self.comment;
  }



  /**
   * @desc Returns the settings mask for this dialog item.
   * @returns {Real}
   */

  static getsettingsmask = function()
  {
    return int64(self.settings_mask);
  }



  /**
   * @desc Decodes the specified settings mask region value.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} [_mask] The mask value.
   * @returns {Real}
   */

  static decodesettingsmaskregion = function(_region, _mask = self.getsettingsmask())
  {
    return self.decodemaskregion(_region, _mask);
  }



  /**
   * @desc Encodes the specified settings mask region value.
   * @param {Struct.DialogBitMaskRegion} _region The region object.
   * @param {Real} [_value] The value to encode.
   * @returns {Real}
   */

  static encodesettingsmaskregion = function(_region, _value = undefined)
  {
    return self.encodemaskregion(_region, _value ?? _region.getdefault());
  }



  /**
   * @desc Checks wheter the item has a valid assigned ID (`true`) or not (`false`).
   * @returns {Bool}
   */

  static hasid = function()
  {
    return self.getid() != DIALOG_MANAGER.ID_UNASSIGNED;
  }



  /**
   * @desc Checks whether this dialog item satisfies the condition for being a linkable level.
   * @param {Real} [_level] The level value.
   * @returns {Bool}
   */

  static islinkablelevel = function(_level = self.getlevel())
  {
    return _level >= DIALOG_MANAGER.__LEVELS_LINKABLE_START && _level < DIALOG_MANAGER.__LEVELS_LINKABLE_END;
  }



  /**
   * @desc Retrieves the collection in which this item is in.
   * @returns {Struct.DialogItemCollection}
   */

  static getpool = function()
  {
    return self.getparent().getcollection();
  }



  /**
   * @desc Returns the number of items in the item's pool collection.
   * @returns {Real}
   */

  static getpoolcount = function()
  {
    if (!is_instanceof(self.parent, DialogLinkInterface)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_CONTAINERIZATION, [
        self
      ]);
    }

    return self.getparent().getitemcount();
  }



  /**
   * @desc Returns an item in this dialog item's pool collection.
   * @param {Any} _idx The index value.
   * @returns {Struct.DialogItem}
   */

  static getinpool = function(_idx)
  {
    return self.getparent().getitem(_idx);
  }



  /**
   * @desc Returns an item relatively in this dialog item's pool collection.
   * @param {Real} _shift The shift value.
   * @returns {Struct.DialogItem}
   */

  static getinpoolrelative = function(_shift)
  {
    return self.getparent().getitem(self.getindex() + _shift);
  }



  /**
   * @desc Returns an item at one of the extremasin this dialog item's pool collection.
   * @param {Real} _dir The direction value.
   * @returns {Struct.DialogItem}
   */

  static getpoolextrema = function(_dir)
  {
    if (_dir == 0)
      return self;

    return _dir > 0
      ? self.getinpool(-1)
      : self.getinpool(0)
    ;
  }


  /**
   * @desc Returns the number of items remaining in this dialog item's pool collection towards a specified direction.
   * @param {Real} [_dir] The direction value.
   * @returns {Real}
   */

  static getpoolremainingcount = function(_dir = 1)
  {
    return self.getparent().getcollection().getremainingitemcount(self.getindex(), _dir);
  }



  /**
   * @desc Checks whether this dialog item is the first of its pool collection.
   * @returns {Bool}
   */

  static isfirst = function()
  {
    return self.item_idx == 0;
  }



  /**
   * @desc Checks whether this dialog item is the last of its pool collection.
   * @returns {Bool}
   */

  static islast = function()
  {
    return self.item_idx == self.getpoolcount() - 1;
  }



  /**
   * @desc Checks whether this dialog item is an extrema of its pool collection.
   * @param {Real} [_dir] The direction value.
   * @returns {Bool}
   */

  static isextrema = function(_dir = 1)
  {
    return _dir < 0
      ? self.isfirst()
      : self.islast()
    ;
  }



  /**
   * @desc Checks whether this dialog item is complete for insertion inside a collection.
   * @returns {Bool}
   */

  static iscomplete = function()
  {
    var _level = self.getlevel();

    if (_level <= DIALOG_MANAGER.__LEVELS_LINKABLE_START || self.getitemcount()) {
      return true;
    }

    throw DialogManager.ERROR(DIALOG_MANAGER.ERR_EMPTY_CONTAINER_OBJECT, [
      DialogManager.DATA.LEVELS.CONSTRUCTOR_NAMES[_level]
    ]);
  }



  /**
   * @desc Sets the identifier for this dialog item.
   * @param {Real} _id The item identifier.
   * @returns {Struct.DialogItem}
   */

  static setid = function(_id)
  {
    self.id = int64(_id ?? DIALOG_MANAGER.ID_UNASSIGNED);

    return self;
  }



  /**
   * @desc Sets the index for this dialog item.
   * @param {Real} _item_idx The item index value.
   * @returns {Struct.DialogItem}
   */

  static setidx = function(_item_idx)
  {
    self.item_idx = max(_item_idx, 0);

    return self;
  }



  /**
   * @desc Sets the comment for this dialog item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogItem}
   */

  static setcomment = function(_comment = undefined)
  {
    self.comment = _comment;

    return self;
  }



  /**
   * @desc Sets the settings mask for this dialog item.
   * @param {Real} [_settings_mask] The settings mask value.
   * @returns {Struct.DialogItem}
   */

  static setsettingsmask = function(_settings_mask = 0)
  {
    self.settings_mask = _settings_mask;

    return self;
  }



  /**
   * @desc Changes this dialog item's index by a specified shift amount.
   * @param {Real} _idx_shift The index shift value.
   * @returns {Struct.DialogItem}
   */

  static shiftidx = function(_idx_shift)
  {
    return self.setidx(self.item_idx + _idx_shift);
  }



  /**
   * @desc Adds the supplied comment to this dialog item.
   * @param {String} [_comment] The comment for the structure.
   * @returns {Struct.DialogItem}
   */

  static addcomment = function(_comment = "")
  {
    return self.setcomment(
      (is_undefined(self.comment) ? "" : self.comment + "\n") + _comment
    );
  }



  /**
   * @desc Filters the settings mask region using the supplied predicate.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} [_filter_mask] The filter mask value.
   * @returns {Real}
   */

  static filtersettingsmaskregion = function(_region, _filter_mask = -1)
  {
    return self.filtermaskregion(_region, self.getsettingsmask(), _filter_mask);
  }



  /**
   * @desc Replaces the settings mask region with a provided value on this dialog item.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} [_value] The new value of the replacement.
   * @returns {Struct.DialogItem}
   */

  static replacesettingsmaskregion = function(_region, _value = undefined)
  {
    return self.setsettingsmask(
      self.replacemaskregion(_region, self.getsettingsmask() ?? 0, _value ?? _region.getdefault())
    );
  }



  /**
   * @desc Checks whether this dialog item contains a settings mask region value.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real|undefined} [_value] The region value.
   * @returns {Bool}
   */

  static hassettingsmaskregionvalue = function(_region, _value = undefined)
  {
    return self.hasmaskregionvalue(_region, self.getsettingsmask(), _value ?? -1);
  }



  /**
   * @desc Checks whether this dialog item contains a settings mask region flag.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real|undefined} [_flag] The region flag.
   * @returns {Bool}
   */

  static hassettingsmaskregionflag = function(_region, _flag = undefined)
  {
    return self.hasmaskregionflag(_region, self.getsettingsmask(), _flag ?? -1);
  }
}












/**
 * @desc Provides ordered child links and navigation for linkable dialog items.
 * @param {Array} _items The item list.
 * @param {Any} _settings_mask The settings mask value.
 * @param {Any} _id The identifier for the item.
 * @param {Real} _item_count The number of items of the collection.
 * @returns {Struct.DialogLinkInterface}
 */

function DialogLinkInterface(_items, _settings_mask, _id, _item_count) : DialogItem(_settings_mask, _id) constructor
{
  self.collection = DialogItemCollection.from(_items, self, _item_count);



  /**
   * @desc Returns the collection for this dialog link interface.
   * @returns {Struct.DialogItemCollection}
   */

  static getcollection = function()
  {
    return self.collection;
  }



  /**
   * @desc Returns all child items linked from this item.
   * @returns {Array<Struct.DialogItem>}
   */

  static getitems = function()
  {
    return self.getcollection().getitems();
  }



  /**
   * @desc Returns the number of items item for this dialog link interface.
   * @returns {Real}
   */

  static getitemcount = function()
  {
    return self.getcollection().getitemcount();
  }



  /**
   * @desc Returns the child item at the requested index, optionally filtered.
   * @param {Real} [_n] The index/occurrence value.
   * @param {Function} [_filter_fn] The filtering function.
   * @param {Any} [_argv] The arguments for the filtering function.
   * @returns {Struct.DialogItem}
   */

  static getitem = function(_n = undefined, _filter_fn = undefined, _argv = undefined)
  {
    return _filter_fn
      ? self.getcollection().getitemnthof(_n, _filter_fn, _argv)
      : self.getcollection().getitem(_n)
    ;
  }



  /**
   * @desc Returns the item bounded for this dialog link interface.
   * @param {Real} _idx The index value.
   * @param {Real} [_range] The range value.
   * @returns {Struct.DialogItem}
   */

  static getitembounded = function(_idx, _range = 0)
  {
    return self.getcollection().getitembounded(_idx, _range);
  }



  /**
   * @desc Returns the first child of this dialog link interface.
   * @returns {Struct.DialogItem}
   */

  static getitemfirst = function()
  {
    return self.getitem(0);
  }



  /**
   * @desc Returns the middle child of this dialog link interface.
   * @returns {Struct.DialogItem}
   */

  static getitemmiddle = function()
  {
    return self.getitem(self.getitemcount() >> 1);
  }



  /**
   * @desc Returns the last child of this dialog link interface.
   * @returns {Struct.DialogItem}
   */

  static getitemlast = function()
  {
    return self.getitem(-1);
  }



  /**
   * @desc Returns the item extrema at the specified direction for this dialog link interface.
   * @param {Real} _dir The direction value.
   * @returns {Struct.DialogItem}
   */

  static getitemextrema = function(_dir)
  {
    if (_dir == 0)
      return self.getitemmiddle();

    return _dir > 0
      ? self.getitemlast()
      : self.getitemfirst()
    ;
  }



  /**
   * @desc Returns the sibling link extrema for this dialog link interface.
   * @param {Real} _dir The direction value.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkextrema = function(_dir)
  {
    return self.getlevel() <= DIALOG_MANAGER.__LEVELS_LINKABLE_START
      ? self.getparent().getitemextrema(_dir)
      : self.getitemextrema(_dir)
    ;
  }



  /**
   * @desc Returns the encoded position of this dialog link interface.
   * @returns {Real}
   */

  static getposition = function()
  {
    var _structure = self.getstructure();

    if (is_undefined(_structure)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_CONTAINER_ACCESS, [self]);
    }

    return _structure.getpositionfromlink(self);
  }



  /**
   * @desc Compares two objects and returns `true` if their position code matches.
   * @param {Any} _link The link object for the comparison.
   * @returns {Bool}
   */

  static equals = function(_link)
  {
    var _level_self = self.getlevel()
      , _level_link = _link.getlevel()
    ;

    if (_level_self == _level_link)
      return self == _link;

    var _largest_link = _level_link > _level_self ? _link : self
      , _smallest_link = _largest_link == self ? _link : self
    ;

    return _largest_link.getlinkoflevel(min(_level_link, _level_self)) == _smallest_link;
  }



  /**
   * @desc Returns the link of the selected level for this dialog link interface.
   * @param {Real} [_level] The level value.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkoflevel = function(_level = self.getlevel())
  {
    if (!self.islinkablelevel(_level)) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_level), _level
      ]);
    }

    var _item = self
      , _item_level = _item.getlevel()
      , _level_diff = abs(_level - _item_level)
      , _cycle_func = _level > _item_level ? nameof(getparent) : nameof(getitemfirst)
    ;

    while (_level_diff--) {
      _item = method_call(method(_item, _item[$ _cycle_func]));
    }

    return _item;
  }



  /**
   * @desc Returns the level shared by this dialog link interface and the provided one.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @returns {Contant.DIALOG_MANAGER}
   */

  static getlinksharedlevel = function(_link)
  {
    var _lv_self = self.getlevel()
      , _lv_link = _link.getlevel()
      , _lv_max = max(_lv_self, _lv_link)
    ;

    if (self == _link)
      return _lv_self;

    var _iter_link = _link.getlinkoflevel(_lv_max)
      , _iter_self = self.getlinkoflevel(_lv_max)
      , _lv = _lv_max
    ;

    while (_iter_self != _iter_link && ++_lv < DIALOG_MANAGER.LEVEL_STRUCTURE) {
      _iter_link = _iter_link.getparent();
      _iter_self = _iter_self.getparent();
    }

    return _lv;
  }



  /**
   * @desc Links this dialog link interface inserting it as a flow resolver argument option.
   * @param {Struct.DialogFX} _fx The fx object.
   * @param {String} [_prompt] The prompt value.
   * @param {Real} [_index] The index value.
   * @param {Any} [_jump_metadata] The jump metadata value.
   * @returns {Struct.DialogLinkInterface}
   */

  static linkfrom = function(_fx, _prompt = undefined, _index = undefined, _jump_metadata = undefined)
  {
    _fx.insertflowoption(DialogFlowOptionDTO.createoption(self, 0, _prompt, _jump_metadata), _index);

    return self;
  }



  /**
   * @desc Converts this dialog link interface to its DialogScene equivalent. Conversion is "lossy" if the level decreases.
   * @returns {Struct.DialogScene}
   */

  static toscene = function()
  {
    return self.getlinkoflevel(DIALOG_MANAGER.LEVEL_SCENE);
  }



  /**
   * @desc Converts this dialog link interface to its DialogSequence equivalent. Conversion is "lossy" if the level decreases.
   * @returns {Struct.DialogSequence}
   */

  static tosequence = function()
  {
    return self.getlinkoflevel(DIALOG_MANAGER.LEVEL_SEQUENCE);
  }



  /**
   * @desc Converts this dialog link interface to its Dialog equivalent. Conversion is "lossy" if the level decreases.
   * @returns {Struct.Dialog}
   */

  static todialog = function()
  {
    return self.getlinkoflevel(DIALOG_MANAGER.LEVEL_DIALOG);
  }



  /**
   * @desc Adds the supplied child items to this dialog link interface.
   * @param {Array<Struct.DialogItem>} _items The item list to add.
   * @param {Real} [_idx] The index where to insert the items.
   * @param {Function} [_item_map_fn] The item mappping function.
   * @param {Real} [_item_count] The number of items of the collection.
   * @returns {Struct.DialogLinkInterface}
   */

  static add = function(_items, _idx = undefined, _item_map_fn = undefined, _item_count = undefined)
  {
    return self.getcollection().add(_items, _idx, _item_map_fn, _item_count).getparent();
  }



  /**
   * @desc Removes the selected items from this dialog link interface.
   * @param {Real} [_item_count] The item count value.
   * @param {Real} [_idx] The index value.
   * @returns {Struct.DialogLinkInterface}
   */

  static remove = function(_item_count = undefined, _idx = undefined)
  {
    return self.getcollection().remove(_item_count, _idx).getparent();
  }
}












/**
 * @desc Provides the common interface for raw dialog data conversion.
 * @returns {Struct.DialogRawInterface}
 */

function DialogRawInterface() constructor
{

}












/**
 * @desc Provides a base representation for dialog-manager data transfer objects.
 * @returns {Struct.DialogDTO}
 */

function DialogDTO() constructor
{

}












/**
 * @desc Represents a serialized link to a dialog item.
 * @param {Struct.DialogLinkInterface} _link The link object.
 * @returns {Struct.DialogLinkDTO}
 */

function DialogLinkDTO(_link) : DialogDTO() constructor
{
  self.link = _link;



  /**
   * @desc Returns the link for this dialog link data.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlink = function()
  {
    return self.link;
  }



  /**
   * @desc Sets the link for this dialog link data.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @returns {Struct.DialogLinkDTO}
   */

  static setlink = function(_link)
  {
    self.link = _link;

    return self;
  }
}












/**
 * @desc Provides a base representation for dialog comparison results.
 * @returns {Struct.DialogDiffDTO}
 */

function DialogDiffDTO() : DialogDTO() constructor
{
  /**
   * @desc Returns the name for a specified type.
   * @param {Real} _type The type value.
   * @returns {String}
   */

  static getoperationname = function(_type)
  {
    return DialogManager.DATA.DIFF.OPERATIONS[_type]
  }



  /**
   * @desc Returns the name for a specified level.
   * @param {Real} _level The level value.
   * @returns {String}
   */

  static getlevelname = function(_level)
  {
    return DialogManager.DATA.DIFF.NAMES[_level];
  }
}












#endregion

// ----------------------------------------------------------------------------

#region DTOs












#region Jump DTOs

/**
 * @desc Represents a flow option and its resolution metadata.
 * @returns {Struct.DialogFlowOptionDTO}
 */

function DialogFlowOptionDTO() constructor
{
  /**
   * @desc Creates the flow option data from the supplied values.
   * @param {Array} [_flow_option_list] The available flow options.
   * @param {Constant.DIALOG_FX} [_fx_condition_map_idx] The condition-function map index.
   * @param {Constant.DIALOG_FX} [_fx_indexer_map_idx] The indexer-function map index.
   * @param {Any} [_fx_condition_map_argv] Arguments passed to the condition function.
   * @param {Any} [_fx_indexer_map_argv] Arguments passed to the indexer function.
   * @param {Any} [_flow_settings] Additional flow-resolution settings.
   * @returns {Array}
   */

  static create = function(_flow_option_list = [], _fx_condition_map_idx = undefined, _fx_indexer_map_idx = undefined, _fx_condition_map_argv = undefined, _fx_indexer_map_argv = undefined, _flow_settings = undefined)
  {
    var _ret = array_create(DIALOG_FX.FX_ARG_FLOWRES_COUNT);

    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA] = _flow_option_list;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_CONDITION_INDEX] = _fx_condition_map_idx;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_INDEXER_INDEX] = _fx_indexer_map_idx;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_CONDITION_ARGV] = _fx_condition_map_argv;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_INDEXER_ARGV] = _fx_indexer_map_argv;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_SETTINGS] = _flow_settings;

    return _ret;
  }



  /**
   * @desc Creates the flow option from the supplied values.
   * @param {Struct.DialogLinkInterface|Constant.DIALOG_MANAGER|Real} _position The position data.
   * @param {Constant.DIALOG_RUNNER|Real} [_jump_settings] The jump settings value.
   * @param {String} [_prompt] The prompt value.
   * @param {Any} [_metadata] The metadata value.
   * @returns {Array}
   */

  static createoption = function(_position, _jump_settings = 0, _prompt = "", _metadata = undefined)
  {
    var _ret = array_create(DIALOG_FX.FX_ARG_FLOWRES_DATA_COUNT);

    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION] = self.createoptiontarget(_position, _jump_settings);
    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA_PROMPT] = _prompt;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA_METADATA] = _metadata;

    return _ret;
  }



  /**
   * @desc Creates the flow option target from the supplied values.
   * @param {Struct.DialogLinkInterface|Constant.DIALOG_MANAGER|Real} _position The position destination data.
   * @param {Constant.DIALOG_RUNNER|Real} [_jump_settings] The jump settings value.
   * @returns {Array}
   */

  static createoptiontarget = function(_position, _jump_settings = 0)
  {
    var _ret = array_create(DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITIONS_COUNT);

    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION_SETTINGS] = _jump_settings;
    _ret[DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION_DESTINATION] = _position;

    return _ret;
  }



  /**
   * @desc Returns an argument placed in an array for a specified dialog flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @param {Real} _idx The index value.
   * @returns {Any}
   */

  static getarg = function(_argv, _idx)
  {
    return _idx >= 0
      ? _argv[_idx]
      : undefined
    ;
  }



  /**
   * @desc Returns the flow options for a specified flow option data.
   * @param {Array} _flow_dto The flow DTO.
   * @returns {Array}
   */

  static getflowoptions = function(_flow_dto)
  {
    return self.getarg(_flow_dto, DIALOG_FX.FX_ARG_FLOWRES_DATA);
  }



  /**
   * @desc Returns the flow option for a specified flow option data.
   * @param {Array} _flow_dto The flow DTO.
   * @param {Real} _idx The index value.
   * @returns {Array}
   */

  static getflowoption = function(_flow_dto, _idx)
  {
    return self.getarg(self.getarg(_flow_dto, DIALOG_FX.FX_ARG_FLOWRES_DATA), _idx);
  }



  /**
   * @desc Returns the condition index for a specified flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @returns {Real}
   */

  static getconditionindex = function(_argv)
  {
    return self.getarg(_argv, DIALOG_FX.FX_ARG_FLOWRES_CONDITION_INDEX);
  }



  /**
   * @desc Returns the indexer map index for a specified dialog flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @returns {Real}
   */

  static getindexerindex = function(_argv)
  {
    return self.getarg(_argv, DIALOG_FX.FX_ARG_FLOWRES_INDEXER_INDEX);
  }



  /**
   * @desc Returns the condition map argv for a specified dialog flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @returns {Any}
   */

  static getconditionargv = function(_argv)
  {
    return self.getarg(_argv, DIALOG_FX.FX_ARG_FLOWRES_CONDITION_ARGV);
  }



  /**
   * @desc Returns the indexer map argv for a specified dialog flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @returns {Any}
   */

  static getindexerargv = function(_argv)
  {
    return self.getarg(_argv, DIALOG_FX.FX_ARG_FLOWRES_INDEXER_ARGV);
  }



  /**
   * @desc Returns the settings for a specified dialog flow option data.
   * @param {Array} _argv The arguments of the flow option data.
   * @returns {Any}
   */

  static getsettings = function(_argv)
  {
    return self.getarg(_argv, DIALOG_FX.FX_ARG_FLOWRES_SETTINGS);
  }



  /**
   * @desc Returns the flow position for a specified dialog flow option data.
   * @param {Array} _flow_option The flow option.
   * @returns {Array}
   */

  static getflowposition = function(_flow_option)
  {
    return self.getarg(_flow_option, DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION);
  }



  /**
   * @desc Returns the flow prompt for a specified dialog flow option data.
   * @param {Array} _flow_option The flow option.
   * @returns {String}
   */

  static getflowprompt = function(_flow_option)
  {
    return self.getarg(_flow_option, DIALOG_FX.FX_ARG_FLOWRES_DATA_PROMPT);
  }



  /**
   * @desc Returns the flow metadata for a specified dialog flow option data.
   * @param {Array} _flow_option The flow option.
   * @returns {Any}
   */

  static getflowmetadata = function(_flow_option)
  {
    return self.getarg(_flow_option, DIALOG_FX.FX_ARG_FLOWRES_DATA_METADATA);
  }



  /**
   * @desc Returns the flow positiondestination for a specified dialog flow option data.
   * @param {Array} _flow_option The flow option.
   * @returns {Struct.DialogLinkInterface|Constant.DIALOG_MANAGER|Real}
   */

  static getflowpositiondestination = function(_flow_option)
  {
    return self.getarg(self.getflowposition(_flow_option), DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION_DESTINATION);
  }



  /**
   * @desc Returns the flow position settings for a specified dialog flow option data.
   * @param {Array} _flow_option The flow option.
   * @returns {Constant.DIALOG_RUNNER|Real}
   */

  static getflowpositionsettings = function(_flow_option)
  {
    return self.getarg(self.getflowposition(_flow_option), DIALOG_FX.FX_ARG_FLOWRES_DATA_POSITION_SETTINGS);
  }
}












/**
 * @desc Stores the context and evaluation state used to resolve a dialog jump.
 * @param {Struct.DialogResolver} _resolver The resolver object.
 * @param {Struct.DialogLinkInterface} _link_target The link target object.
 * @param {Struct.DialogLinkInterface} _link_start The link start object.
 * @returns {Struct.DialogJumpContextDTO}
 */

function DialogJumpContextDTO(_resolver, _link_target, _link_start) : DialogLinkDTO(_link_start) constructor
{
  self.resolver = _resolver;
  self.fx_executed_count = 0;
  self.fx_current = undefined;
  self.fx_current_index = undefined;
  self.link_start = _link_start;
  self.signal = DIALOG_FX.SIGNAL_NONE;
  self.cache = array_map(array_create(DIALOG_FX.MAPS_COUNT), function() { return {}; });
  self.result = DialogJumpResultDTO.from(_link_target);



  /**
   * @desc Creates a dialog jump context from the supplied data.
   * @param {Struct.DialogResolver} _resolver The resolver object.
   * @param {Struct.DialogLinkInterface} _link_target The link target object.
   * @param {Struct.DialogLinkInterface} _link_start The link start object.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static from = function(_resolver, _link_target, _link_start)
  {
    return new DialogJumpContextDTO(_resolver, _link_target, _link_start);
  }



  /**
   * @desc Returns the resolver for this dialog jump context data.
   * @returns {Struct.DialogResolver}
   */

  static getresolver = function()
  {
    return self.resolver;
  }



  /**
   * @desc Returns the jump result for this dialog jump context data.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static getresult = function()
  {
    return self.result;
  }



  /**
   * @desc Returns the emitted signal for this dialog jump context data.
   * @returns {Constant.DIALOG_FX}
   */

  static getsignal = function()
  {
    return self.signal;
  }



  /**
   * @desc Returns the number of dialog effects executed for this dialog jump context data.
   * @returns {Real}
   */

  static getfxexecutedcount = function()
  {
    return self.fx_executed_count;
  }



  /**
   * @desc Returns the current fx for this dialog jump context data.
   * @returns {Struct.DialogFX}
   */

  static getfxcurrent = function()
  {
    return self.fx_current;
  }



  /**
   * @desc Returns the current fx index for this dialog jump context data.
   * @returns {Real}
   */

  static getfxcurrentindex = function()
  {
    return self.fx_current_index;
  }



  /**
   * @desc Returns the starting link for this dialog jump context data.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinkstart = function()
  {
    return self.link_start;
  }



  /**
   * @desc Returns the target link for this dialog jump context data.
   * @returns {Struct.DialogLinkInterface}
   */

  static getlinktarget = function()
  {
    return self.getresult().getlink();
  }



  /**
   * @desc Sets the number of executed dialog effects for this dialog jump context data.
   * @param {Real} _fx_executed_count The number of executed effects.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setfxexecutedcount = function(_fx_executed_count)
  {
    self.fx_executed_count = _fx_executed_count;

    return self;
  }



  /**
   * @desc Sets the current dialog effect for this dialog jump context data.
   * @param {Struct.DialogFX} _fx_current The current dialog effect object.
   * @param {Real} [_fx_current_index] The current dialog effect index.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setfxcurrent = function(_fx_current, _fx_current_index = 0)
  {
    self.fx_current = _fx_current;
    self.fx_current_index = _fx_current_index;

    return self;
  }



  /**
   * @desc Sets the starting link for this dialog jump context data.
   * @param {Struct.DialogLinkInterface} _link_start The link start object.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setlinkstart = function(_link_start)
  {
    self.link_start = _link_start;

    return self;
  }



  /**
   * @desc Sets the target link for this dialog jump context data.
   * @param {Struct.DialogLinkInterface} _link_target The link target object.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setlinktarget = function(_link_target)
  {
    self.getresult().setlink(_link_target);

    return self;
  }



  /**
   * @desc Sets the starting link and target link for this jump context.
   * @param {Struct.DialogLinkInterface} _link_start The link start object.
   * @param {Struct.DialogLinkInterface} _link_target The link target object.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setlinks = function(_link_start, _link_target)
  {
    return self.setlinkstart(_link_start).setlinktarget(_link_target);
  }



  /**
   * @desc Sets the signal for this dialog jump context.
   * @param {Constant.DIALOG_FX|Real} [_signal] The fx object.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static setsignal = function(_signal = DIALOG_FX.SIGNAL_NONE)
  {
    self.signal = _signal;

    return self;
  }



  /**
   * @desc Modifies the number of execution entries using the specified entry.
   * @param {Struct.DialogFX} _fx The fx object to execute.
   * @param {Real} [_weight] The weight value of the execution.
   * @param {Real} [_fx_index] The dialog effect index value.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static countexecution = function(_fx, _weight = 1, _fx_index = 0)
  {
    return self.setfxexecutedcount(self.getfxexecutedcount() + _weight)
      .setfxcurrent(_fx, _fx_index)
    ;
  }



  /**
   * @desc Reset state of this dialog jump context data.
   * @returns {Struct.DialogJumpContextDTO}
   */

  static reset = function()
  {
    return self.setfxcurrent(undefined).setfxexecutedcount(0);
  }



  /**
   * @desc Evaluates the supplied cache in the current dialog context.
   * @param {Constant.DIALOG_FX|Real} _cache_idx The fx map index.
   * @param {Constant.DIALOG_FX|Real} _key The fx map function index.
   * @param {Any} _argv The arguments of the effect map function.
   * @param {Any} [_default_ret] The default return value.
   * @returns {Any} The calculated function return value or the specified default.
   */

  static evaluatecache = function(_cache_idx, _key, _argv, _default_ret = undefined)
  {
    if ((_key ?? DIALOG_FX.FX_ARG_FLOWRES_INDEX_UNSELECTED) < 0)
      return _default_ret;

    var _storage = self.cache[_cache_idx]
      , _map = DialogManager.FX_MAPS[_cache_idx]
    ;

    if (variable_struct_exists(_storage, _key))
      return _storage[$ _key];

    var _result = (_map.getfunc(_key))(_argv, self);
    _storage[$ _key] = _result;

    return _result;
  }



  /**
   * @desc Evaluates the supplied condition in the current dialog context.
   * @param {Constant.DIALOG_FX|Real} _condition_idx The fx condition function index.
   * @param {Any} _condition_argv The condition function arguments.
   * @returns {Any}
   */

  static evaluatecondition = function(_condition_idx, _condition_argv)
  {
    return self.evaluatecache(
      DIALOG_FX.MAP_INDEX_CONDITION,
      _condition_idx,
      _condition_argv,
      DIALOG_FX.FUNC_CONDITION_TRUE
    );
  }



  /**
   * @desc Evaluates the supplied indexer in the current dialog context.
   * @param {Constant.DIALOG_FX|Real} _indexer_idx The fx indexer function index.
   * @param {Any} _indexer_argv The indexer function arguments.
   * @returns {Any}
   */

  static evaluateindexer = function(_indexer_idx, _indexer_argv)
  {
    return self.evaluatecache(
      DIALOG_FX.MAP_INDEX_INDEXER,
      _indexer_idx,
      _indexer_argv,
      DIALOG_FX.FX_ARG_FLOWRES_INDEX_UNSELECTED
    );
  }



  /**
   * @desc Calculates the outcome result for the current dialog context.
   * @param {Struct.DialogJumpResultDTO} [_jump_result] The jump result object.
   * @param {Constant.DIALOG_FX} [_signal] The fx signal value.
   * @returns {Struct.DialogLinkInterface}
   */

  static outcome = function(_jump_result = self.getresult(), _signal = DIALOG_FX.SIGNAL_NONE)
  {
    var _link_target = _jump_result.getlink() ?? self.getresult().getlink()
      , _status_target = _jump_result.getstatus()
    ;

    self.setsignal(_signal).getresult()
      .setlink(_link_target).composestatus(_status_target)
    ;

    return _link_target;
  }



  /**
   * @desc Performs the fail operation for this dialog jump context data.
   * @param {Struct.DialogJumpResultDTO} [_jump_result] The jump result object.
   * @returns {Struct.DialogLinkInterface}
   */

  static fail = function(_jump_result = undefined)
  {
    return self.outcome(_jump_result);
  }



  /**
   * @desc Performs the success operation for this dialog jump context data.
   * @param {Struct.DialogJumpResultDTO} [_jump_result] The jump result object.
   * @returns {Struct.DialogLinkInterface}
   */

  static success = function(_jump_result = undefined)
  {
    var _fx = self.getfxcurrent();

    return self.outcome(_jump_result, _fx ? _fx.decodesignal() : DIALOG_FX.SIGNAL_NONE);
  }
}












/**
 * @desc Represents the outcome and status of a dialog jump.
 * @param {Struct.DialogLinkInterface} _link The link object.
 * @param {Real} _status The status value.
 * @returns {Struct.DialogJumpResultDTO}
 */

function DialogJumpResultDTO(_link, _status) : DialogLinkDTO(_link) constructor
{
  self.status = _status;



  /**
   * @desc Creates a dialog jump result data from the supplied data.
   * @param {Struct.DialogLinkInterface} _link The link object.
   * @param {Real} [_status] The status value.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static from = function(_link, _status = 0)
  {
    return new DialogJumpResultDTO(_link, _status);
  }



  /**
   * @desc Returns the status for this dialog jump result data.
   * @returns {Real}
   */

  static getstatus = function()
  {
    return self.status;
  }



  /**
   * @desc Composes the status from the supplied values.
   * @param {Constant.DIALOG_RUNNER|Real} _status The status value to compose to this jump result's.
   * @returns {Struct.DialogJumpResultDTO}
   */

  static composestatus = function(_status)
  {
    self.status = DialogBitmaskResolver.compose(self.getstatus(), _status);

    return self;
  }
}

#endregion












#region Diff DTOs

/**
 * @desc Represents the top-level result of comparing two dialog structures.
 * @param {Any} _diff_result_level The diff result level object.
 * @param {Any} _diff_param_group The diff param group object.
 * @returns {Struct.DialogDiffResultDTO}
 */

function DialogDiffResultDTO(_diff_result_level, _diff_param_group) : DialogDiffDTO() constructor
{
  self.tree = _diff_result_level;
  self.params = _diff_param_group;
  self.summary = DialogDiffSummaryDTO.from(self);



  /**
   * @desc Creates a dialog diff result data from the supplied data.
   * @param {Struct.DialogDiffResultLevelDTO} _diff_result_level The diff result level object.
   * @param {Struct.DialogDiffParamGroupDTO} _diff_param_group The diff param group object.
   * @returns {Struct.DialogDiffResultDTO}
   */

  static from = function(_diff_result_level, _diff_param_group)
  {
    return new DialogDiffResultDTO(_diff_result_level, _diff_param_group);
  }



  /**
   * @desc Returns the tree for this dialog diff result data.
   * @returns {Struct.DialogDiffResultLevelDTO}
   */

  static gettree = function()
  {
    return self.tree;
  }



  /**
   * @desc Returns the summary for this dialog diff result data.
   * @returns {Struct.DialogDiffSummaryDTO}
   */

  static getsummary = function()
  {
    return self.summary;
  }



  /**
   * @desc Returns the comparison parameters stored in this diff result data.
   * @returns {Struct.DialogDiffParamGroupDTO}
   */

  static getparams = function()
  {
    return self.params;
  }
}












/**
 * @desc Stores comparison nodes and difference counts for one structure level.
 * @param {Any} _nodes_array The node list.
 * @param {Any} _node_count The number of nodes of the colection.
 * @param {Any} _diff_count The diff count value.
 * @param {Any} _diff_count_sub The diff count value for lower levels.
 * @param {Bool} _has_direct_structural_changes Whether this level contains insertions, deletions, or moves.
 * @returns {Struct.DialogDiffResultLevelDTO}
 */

function DialogDiffResultLevelDTO(_nodes_array, _node_count, _diff_count, _diff_count_sub, _has_direct_structural_changes = false) : DialogDiffDTO() constructor
{
  self.nodes = _nodes_array;
  self.nodecount = int64(_node_count);
  self.diffcount = int64(_diff_count);
  self.diffcountsub = int64(_diff_count_sub);
  self.directstructuralchanges = _has_direct_structural_changes;



  /**
   * @desc Creates this dialog diff result level data from the supplied data.
   * @param {Array<Struct.DialogDiffNodeDTO>} _nodes_array The node list.
   * @param {Real} _node_count The number of nodes of the collection.
   * @param {Real} _diff_count The diff count value.
   * @param {Real} _diff_count_sub The diff count value for lower levels.
   * @param {Bool} [_has_direct_structural_changes] Whether this level contains insertions, deletions, or moves.
   * @returns {Struct.DialogDiffResultLevelDTO}
   */

  static from = function(_nodes_array, _node_count, _diff_count, _diff_count_sub, _has_direct_structural_changes = false)
  {
    return new DialogDiffResultLevelDTO(_nodes_array, _node_count, _diff_count, _diff_count_sub, _has_direct_structural_changes);
  }



  /**
   * @desc Returns the comparison nodes for this structure level.
   * @returns {Array<Struct.DialogDiffNodeDTO>}
   */

  static getnodes = function()
  {
    return self.nodes;
  }



  /**
   * @desc Returns the selected node for this dialog diff result level data.
   * @param {Real} _idx The index value.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static getnode = function(_idx)
  {
    return self.nodes[_idx + self.nodecount * (_idx < 0)];
  }



  /**
   * @desc Returns the node count for this dialog diff result level data.
   * @returns {Real}
   */

  static getnodecount = function()
  {
    return int64(self.nodecount);
  }



  /**
   * @desc Returns the diff count for this dialog diff result level data.
   * @returns {Real}
   */

  static getdiffcount = function()
  {
    return int64(self.diffcount);
  }



  /**
   * @desc Returns the diff count of lower levels for this dialog diff result level data.
   * @returns {Real}
   */

  static getdiffcountsub = function()
  {
    return int64(self.diffcountsub);
  }



  /**
   * @desc Returns whether this level contains direct insertions, deletions, or moves.
   * @returns {Bool}
   */

  static hasdirectstructuralchanges = function()
  {
    return self.directstructuralchanges;
  }
}












/**
 * @desc Stores ordered comparison operations for a structure level.
 * @param {Any} _operations_array The operation list.
 * @param {Any} _operation_count The number of operations of the collection.
 * @returns {Struct.DialogDiffResultListDTO}
 */

function DialogDiffResultListDTO(_operations_array, _operation_count) : DialogDiffDTO() constructor
{
  self.operations = _operations_array;
  self.operation_count = int64(_operation_count ?? array_length(_operations_array));



  /**
   * @desc Creates this dialog diff result list data from the supplied from.
   * @param {Array<Struct.DialogDiffOperationDTO>} _operations_array The operation list.
   * @param {Real} [_operation_count] The number of operations of the collection.
   * @returns {Struct.DialogDiffResultListDTO}
   */

  static from = function(_operations_array, _operation_count = undefined)
  {
    return new DialogDiffResultListDTO(_operations_array, _operation_count);
  }



  /**
   * @desc Creates a dialog diff result list data from the supplied result.
   * @param {Struct.DialogDiffResultDTO} _result The diff result object.
   * @returns {Struct.DialogDiffResultListDTO}
   */

  static fromresult = function(_result)
  {
    return self.from(_result.getoperations(), _result.getoperationcount());
  }



  /**
   * @desc Returns the operation list for this dialog diff result list data.
   * @returns {Array<Struct.DialogDiffOperationDTO>}
   */

  static getoperations = function()
  {
    return self.operations;
  }



  /**
   * @desc Returns the selected operation for this dialog diff result list data.
   * @param {Real} _idx The index value.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static getoperation = function(_idx)
  {
    return self.operations[_idx + self.operation_count * (_idx < 0)];
  }



  /**
   * @desc Returns the operation count for this dialog diff result list data.
   * @returns {Real}
   */

  static getoperationcount = function()
  {
    return self.operation_count;
  }
}












/**
 * @desc Summarizes the severity and counts of structure differences.
 * @param {Any} _diff_result The diff result object.
 * @returns {Struct.DialogDiffSummaryDTO}
 */

function DialogDiffSummaryDTO(_diff_result) : DialogDiffDTO() constructor
{
  if (!(_diff_result && _diff_result.getparams()))
    return;

  var _diff_level_result = _diff_result.gettree()
    , _diff_param_group = _diff_result.getparams()
    , _node_array = _diff_level_result.getnodes()
    , _node_count = _diff_level_result.getnodecount()
    , _stats_tree = self.computetree(_node_array, _node_count)
    , _stats_levels = self.computelevels(_node_array, _node_count)
    , _catchall_levels = self.computecatchalls(_node_array, _node_count, _stats_levels, _diff_param_group)
    , _severity = DIALOG_MANAGER.DIFF_SEVERITY_OK
    , _summary_levels = []
  ;

  for (var _lv = DIALOG_MANAGER.LEVELS_ITEM_COUNT - 1; _lv >= 0; --_lv)
  {
    var _stat = _stats_levels[_lv]
      , _stat_level_tolerance = _diff_param_group.getlevelparam(_lv)
      , _stat_severity = _catchall_levels[_lv]
          ? DIALOG_MANAGER.DIFF_SEVERITY_OK
          : _stat_level_tolerance.calculateseverity(_stat)
    ;

    _stat.setseverity(_stat_severity);
    _severity = max(_severity, _stat_severity);
    _summary_levels[_lv] = DialogDiffSummaryLevelDTO.from(_lv, _stat_level_tolerance, _stat);
  }

  var _summary_nodes = self.updateseverity(_node_array, _node_count, _diff_param_group, _catchall_levels).merge(
    array_map(_summary_levels, function(_sl) {
      return _sl.getstats();
    })
  );

  self.summarylevels = _summary_levels;
  self.summarynodes = _summary_nodes;
  self.severity = int64(max(_severity, _summary_nodes.getseverity()));



  /**
   * @desc Creates a dialog diff summary data from the supplied data.
   * @param {Struct.DialogDiffResultDTO} _diff_level_result The diff level result object.
   * @returns {Struct.DialogDiffSummaryDTO}
   */

  static from = function(_diff_level_result)
  {
    return new DialogDiffSummaryDTO(_diff_level_result);
  }



  /**
   * @desc Returns the severity for this dialog diff summary data.
   * @returns {Real}
   */

  static getseverity = function()
  {
    return int64(self.severity);
  }



  /**
   * @desc Returns the summary data for each compared structure level.
   * @returns {Array<Struct.DialogDiffStatsLevelDTO>}
   */

  static getsummarylevels = function()
  {
    return self.summarylevels;
  }



  /**
   * @desc Returns the summary node for each structure level.
   * @returns {Array<Struct.DialogDiffDTO>}
   */

  static getsummarynodes = function()
  {
    return self.summarynodes;
  }



  /**
   * @desc Computes the summary tree for this dialog diff summary data.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes of the collection.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static computetree = function(_node_array, _node_count)
  {
    var _stats_total = DialogDiffStatsDTO.create();

    for (var _i = 0; _i < _node_count; ++_i)
    {
      var _node = _node_array[_i]
        , _stats_current = DialogDiffStatsDTO.fromtype(_node.getoperation().gettype())
        , _stats_child = self.computetree(_node.getitems(), _node.getitemcount())
      ;

      _stats_total.merge(_stats_current).merge(_stats_child);
      _node.setstats(_stats_current);
    }

    return _stats_total;
  }



  /**
   * @desc Computes summary statistics for every level in the difference tree.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes of the collection.
   * @param {Array<Struct.DialogDiffStatsLevelDTO>} [_level_stats] The level stats object.
   * @returns {Array<Struct.DialogDiffStatsLevelDTO>}
   */

  static computelevels = function(_node_array, _node_count, _level_stats = undefined)
  {
    if (is_undefined(_level_stats))
    {
      _level_stats = [];

      for (var _i = 0; _i < DIALOG_MANAGER.LEVELS_ITEM_COUNT; ++_i) {
        _level_stats[_i] = DialogDiffStatsLevelDTO.create();
      }
    }

    for (var _i = 0; _i < _node_count; ++_i)
    {
      var _node = _node_array[_i]
        , _lv = _node.getlevel()
      ;

      _level_stats[_lv].merge(DialogDiffStatsDTO.fromtype(_node.getoperation().gettype()));
      self.computelevels(_node.getitems(), _node.getitemcount(), _level_stats);
    }

    return _level_stats;
  }



  /**
   * @desc Aggregates the statistics of the supplied nodes without recursing into their children.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static computenodestats = function(_node_array, _node_count)
  {
    var _stats = DialogDiffStatsDTO.create();

    for (var _i = 0; _i < _node_count; ++_i) {
      _stats.merge(_node_array[_i].getstats());
    }

    return _stats;
  }



  /**
   * @desc Replaces derived modification counts with child-level changes that exceed their tolerances.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes.
   * @param {Array<Struct.DialogDiffStatsLevelDTO>} _level_stats The aggregate statistics by level.
   * @param {Struct.DialogDiffParamGroupDTO} _diff_param_group The diff parameter group.
   * @returns {Array<Bool>} The levels whose severity is covered by a parent modification tolerance.
   */

  static computecatchalls = function(_node_array, _node_count, _level_stats, _diff_param_group)
  {
    var _catchall_levels = array_create(DIALOG_MANAGER.LEVELS_ITEM_COUNT, false);

    for (var _lv = DIALOG_MANAGER.LEVEL_DIALOG; _lv < DIALOG_MANAGER.LEVELS_ITEM_COUNT; ++_lv)
    {
      var _child_level = _lv - 1
        , _child_param = _diff_param_group.getlevelparam(_child_level)
      ;

      _catchall_levels[_child_level] |= _diff_param_group.getlevelparam(_lv).hasmodificationtolerance();

      self.computecatchallnodes(
        _node_array, _node_count, _lv,
        _level_stats[_child_level], _child_param, _level_stats[_lv]
      );
    }

    return _catchall_levels;
  }



  /**
   * @desc Updates modified nodes at a level to count only changes not tolerated by the child level.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes.
   * @param {Real} _level The parent level whose modified nodes are updated.
   * @param {Struct.DialogDiffStatsLevelDTO} _child_level_stats The aggregate child-level statistics.
   * @param {Struct.DialogDiffParamDTO} _child_level_param The child-level tolerances.
   * @param {Struct.DialogDiffStatsLevelDTO} _level_stats The aggregate parent-level statistics.
   * @returns {Void}
   */

  static computecatchallnodes = function(_node_array, _node_count, _level, _child_level_stats, _child_level_param, _level_stats)
  {
    for (var _i = 0; _i < _node_count; ++_i)
    {
      var _node = _node_array[_i];

      if (_node.getlevel() == _level && _node.getoperation().gettype() == DIALOG_MANAGER.DIFF_OP_MODIFIED)
      {
        var _child_stats = self.computenodestats(_node.getitems(), _node.getitemcount())
          , _modification_count = _child_level_param.getuncaughtstatcount(_child_stats, _child_level_stats)
          , _modification_delta = _modification_count - _node.getstats().getmodifications()
          , _stats_delta = DialogDiffStatsDTO.fromtype(DIALOG_MANAGER.DIFF_OP_MODIFIED, _modification_delta)
        ;

        _node.getstats().merge(_stats_delta);
        _level_stats.merge(_stats_delta);
      }

      self.computecatchallnodes(
        _node.getitems(), _node.getitemcount(), _level,
        _child_level_stats, _child_level_param, _level_stats
      );
    }
  }



  /**
   * @desc Updates the severity of dialog nodes based on their statistics and diff parameters.
   * @param {Array<Struct.DialogDiffNodeDTO>} _node_array The node list.
   * @param {Real} _node_count The number of nodes of the collection.
   * @param {Struct.DialogDiffParamGroupDTO} _diff_param_group The diff param group object.
   * @param {Array<Bool>} _catchall_levels The levels whose severity is covered by a parent modification tolerance.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static updateseverity = function(_node_array, _node_count, _diff_param_group, _catchall_levels)
  {
    var _severity = DIALOG_MANAGER.DIFF_SEVERITY_OK
      , _violations = 0
    ;

    for (var _i = 0; _i < _node_count; ++_i)
    {
      var _node = _node_array[_i]
        , _level = _node.getlevel()
        , _severity_current = _catchall_levels[_level]
            ? DIALOG_MANAGER.DIFF_SEVERITY_OK
            : _diff_param_group.getlevelparam(_level).calculateseverity(_node.getstats())
        , _child_data = self.updateseverity(_node.getitems(), _node.getitemcount(), _diff_param_group, _catchall_levels)
      ;

      // *: Clears self-level error reporting by using -1 weight on node type
      _node.getstats().merge(DialogDiffStatsDTO.fromtype(_node.getoperation().gettype(), -1));
      _node.setseverity(max(_severity_current, _child_data.getseverity()));
      _violations += _node.isviolating() + _child_data.getviolations();
      _severity = max(_node.getseverity(), _severity);
    }

    return DialogDiffStatsLevelDTO.from(_severity, _violations);
  }
}












/**
 * @desc Summarizes difference statistics for one structure level.
 * @param {Real} _level The level of the summary.
 * @param {Struct.DialogDiffParamDTO} _tolerance The tolerance parameters for this level.
 * @param {Struct.DialogDiffStatsLevelDTO} _stats_level The statistics for this level.
 * @returns {Struct.DialogDiffSummaryLevelDTO}
 */

function DialogDiffSummaryLevelDTO(_level, _tolerance, _stats_level) : DialogDiffDTO() constructor
{
  self.level = _level;
  self.tolerance = _tolerance;
  self.severity = _stats_level.getseverity();
  self.stats = _stats_level;



  /**
   * @desc Creates a new instance of DialogDiffSummaryLevelDTO.
   * @param {Real} _level The level of the summary.
   * @param {Struct.DialogDiffParamDTO} _tolerance The tolerance parameters for this level.
   * @param {Struct.DialogDiffStatsLevelDTO} _stats_level The statistics for this level.
   * @returns {Struct.DialogDiffSummaryLevelDTO}
   */

  static from = function(_level, _tolerance, _stats_level)
  {
    return new DialogDiffSummaryLevelDTO(_level, _tolerance, _stats_level);
  }



  /**
   * @desc Returns the level for this dialog diff summary level data.
   * @returns {Real}
   */

  static getlevel = function()
  {
    return self.level;
  }



  /**
   * @desc Returns the stats for this dialog diff summary level data.
   * @returns {Array<Struct.DialogDiffStatsLevelDTO>}
   */

  static getstats = function()
  {
    return self.stats;
  }



  /**
   * @desc Returns the tolerance for this dialog diff summary level data.
   * @returns {Struct.DialogDiffParamGroupDTO}
   */

  static gettolerance = function()
  {
    return self.tolerance;
  }



  /**
   * @desc Updates this diff summary level data's level with a user-readable string.
   * @returns {Struct.DialogDiffSummaryLevelDTO}
   */

  static usereadabledata = function()
  {
    self.level = string_upper(self.getlevelname(self.getlevel()));

    return self;
  }
}












/**
 * @desc Represents one insert, delete, move, modify, or match operation.
 * @param {int64} _id The ID of the operation.
 * @param {string} _type The type of the operation.
 * @param {int64} _index The index of the operation.
 * @param {int64} [_indexmatch] The index of the matched operand.
 * @returns {Struct.DialogDiffOperationDTO}
 */

function DialogDiffOperationDTO(_id, _type, _index, _indexmatch) : DialogDiffDTO() constructor
{
  self.id = int64(_id);
  self.index = int64(_index);
  self.indexmatch = int64(_indexmatch);
  self.type = _type;



  /**
   * @desc Creates a new instance of DialogDiffOperationDTO.
   * @param {int64} _id The ID of the operation.
   * @param {string} _type The type of the operation.
   * @param {int64} _index The index of the operation.
   * @param {int64} [_indexmatch] The index of the matched operand.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static from = function(_id, _type, _index, _indexmatch = DIALOG_MANAGER.DIFF_OP_UNMATCHED)
  {
    return new DialogDiffOperationDTO(_id, _type, _index, _indexmatch);
  }



  /**
   * @desc Returns the id for this dialog diff operation data.
   * @returns {Real}
   */

  static getid = function()
  {
    return int64(self.id);
  }



  /**
   * @desc Gets the index of the operation.
   * @returns {Real}
   */

  static getindex = function()
  {
    return int64(self.index);
  }



  /**
   * @desc Gets the index of the matched operand.
   * @returns {Real}
   */

  static getindexmatch = function()
  {
    return int64(self.indexmatch);
  }



  /**
   * @desc Gets the type of this operation.
   * @returns {string}
   */

  static gettype = function()
  {
    return self.type;
  }



  /**
   * @desc Sets the index of this operation.
   * @param {Real} _index The index of the operation.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static setindex = function(_index)
  {
    self.index = _index;

    return self;
  }



  /**
   * @desc Sets the index of the matched operand for this operation.
   * @param {Real} _indexmatch The index of the matched operand.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static setindexmatch = function(_indexmatch)
  {
    self.indexmatch = int64(_indexmatch);

    return self;
  }



  /**
   * @desc Sets the type of this operation.
   * @param {Real|string} _type The type of the operation.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static settype = function(_type)
  {
    self.type = _type;

    return self;
  }



  /**
   * @desc Sets the type name for this dialog diff operation data.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static settypename = function()
  {
    return self.settype(self.getoperationname(self.gettype()));
  }
}












/**
 * @desc Represents a comparison operation at a location in the structure tree.
 * @param {Struct.DialogDiffOperationDTO} _operation The operation associated with this node.
 * @param {Real} _level The level of the node in the dialog structure.
 * @param {string} _path The path of the node in the dialog structure.
 * @returns {Struct.DialogDiffNodeDTO}
 */

function DialogDiffNodeDTO(_operation, _level, _path) : DialogDiffDTO() constructor
{
  self.operation = _operation;
  self.level = _level;
  self.path = _path;
  self.items = [];
  self.itemcount = int64(0);
  self.stats = undefined;
  self.severity = int64(0);
  self.violating = false;



  /**
   * @desc Creates a new instance of DialogDiffNodeDTO.
   * @param {Struct.DialogDiffOperationDTO} _operation The operation associated with this node.
   * @param {Real} _level The level of the node in the dialog structure.
   * @param {string} _path The path of the node in the dialog structure.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static from = function(_operation, _level, _path)
  {
    return new DialogDiffNodeDTO(_operation, _level, _path);
  }



  /**
   * @desc Gets the operation associated with this node.
   * @returns {Struct.DialogDiffOperationDTO}
   */

  static getoperation = function()
  {
    return self.operation;
  }



  /**
   * @desc Gets the items associated with this node.
   * @returns {Array}
   */

  static getitems = function()
  {
    return self.items;
  }



  /**
   * @desc Gets the number of items associated with this node.
   * @returns {Real}
   */

  static getitemcount = function()
  {
    return int64(self.itemcount);
  }



  /**
   * @desc Gets the statistics associated with this node.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static getstats = function()
  {
    return self.stats;
  }



  /**
   * @desc Gets the path of the node in the dialog structure.
   * @returns {string}
   */

  static getpath = function()
  {
    return self.path;
  }



  /**
   * @desc Gets the level of the node in the dialog structure.
   * @returns {Real}
   */

  static getlevel = function()
  {
    return self.level;
  }



  /**
   * @desc Gets the severity of the node.
   * @returns {Real}
   */

  static getseverity = function()
  {
    return int64(self.severity);
  }



  /**
   * @desc Checks if the node is violating any rules.
   * @returns {Bool}
   */

  static isviolating = function()
  {
    return self.violating;
  }



  /**
   * @desc Modifies the level and operation name with user-readable strings.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static usereadabledata = function()
  {
    self.level = string_upper(self.getlevelname(self.getlevel()));

    return self.setoperationtypename();
  }



  /**
   * @desc Sets the type of the operation associated with this node.
   * @param {string} _type The type of the operation.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static setoperationtype = function(_type)
  {
    self.operation.settype(_type);

    return self;
  }



  /**
   * @desc Sets the type name of the operation associated with this node.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static setoperationtypename = function()
  {
    self.operation.settypename();

    return self;
  }



  /**
   * @desc Sets the items associated with this node.
   * @param {Array} _items The items to associate with this node.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static setitems = function(_items)
  {
    self.items = _items;
    self.itemcount = int64(array_length(_items));

    return self;
  }



  /**
   * @desc Sets the statistics associated with this node.
   * @param {Struct.DialogDiffStatsDTO} _stats The statistics to associate with this node.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static setstats = function(_stats)
  {
    self.stats = _stats;

    return self;
  }



  /**
   * @desc Sets the severity of this node.
   * @param {int64} _severity The severity of the node.
   * @returns {Struct.DialogDiffNodeDTO}
   */

  static setseverity = function(_severity)
  {
    self.severity = int64(_severity);
    self.violating = _severity >= DIALOG_MANAGER.DIFF_SEVERITY_ERROR;

    return self;
  }
}












/**
 * @desc Groups tolerance parameters used by the structure comparator.
 * @param {Array<Array<Real>>} [_params] The parameters for the diff tolerance.
 * @returns {Struct.DialogDiffParamGroupDTO}
 */

function DialogDiffParamGroupDTO(_params) : DialogDiffDTO() constructor
{
  self.tolerance = [];

  for (var _lv = array_length(_params); _lv < DIALOG_MANAGER.LEVELS_ITEM_COUNT; ++_lv) {
    array_push(_params, []);
  }

  for (var _lv = 0; _lv < DIALOG_MANAGER.LEVELS_ITEM_COUNT; ++_lv) {
    self.tolerance[_lv] = DialogDiffParamDTO.from(_params[_lv]);
  }



  /**
   * @desc Creates a new instance of DialogDiffParamGroupDTO.
   * @param {Array<Array<Real>>} [_params] The parameters for the diff tolerance.
   * @returns {Struct.DialogDiffParamGroupDTO}
   */

  static from = function(_params = [])
  {
    return new DialogDiffParamGroupDTO(_params);
  }



  /**
   * @desc Returns the specified level parameters for this dialog diff param group data.
   * @param {Constant.DIALOG_MANAGER} _lv The item level.
   * @return {Struct.DialogDiffParamDTO}
   */

  static getlevelparam = function(_lv)
  {
    return self.tolerance[_lv];
  }
}












/**
 * @desc Represents a single level comparison tolerance parameter.
 * @param {Array<Real>} _param_data The parameter data for the diff tolerance.
 * @returns {Struct.DialogDiffParamDTO}
 */

function DialogDiffParamDTO(_param_data) : DialogDiffDTO() constructor
{
  for (var _lv = array_length(_param_data); _lv < DIALOG_MANAGER.DIFF_ARG_TOLERANCES_COUNT; ++_lv) {
    array_push(_param_data, 0);
  }

  self.insertions = [
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_INSERTIONS_WARNING   ]),
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_INSERTIONS_MAX       ])
  ];
  self.deletions = [
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_DELETIONS_WARNING    ]),
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_DELETIONS_MAX        ])
  ];
  self.moves = [
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_MOVES_WARNING        ]),
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_MOVES_MAX            ])
  ];
  self.modifications = [
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_MODIFICATIONS_WARNING]),
    int64(_param_data[DIALOG_MANAGER.DIFF_ARG_TOLERANCE_MODIFICATIONS_MAX    ])
  ];

  self.types = [self.insertions, self.deletions, self.moves, self.modifications];

  for (var _i = 0; _i < DIALOG_MANAGER.DIFF_ARG_TOLERANCES_COUNT >> 1; ++_i) {
    array_sort(self.types[_i], true);
  }



  /**
   * @desc Creates a new instance of DialogDiffParamDTO.
   * @param {Array<Real>} _param_data The parameter data for the diff tolerance.
   * @returns {Struct.DialogDiffParamDTO}
   */

  static from = function(_param_data)
  {
    return new DialogDiffParamDTO(_param_data);
  }



  /**
   * @desc Returns whether this level has a nonzero modification tolerance.
   * @returns {Bool}
   */

  static hasmodificationtolerance = function()
  {
    return self.modifications[DIALOG_MANAGER.DIFF_SEVERITY_OK] != 0
      || self.modifications[DIALOG_MANAGER.DIFF_SEVERITY_WARNING] != 0
    ;
  }



  /**
   * @desc Counts only statistics that exceed this level's maximum tolerances.
   * @param {Struct.DialogDiffStatsDTO} _stats The statistics to count.
   * @param {Struct.DialogDiffStatsDTO} _aggregate_stats The aggregate statistics used to evaluate tolerances.
   * @returns {Real}
   */

  static getuncaughtstatcount = function(_stats, _aggregate_stats)
  {
    var _stats_array = _stats.getstatsarray()
      , _aggregate_stats_array = _aggregate_stats.getstatsarray()
      , _uncaught_count = 0
    ;

    for (var _i = 0; _i < DIALOG_MANAGER.__DIFF_OP_STAT_COUNT; ++_i) {
      if (self.calculatetypeseverity(self.types[_i], _aggregate_stats_array[_i]) == DIALOG_MANAGER.DIFF_SEVERITY_ERROR) {
        _uncaught_count += _stats_array[_i];
      }
    }

    return _uncaught_count;
  }



  /**
   * @desc Calculates the severity of a specific type based on its tolerance and statistics.
   * @param {Array<Real>} _type_tolerance The tolerance values for the type.
   * @param {Real} _stat The statistic value for the type.
   * @returns {Real}
   */

  static calculatetypeseverity = function(_type_tolerance, _stat)
  {
    return _stat > _type_tolerance[DIALOG_MANAGER.DIFF_SEVERITY_WARNING]
      ? DIALOG_MANAGER.DIFF_SEVERITY_ERROR
      : _stat > _type_tolerance[DIALOG_MANAGER.DIFF_SEVERITY_OK]
    ;
  }



  /**
   * @desc Calculates the overall severity based on the statistics of insertions, deletions, modifications and moves.
   * @param {Struct.DialogDiffStatsDTO} _stats The statistics to evaluate.
   * @returns {Real}
   */

  static calculateseverity = function(_stats)
  {
    var _types = _stats.getstatsarray()
      , _max = DIALOG_MANAGER.DIFF_SEVERITY_OK
    ;

    for (var _i = 0; _i < DIALOG_MANAGER.__DIFF_OP_STAT_COUNT; ++_i) {
      _max = max(_max, self.calculatetypeseverity(self.types[_i], _types[_i]));
    }

    return _max;
  }
}












/**
 * @desc Stores aggregate severity statistics for a comparison.
 * @returns {Struct.DialogDiffStatsDTO}
 */

function DialogDiffStatsDTO() : DialogDiffDTO() constructor
{
  self.modifications = int64(0);
  self.insertions    = int64(0);
  self.deletions     = int64(0);
  self.moves         = int64(0);
  self.total         = int64(0);



  /**
   * @desc Creates a new instance of DialogDiffStatsDTO.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static create = function()
  {
    return new DialogDiffStatsDTO();
  }



  /**
   * @desc Creates a new instance of DialogDiffStatsDTO based on a specific operation type and weight.
   * @param {string} _type The type of operation (inserted, deleted, moved, modified).
   * @param {Real} [_weight] The weight to apply to the operation.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static fromtype = function(_type, _weight = 1)
  {
    var _stats = self.create();

    switch (_type)
    {
      case DIALOG_MANAGER.DIFF_OP_INSERTED:
        _stats.insertions = _weight;
      break;

      case DIALOG_MANAGER.DIFF_OP_DELETED:
        _stats.deletions = _weight;
      break;

      case DIALOG_MANAGER.DIFF_OP_MOVED:
        _stats.moves = _weight;
      break;

      case DIALOG_MANAGER.DIFF_OP_MODIFIED:
        _stats.modifications = _weight;
      break;
    }

    _stats.total = _stats.calculatetotal();

    return _stats;
  }



  /**
   * @desc Returns the number of inserted items in the comparison.
   * @returns {Real}
   */

  static getinsertions = function()
  {
    return int64(self.insertions);
  }



  /**
   * @desc Returns the number of deleted items in the comparison.
   * @returns {Real}
   */

  static getdeletions = function()
  {
    return int64(self.deletions);
  }



  /**
   * @desc Returns the number of modified items in the comparison.
   * @returns {Real}
   */

  static getmodifications = function()
  {
    return int64(self.modifications);
  }



  /**
   * @desc Returns the number of moves for this dialog diff stats data.
   * @returns {Real}
   */

  static getmoves = function()
  {
    return int64(self.moves);
  }



  /**
   * @desc Returns the total number of operations for this dialog diff stats data.
   * @returns {Real}
   */

  static gettotal = function()
  {
    return int64(self.total);
  }



  /**
   * @desc Returns the stats array for this dialog diff stats data.
   * @returns {Array<Real>}
   */

  static getstatsarray = function()
  {
    return [self.getinsertions(), self.getdeletions(), self.getmoves(), self.getmodifications()];
  }



  /**
   * @desc Calculates the total number of operations for this dialog diff stats data.
   * @returns {Real}
   */

  static calculatetotal = function()
  {
    return self.insertions + self.deletions + self.moves + self.modifications;
  }



  /**
   * @desc Merges the statistics of another operation on this dialog diff stats data.
   * @param {Struct.DialogDiffStatsDTO|Array<Struct.DialogDiffStatsDTO>} _stats The stats object.
   * @param {Real} [_weight] The weight value.
   * @returns {Struct.DialogDiffStatsDTO}
   */

  static merge = function(_stats, _weight = 1)
  {
    if (!is_array(_stats)) {
      _stats = [_stats];
    }

    for (var _i = array_length(_stats) - 1; _i >= 0; --_i)
    {
      var _s = _stats[_i];
      self.modifications = int64(self.modifications + _s.getmodifications() * _weight);
      self.insertions    = int64(self.insertions    + _s.getinsertions()    * _weight);
      self.deletions     = int64(self.deletions     + _s.getdeletions()     * _weight);
      self.moves         = int64(self.moves         + _s.getmoves()         * _weight);
      self.total         = int64(self.total         + _s.gettotal()         * _weight);
    }

    return self;
  }
}












/**
 * @desc Stores severity and violation counts for one comparison level.
 * @param {Constant.DIALOG_MANAGER} _severity The severity level.
 * @param {Real} _violations The violations value.
 * @returns {Struct.DialogDiffStatsLevelDTO}
 */

function DialogDiffStatsLevelDTO(_severity, _violations) : DialogDiffStatsDTO() constructor
{
  self.severity = int64(_severity);
  self.violations = int64(_violations);



  /**
   * @desc Creates a new instance of DialogDiffStatsLevelDTO.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static create = function()
  {
    return self.from(DIALOG_MANAGER.DIFF_SEVERITY_OK, 0);
  }



  /**
   * @desc Creates a new instance of DialogDiffStatsLevelDTO.
   * @param {Constant.DIALOG_MANAGER} _severity The severity level.
   * @param {Real} _violations The violations value.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static from = function(_severity, _violations)
  {
    return new DialogDiffStatsLevelDTO(_severity, _violations);
  }



  /**
   * @desc Gets the severity level.
   * @returns {Real}
   */

  static getseverity = function()
  {
    return int64(self.severity);
  }



  /**
   * @desc Gets the number of violations.
   * @returns {Real}
   */

  static getviolations = function()
  {
    return int64(self.violations);
  }



  /**
   * @desc Sets the severity level.
   * @param {Real} _severity The severity level to set.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static setseverity = function(_severity)
  {
    self.severity = _severity;

    return self;
  }



  /**
   * @desc Sets the number of violations.
   * @param {Real} _violations The number of violations to set.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static setviolations = function(_violations)
  {
    self.violations = _violations;

    return self;
  }



  /**
   * @desc Adds violations to the current count.
   * @param {Real} _violations The number of violations to add.
   * @returns {Struct.DialogDiffStatsLevelDTO}
   */

  static addviolations = function(_violations)
  {
    return self.setviolations(self.getviolations() + _violations);
  }
}

#endregion












#endregion

// ----------------------------------------------------------------------------

#region Helpers and utilities













/**
 * @desc Stores indexed functions used to execute, condition, or index dialog effects.
 * @param {Any} _funcs The functions stored in this map.
 * @param {Any} _capacity The capacity value.
 * @returns {Struct.DialogFXMap}
 */

function DialogFXMap(_funcs, _capacity) constructor
{
  self.funcs = DialogItemCollection.normalize(_funcs);
  self.count = array_length(self.funcs);
  self.capacity = _capacity;



  /**
   * @desc Creates a new instance of DialogFXMap.
   * @param {Array<Function>} _func_list The list of functions to include in the map.
   * @param {Real} [_capacity] The maximum capacity of the map. Defaults to `DIALOG_FX.__BITMASK_TYPE_MAX_COUNT`.
   * @returns {Struct.DialogFXMap}
   */

  static create = function(_func_list, _capacity = DIALOG_FX.__BITMASK_TYPE_MAX_COUNT)
  {
    return new DialogFXMap(_func_list, _capacity);
  }



  /**
   * @desc Gets the function at the specified index.
   * @param {Real} _idx The index of the function to retrieve.
   * @returns {Function}
   */

  static getfunc = function(_idx)
  {
    return self.funcs[_idx + self.count * (_idx < 0)];
  }



  /**
   * @desc Gets the number of stored functions.
   * @returns {Real}
   */

  static getcount = function()
  {
    return self.count;
  }



  /**
   * @desc Gets the capacity of the function map.
   * @returns {Real}
   */

  static getcapacity = function()
  {
    return self.capacity;
  }



  /**
   * @desc Registers a function in the map.
   * @param {Function} _func The function to register.
   * @param {Real} [_idx] The index at which to register the function.
   * @returns {Real} The index at which the function was registered.
   */

  static register = function(_func, _idx = self.getcount())
  {
    if (self.getcount() >= self.getcapacity()) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_MAX_FX_CAPACITY_REACHED, [
        _idx, self.getcapacity()
      ]);
    }

    self.count = max(_idx, self.count);
    self.funcs[_idx] = _func;

    return _idx;
  }



  /**
   * @desc Removes a function from the map at the specified index.
   * @param {Real} [_idx] The index of the function to remove. Defaults to the last function.
   * @returns {Function} The removed function.
   */

  static remove = function(_idx = self.getcount())
  {
    if (_idx < 0 || _idx >= self.count) {
      throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
        nameof(_idx), _idx
      ]);
    }

    var _func = self.funcs[_idx];

    self.count -= _idx == self.count;
    self.funcs[_idx] = undefined;

    return _func;
  }
}












/**
 * @desc Provides shared operations for reading and updating bitmask regions.
 * @returns {Struct.DialogBitmaskResolver}
 */

function DialogBitmaskResolver() constructor
{
  /**
   * @desc Returns the specified bit in a bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _bit_idx The bit index value.
   * @returns {Real}
   */

  static getbit = function(_bitmask, _bit_idx)
  {
    return self.filter(_bitmask >> _bit_idx, 1);
  }



  /**
   * @desc Returns the specified flag in a bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _flag The flag value.
   * @returns {Bool}
   */

  static getflag = function(_bitmask, _flag)
  {
    return bool(self.filter(_bitmask, _flag));
  }



  /**
   * @desc Returns the specified mask region in a bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _shift The shift value.
   * @param {Real} _mask The mask value.
   * @returns {Real}
   */

  static getmask = function(_bitmask, _shift, _mask)
  {
    return self.filter(_bitmask >> _shift, _mask);
  }



  /**
   * @desc Retains only the bits present in the supplied masks.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _filter_masks The bitmask or masks to retain.
   * @returns {Real}
   */

  static filter = function(_bitmask, _filter_masks)
  {
    return int64(_bitmask & (
      is_array(_filter_masks)
        ? array_reduce(_filter_masks, function(_acc, _curr, _i) {
            return _acc & _curr;
          }, -1)
        : _filter_masks
    ));
  }



  /**
   * @desc Applies the supplied mask filter only when the condition is `true`.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _filter_masks The bitmask or masks to retain.
   * @param {Bool} _condition Whether to apply the filter.
   * @returns {Real}
   */

  static filterif = function(_bitmask, _filter_masks, _condition)
  {
    return _condition
      ? self.filter(_bitmask, _filter_masks)
      : _bitmask
    ;
  }



  /**
   * @desc Removes the bits present in the supplied masks.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _filter_masks The bitmask or masks to remove.
   * @returns {Real}
   */

  static filterout = function(_bitmask, _filter_masks)
  {
    return self.filter(_bitmask, is_array(_filter_masks)
      ? array_map(_filter_masks, function(_m) { return ~_m; })
      : ~_filter_masks
    );
  }



  /**
   * @desc Removes the supplied masks only when the condition is `true`.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _filter_masks The bitmask or masks to remove.
   * @param {Bool} _condition Whether to remove the masks.
   * @returns {Real}
   */

  static filteroutif = function(_bitmask, _filter_masks, _condition)
  {
    return _condition
      ? self.filterout(_bitmask, _filter_masks)
      : _bitmask
    ;
  }



  /**
   * @desc Clears the bit at the specified index inside a bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _bit_idx The bit index value.
   * @returns {Real}
   */

  static filteroutbit = function(_bitmask, _bit_idx)
  {
    return self.filterout(_bitmask, 1 << _bit_idx);
  }



  /**
   * @desc Combines the supplied masks with the specified bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _composition_masks The masks to compose into the result.
   * @returns {Real}
   */

  static compose = function(_bitmask, _composition_masks)
  {
    return int64(_bitmask | (
      is_array(_composition_masks)
        ? array_reduce(_composition_masks, function(_acc, _curr, _i) {
            return _acc | _curr;
          }, 0)
        : _composition_masks
    ));
  }



  /**
   * @desc Combines the supplied masks only when the condition is `true`.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real|Array<Real>} _composition_masks The masks to compose into the result.
   * @param {Any} _condition The condition value.
   * @returns {Real}
   */

  static composeif = function(_bitmask, _composition_masks, _condition)
  {
    return _condition
      ? self.compose(_bitmask, _composition_masks)
      : _bitmask
    ;
  }



  /**
   * @desc Creates a mask containing the requested number of bits at the specified shift.
   * @param {Real} _bits The number of bits to include.
   * @param {Real} [_shift] The bit position at which to begin the mask.
   * @returns {Real}
   */

  static createmask = function(_bits, _shift = 0)
  {
    return (1 << _bits) - 1 << _shift;
  }



  /**
   * @desc Encodes a mask region inside a settings mask value.
   * @param {Real} _value The value to encode.
   * @param {Real} _shift The shift value.
   * @param {Real} _bits The number of mask bits.
   * @returns {Real}
   */

  static encodemask = function(_value, _shift, _bits)
  {
    return self.filter(_value, (1 << _bits) - 1) << _shift;
  }



  /**
   * @desc Decodes a mask region from a settings mask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _shift The shift value.
   * @param {Real} _bits The number of bits.
   * @returns {Real}
   */

  static decodemask = function(_bitmask, _shift, _bits)
  {
    return self.filter(_bitmask >> _shift, (1 << _bits) - 1);
  }



  /**
   * @desc Replaces the region settings on the specified bitmask.
   * @param {Real} _bitmask The bitmask value.
   * @param {Real} _value The value to replace with.
   * @param {Real} _shift The shift value.
   * @param {Real} _bits The number of mask bits.
   * @returns {Real} The altered bitmask.
   */

  static replaceregion = function(_bitmask, _value, _shift, _bits)
  {
    var _mask = self.encodemask(_value, _shift, _bits);

    return self.compose(self.filter(_bitmask, ~_mask), _mask);
  }
}












/**
 * @desc Describes a region of bits and its default value in a settings mask.
 * @param {Real} _shift The shift value.
 * @param {Real} _bits The bits value.
 * @param {Real} [_default_val] The default value.
 * @returns {Struct.DialogBitmaskRegion}
 */

function DialogBitmaskRegion(_shift, _bits, _default_val) constructor
{
  self.shift = _shift;
  self.bits = _bits;
  self.default_value = _default_val;



  /**
   * @desc Creates a dialog bitmask region from the supplied from.
   * @param {Real} _shift The shift value.
   * @param {Real} _bits The bits value.
   * @param {Real} [_default_val] The default value.
   * @returns {Struct.DialogBitmaskRegion}
   */

  static from = function(_shift, _bits, _default_val = 0)
  {
    return new DialogBitmaskRegion(_shift, _bits, _default_val);
  }



  /**
   * @desc Returns the shift for this dialog bitmask region.
   * @returns {Real}
   */

  static getshift = function()
  {
    return self.shift;
  }



  /**
   * @desc Returns the bits for this dialog bitmask region.
   * @returns {Real}
   */

  static getbits = function()
  {
    return self.bits;
  }



  /**
   * @desc Returns the default value for this dialog bitmask region.
   * @returns {Real}
   */

  static getdefault = function()
  {
    return self.default_value;
  }



  /**
   * @desc Returns the encoded mask for this dialog bitmask region.
   * @returns {Real}
   */

  static getmask = function()
  {
    return self.encode(-1);
  }



  /**
   * @desc Decodes a value from its settings mask using this region's properties.
   * @param {Real} [_mask] The mask value to decode.
   * @returns {Real}
   */

  static decode = function(_mask = 0)
  {
    return DialogBitmaskResolver.decodemask(_mask, self.getshift(), self.getbits());
  }



  /**
   * @desc Encodes the a value in a settings mask using this region's properties.
   * @param {Real} [_value] The value to encode.
   * @returns {Real}
   */

  static encode = function(_value = 0)
  {
    return DialogBitmaskResolver.encodemask(_value, self.getshift(), self.getbits());
  }
}












/**
 * @desc Provides shared bitmask region operations to dialog manager objects.
 * @returns {Struct.DialogBitmaskRegionWorker}
 */

function DialogBitmaskRegionWorker() constructor
{
  /**
   * @desc Returns the mask for this dialog bitmask region worker.
   * @returns {Real}
   */

  static getmask = function()
  {
    return self.settings_mask;
  }



  /**
   * @desc Decodes a mask region value.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} _mask The mask value to decode.
   * @returns {Real}
   */

  static decodemaskregion = function(_region, _mask)
  {
    return _region.decode(_mask);
  }



  /**
   * @desc Encodes a mask region value.
   * @param {Struct.DialogBitMaskRegion} _region The region object.
   * @param {Real} _value The value to encode.
   * @returns {Real}
   */

  static encodemaskregion = function(_region, _value)
  {
    return _region.encode(_value);
  }



  /**
   * @desc Filters the mask region using the supplied predicate.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} _mask The mask value to encode for filtering.
   * @param {Real} _filter_mask The filter mask value.
   * @returns {Real}
   */

  static filtermaskregion = function(_region, _mask, _filter_mask)
  {
    return DialogBitmaskResolver.filter(_mask, _region.encode(_filter_mask));
  }



  /**
   * @desc Replaces the mask region settings on this dialog bitmask region worker.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} _mask The mask value.
   * @param {Real} _value The value for replacement.
   * @returns {Real}
   */

  static replacemaskregion = function(_region, _mask, _value)
  {
    return DialogBitmaskResolver.replaceregion(
      _mask, _value, _region.getshift(), _region.getbits()
    );
  }



  /**
   * @desc Checks whether this dialog bitmask region worker contains the specified mask region value.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real} _mask The mask value.
   * @param {Real} _value The value to check for.
   * @returns {Bool}
   */

  static hasmaskregionvalue = function(_region, _mask, _value)
  {
    var _decoded = self.decodemaskregion(_region, _mask);

    return is_undefined(_value)
      ? bool(_decoded)
      : _decoded == _value
    ;
  }



  /**
   * @desc Checks whether this dialog bitmask region worker contains the specified mask region flag.
   * @param {Struct.DialogBitmaskRegion} _region The region object.
   * @param {Real|undefined} _mask The mask value.
   * @param {Real|undefined} _flag The flag to check for.
   * @returns {Bool}
   */

  static hasmaskregionflag = function(_region, _mask, _flag)
  {
    return bool(self.filtermaskregion(_region, _mask, _flag));
  }
}












/**
 * @desc Wraps raw source data for import and export operations.
 * @param {Any} _raw The raw value.
 * @returns {Struct.DialogRawSource}
 */

function DialogRawSource(_raw) : DialogRawInterface() constructor
{
  if (!(is_struct(_raw) || is_array(_raw))) {
    throw DialogManager.ERROR(DIALOG_MANAGER.ERR_INVALID_ARGUMENT_VALUE, [
      nameof(_raw), _raw
    ]);
  }

  var _raw_adapted = _raw;

  if (is_array(_raw))
  {
    _raw_adapted = {};

    for (var _i = array_length(_raw) - 1; _i >= 0; --_i) {
      _raw_adapted[$ _i] = _raw[_i];
    }
  }

  self.raw = _raw_adapted;



  /**
   * @desc Creates a dialog raw source instance from the supplied raw data.
   * @param {Struct} _raw The raw value.
   * @returns {Struct.DialogRawSource}
   */

  static from = function(_raw)
  {
    return new DialogRawSource(_raw);
  }



  /**
   * @desc Returns the raw data of this dialog raw source.
   * @returns {Struct}
   */

  static getraw = function()
  {
    return self.raw;
  }



  /**
   * @desc Retrieves the value stored at the specified field name for this dialog raw source.
   * @param {Any} _raw_field The raw field name.
   * @param {Any} [_default_ret] The default return value.
   * @returns {Any}
   */

  static get = function(_raw_field, _default_ret = undefined)
  {
    return variable_struct_get(self.raw, _raw_field) ?? _default_ret;
  }
}












#endregion

// ----------------------------------------------------------------------------

// Self-initialization hell
gml_pragma(
  "global",
  @"
    new DialogBitmaskRegion(0, 0, 0); new DialogRawInterface(); new DialogRawSource({}); new DialogImporter(); new DialogExporter();
    new DialogBitmaskResolver(); new DialogItemCollection([], undefined); new DialogFXMap([], 0); new DialogManager();
    var _temp_fx = new DialogFX(0, [], -1);
    var _temp = new DialogStructure([new DialogScene([new DialogSequence([new Dialog(undefined, 0, [_temp_fx])])])]);
    new DialogHistory([], 1); new DialogRunner(_temp);
    new DialogDTO(); new DialogLinkDTO(); new DialogJumpResultDTO(); new DialogJumpContextDTO(); new DialogFlowOptionDTO();
    new DialogDiffDTO(); new DialogDiffStatsDTO(); new DialogDiffSummaryLevelDTO(0, 0, new DialogDiffStatsLevelDTO(0, 0)); new DialogDiffParamDTO([]); new DialogDiffParamGroupDTO([[]]);
    new DialogDiffResultLevelDTO([], 0, 0, 0); new DialogDiffOperationDTO(0, 0, 0, 0); new DialogDiffNodeDTO();
    new DialogDiffResultListDTO(); new DialogDiffSummaryDTO(); new DialogDiffResultDTO();
    new DialogResolver(); new DialogComparator();
  "
);
