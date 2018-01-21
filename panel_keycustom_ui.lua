local INPUT_COUNT_START_UI = 0
local INPUT_COUNT_END_UI = 14
local STATIC_INPUT_TITLE_UI = {}
local BUTTON_KEY_UI = {}
local BUTTON_PAD_UI = {}
local INPUT_TYPE_UI
local controls = {
  title = UI.getChildControl(Panel_KeyCustom_Ui, "StaticText_Title"),
  subtitle1 = UI.getChildControl(Panel_KeyCustom_Ui, "StaticText_Keyboard"),
  subtitle2 = UI.getChildControl(Panel_KeyCustom_Ui, "StaticText_Gamepad"),
  BG = UI.getChildControl(Panel_KeyCustom_Ui, "Static_BG"),
  confirm = UI.getChildControl(Panel_KeyCustom_Ui, "Button_Confirm"),
  cancel = UI.getChildControl(Panel_KeyCustom_Ui, "Button_Cancel"),
  apply = UI.getChildControl(Panel_KeyCustom_Ui, "Button_Apply"),
  scrollbar = UI.getChildControl(Panel_KeyCustom_Ui, "Scroll_Vertical"),
  scrollbarBtn = nil,
  sample_staticInputTitle = UI.getChildControl(Panel_KeyCustom_Ui, "StaticText_MoveFoward"),
  sample_keyButton = UI.getChildControl(Panel_KeyCustom_Ui, "Button_Key_MoveFoward"),
  sample_padButton = UI.getChildControl(Panel_KeyCustom_Ui, "Button_Pad_MoveFoward")
}
local keyConfigListShowCount_UI = 10
local configDataIndex_UI = 0
local keyConfigData_UI = {}
local function getKeyConfigData_UI(index)
  return keyConfigData_UI[configDataIndex_UI + index]
end
local function setKeyConfigData_UI(index, title, button, padKey)
  if title ~= nil then
    keyConfigData_UI[index] = {
      titleText = title,
      buttonKeyText = button,
      padKeyText = padKey
    }
  elseif nil ~= button then
    keyConfigData_UI[index].buttonKeyText = button
  else
    keyConfigData_UI[index].padKeyText = padKey
  end
end
local function setKeyConfigData_UITitle(index, title)
  setKeyConfigData_UI(index, title, "", "")
end
local function setKeyConfigData_UIConfigButton(index, button)
  setKeyConfigData_UI(index, nil, button, nil)
end
local function setKeyConfigData_UIConfigPad(index, pad)
  setKeyConfigData_UI(index, nil, nil, pad)
end
local function updateKeyConfig_UI()
  for index = 0, keyConfigListShowCount_UI - 1 do
    local keyConfigData_UI = getKeyConfigData_UI(index)
    if nil ~= keyConfigData_UI then
      STATIC_INPUT_TITLE_UI[index]:SetText(keyConfigData_UI.titleText)
      BUTTON_KEY_UI[index]:SetText(keyConfigData_UI.buttonKeyText)
      BUTTON_PAD_UI[index]:SetText(keyConfigData_UI.padKeyText)
    else
      STATIC_INPUT_TITLE_UI[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_KEYCUSTOM_KEYSET_EMPTY"))
      BUTTON_KEY_UI[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_KEYCUSTOM_KEYSET_EMPTY"))
      BUTTON_PAD_UI[index]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_KEYCUSTOM_KEYSET_EMPTY"))
    end
  end
end
local function init()
  local adderPosY = 35
  local titleStaticPosY = controls.sample_staticInputTitle:GetPosY()
  local keyButtonPosY = controls.sample_keyButton:GetPosY()
  local padButtonPosY = controls.sample_padButton:GetPosY()
  for ii = 0, keyConfigListShowCount_UI - 1 do
    STATIC_INPUT_TITLE_UI[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_KeyCustom_Ui, "StaticText_InputTitle_" .. tostring(ii))
    BUTTON_KEY_UI[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_BUTTON, Panel_KeyCustom_Ui, "Button_Key_" .. tostring(ii))
    BUTTON_PAD_UI[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_BUTTON, Panel_KeyCustom_Ui, "Button_Pad_" .. tostring(ii))
    CopyBaseProperty(controls.sample_staticInputTitle, STATIC_INPUT_TITLE_UI[ii])
    CopyBaseProperty(controls.sample_keyButton, BUTTON_KEY_UI[ii])
    CopyBaseProperty(controls.sample_padButton, BUTTON_PAD_UI[ii])
    STATIC_INPUT_TITLE_UI[ii]:SetIgnore(true)
    STATIC_INPUT_TITLE_UI[ii]:SetShow(true)
    BUTTON_KEY_UI[ii]:SetShow(true)
    BUTTON_PAD_UI[ii]:SetShow(true)
    STATIC_INPUT_TITLE_UI[ii]:SetPosY(titleStaticPosY)
    BUTTON_KEY_UI[ii]:SetPosY(keyButtonPosY)
    BUTTON_PAD_UI[ii]:SetPosY(padButtonPosY)
    BUTTON_KEY_UI[ii]:addInputEvent("Mouse_LUp", "KeyCustom_UI_ButtonPushed_Key(" .. ii .. ")")
    BUTTON_KEY_UI[ii]:addInputEvent("Mouse_UpScroll", "KeyCustom_Ui_Scroll( true )")
    BUTTON_KEY_UI[ii]:addInputEvent("Mouse_DownScroll", "KeyCustom_Ui_Scroll( false )")
    BUTTON_PAD_UI[ii]:addInputEvent("Mouse_LUp", "KeyCustom_UI_ButtonPushed_Pad(" .. ii .. ")")
    BUTTON_PAD_UI[ii]:addInputEvent("Mouse_UpScroll", "KeyCustom_Ui_Scroll( true )")
    BUTTON_PAD_UI[ii]:addInputEvent("Mouse_DownScroll", "KeyCustom_Ui_Scroll( false )")
    titleStaticPosY = titleStaticPosY + adderPosY
    keyButtonPosY = keyButtonPosY + adderPosY
    padButtonPosY = padButtonPosY + adderPosY
  end
  for index = INPUT_COUNT_START_UI, INPUT_COUNT_END_UI do
    local titleString = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Ui_" .. index)
    setKeyConfigData_UITitle(index, titleString)
  end
  controls.sample_staticInputTitle:SetShow(false)
  controls.sample_keyButton:SetShow(false)
  controls.sample_padButton:SetShow(false)
  updateKeyConfig_UI()
  controls.scrollbarBtn = UI.getChildControl(controls.scrollbar, "Scroll_CtrlButton")
  controls.scrollbar:addInputEvent("Mouse_LPress", "KeyCustom_OnSlider()")
  controls.scrollbarBtn:addInputEvent("Mouse_LPress", "KeyCustom_OnButton()")
  Panel_KeyCustom_Ui:addInputEvent("Mouse_UpScroll", "KeyCustom_Ui_Scroll( true )")
  Panel_KeyCustom_Ui:addInputEvent("Mouse_DownScroll", "KeyCustom_Ui_Scroll( false )")
  controls.scrollbarBtn:SetSize(controls.scrollbarBtn:GetSizeX(), controls.scrollbar:GetSizeY() / (INPUT_COUNT_END_UI - keyConfigListShowCount_UI))
end
local function registEventHandler()
  controls.confirm:addInputEvent("Mouse_LUp", "KeyCustom_Ui_Confirm()")
  controls.cancel:addInputEvent("Mouse_LUp", "KeyCustom_Ui_Cancel()")
  controls.apply:addInputEvent("Mouse_LUp", "KeyCustom_Ui_Apply()")
end
function KeyCustom_Ui_Show()
  Panel_KeyCustom_Ui:SetShow(true)
  keyCustom_StartEdit()
  KeyCustom_Ui_UpdateButtonText_Key()
  KeyCustom_Ui_UpdateButtonText_Pad()
end
function KeyCustom_Ui_Close()
  Panel_KeyCustom_Ui:SetShow(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function KeyCustom_Ui_UpdateButtonText_Key()
  for ii = INPUT_COUNT_START_UI, INPUT_COUNT_END_UI do
    setKeyConfigData_UIConfigButton(ii, keyCustom_GetString_UiKey(ii))
  end
  updateKeyConfig_UI()
end
function KeyCustom_Ui_UpdateButtonText_Pad()
  for ii = INPUT_COUNT_START_UI, INPUT_COUNT_END_UI do
    setKeyConfigData_UIConfigPad(ii, keyCustom_GetString_UiPad(ii))
  end
  updateKeyConfig_UI()
end
function KeyCustom_Ui_GetInputType()
  return INPUT_TYPE_UI
end
function KeyCustom_Ui_Confirm()
  keyCustom_applyChange()
  KeyCustom_Ui_Close()
end
function KeyCustom_Ui_Cancel()
  keyCustom_RollBack()
  KeyCustom_Ui_Close()
end
function KeyCustom_Ui_Apply()
  KeyCustom_Ui_Close()
end
function KeyCustom_UI_ButtonPushed_Key(inputTypeIndex)
  local inputType = configDataIndex_UI + inputTypeIndex
  INPUT_TYPE_UI = inputType
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_UiKey)
end
function KeyCustom_UI_ButtonPushed_Pad(inputTypeIndex)
  local inputType = configDataIndex_UI + inputTypeIndex
  INPUT_TYPE_UI = inputType
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_UiPad)
end
function KeyCustom_Ui_Scroll(isUp)
  if isUp then
    configDataIndex_UI = configDataIndex_UI - 1
  else
    configDataIndex_UI = configDataIndex_UI + 1
  end
  configDataIndex_UI = math.min(math.max(configDataIndex_UI, 0), INPUT_COUNT_END_UI - keyConfigListShowCount_UI)
  controls.scrollbar:SetControlPos(configDataIndex_UI / (INPUT_COUNT_END_UI - keyConfigListShowCount_UI))
  updateKeyConfig_UI()
end
Panel_KeyCustom_Ui:SetShow(false, false)
Panel_KeyCustom_Ui:ActiveMouseEventEffect(true)
Panel_KeyCustom_Ui:setGlassBackground(true)
init()
registEventHandler()
