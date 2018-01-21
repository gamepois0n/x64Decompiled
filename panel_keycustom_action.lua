local INPUT_COUNT_START = 0
local INPUT_COUNT_END = 29
local STATIC_INPUT_TITLE = {}
local BUTTON_KEY = {}
local BUTTON_PAD = {}
local INPUT_TYPE
local controls = {
  title = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_Title"),
  subtitle1 = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_Keyboard"),
  subtitle2 = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_Gamepad"),
  BG = UI.getChildControl(Panel_KeyCustom_Action, "Static_BG"),
  confirm = UI.getChildControl(Panel_KeyCustom_Action, "Button_Confirm"),
  cancel = UI.getChildControl(Panel_KeyCustom_Action, "Button_Cancel"),
  apply = UI.getChildControl(Panel_KeyCustom_Action, "Button_Apply"),
  scrollbar = UI.getChildControl(Panel_KeyCustom_Action, "Scroll_Vertical"),
  scrollbarBtn = nil,
  staticInputTitle_Func1 = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_PadFunc1"),
  staticInputTitle_Func2 = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_PadFunc2"),
  button_key = UI.getChildControl(Panel_KeyCustom_Action, "Button_Key"),
  button_Pad_Func1 = UI.getChildControl(Panel_KeyCustom_Action, "Button_PadFunc1"),
  button_Pad_Func2 = UI.getChildControl(Panel_KeyCustom_Action, "Button_PadFunc2"),
  sample_staticInputTitle = UI.getChildControl(Panel_KeyCustom_Action, "StaticText_PadFunc2"),
  sample_keyButton = UI.getChildControl(Panel_KeyCustom_Action, "Button_Key"),
  sample_padButton = UI.getChildControl(Panel_KeyCustom_Action, "Button_PadFunc2")
}
local keyConfigListShowCount = 10
local configDataIndex = 0
local keyConfigData = {}
local function getKeyConfigData(index)
  return keyConfigData[configDataIndex + index - 2]
end
local function setKeyConfigDataTitle(index, title)
  keyConfigData[index] = {
    titleText = title,
    buttonKeyText = "",
    padKeyText = "",
    padOnly = false
  }
end
local function setKeyConfigDataConfigButton(index, button)
  keyConfigData[index].buttonKeyText = button
end
local function setKeyConfigDataConfigPad(index, pad)
  keyConfigData[index].padKeyText = pad
end
local function setKeyConfigDataConfigOnlyPad(index, padOnly)
  keyConfigData[index].padOnly = padOnly
end
local function updateKeyConfig()
  for index = 0, keyConfigListShowCount - 1 do
    local keyConfigData = getKeyConfigData(index)
    if nil ~= keyConfigData then
      STATIC_INPUT_TITLE[index]:SetText(keyConfigData.titleText)
      if false == keyConfigData.padOnly then
        BUTTON_KEY[index]:SetText(keyConfigData.buttonKeyText)
        BUTTON_KEY[index]:SetShow(true)
      else
        BUTTON_KEY[index]:SetShow(false)
      end
      BUTTON_PAD[index]:SetText(keyConfigData.padKeyText)
    else
      STATIC_INPUT_TITLE[index]:SetText(" ")
      BUTTON_KEY[index]:SetText(" ")
      BUTTON_PAD[index]:SetText(" ")
    end
  end
end
function KeyCustom_OnButton()
  local volume = controls.scrollbarBtn:GetPosY() / (controls.scrollbar:GetSizeY() - controls.scrollbarBtn:GetSizeY())
  configDataIndex = math.floor((INPUT_COUNT_END - keyConfigListShowCount + 1) * volume)
  updateKeyConfig()
end
function KeyCustom_OnSlider()
  local volume = controls.scrollbar:GetControlPos()
  configDataIndex = math.floor((INPUT_COUNT_END - keyConfigListShowCount + 1) * volume)
  updateKeyConfig()
end
local function init()
  local adderPosY = 35
  local titleStaticPosY = controls.button_Pad_Func1:GetPosY()
  local keyButtonPosY = controls.button_Pad_Func1:GetPosY()
  local padButtonPosY = controls.button_Pad_Func1:GetPosY()
  for ii = 0, keyConfigListShowCount - 1 do
    STATIC_INPUT_TITLE[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_KeyCustom_Action, "StaticText_InputTitle_" .. tostring(ii))
    BUTTON_KEY[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_BUTTON, Panel_KeyCustom_Action, "Button_Key_" .. tostring(ii))
    BUTTON_PAD[ii] = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_BUTTON, Panel_KeyCustom_Action, "Button_Pad_" .. tostring(ii))
    CopyBaseProperty(controls.staticInputTitle_Func1, STATIC_INPUT_TITLE[ii])
    CopyBaseProperty(controls.button_key, BUTTON_KEY[ii])
    CopyBaseProperty(controls.button_Pad_Func2, BUTTON_PAD[ii])
    STATIC_INPUT_TITLE[ii]:SetIgnore(true)
    STATIC_INPUT_TITLE[ii]:SetShow(true)
    BUTTON_KEY[ii]:SetShow(true)
    BUTTON_PAD[ii]:SetShow(true)
    STATIC_INPUT_TITLE[ii]:SetPosY(titleStaticPosY)
    BUTTON_KEY[ii]:SetPosY(keyButtonPosY)
    BUTTON_PAD[ii]:SetPosY(padButtonPosY)
    BUTTON_KEY[ii]:addInputEvent("Mouse_LUp", "KeyCustom_Action_ButtonPushed_Key(" .. ii .. ")")
    BUTTON_KEY[ii]:addInputEvent("Mouse_UpScroll", "KeyCustom_Action_Scroll( true )")
    BUTTON_KEY[ii]:addInputEvent("Mouse_DownScroll", "KeyCustom_Action_Scroll( false )")
    BUTTON_PAD[ii]:addInputEvent("Mouse_LUp", "KeyCustom_Action_ButtonPushed_Pad(" .. ii .. ")")
    BUTTON_PAD[ii]:addInputEvent("Mouse_UpScroll", "KeyCustom_Action_Scroll( true )")
    BUTTON_PAD[ii]:addInputEvent("Mouse_DownScroll", "KeyCustom_Action_Scroll( false )")
    titleStaticPosY = titleStaticPosY + adderPosY
    keyButtonPosY = keyButtonPosY + adderPosY
    padButtonPosY = padButtonPosY + adderPosY
  end
  for index = INPUT_COUNT_START, INPUT_COUNT_END do
    local titleString = PAGetString(Defines.StringSheet_GAME, "Lua_KeyCustom_Action_" .. index)
    setKeyConfigDataTitle(index, titleString)
  end
  setKeyConfigDataTitle(-2, controls.staticInputTitle_Func1:GetText())
  setKeyConfigDataTitle(-1, controls.staticInputTitle_Func2:GetText())
  setKeyConfigDataConfigOnlyPad(-2, true)
  setKeyConfigDataConfigOnlyPad(-1, true)
  controls.button_key:SetShow(false)
  controls.button_Pad_Func2:SetShow(false)
  controls.staticInputTitle_Func1:SetShow(false)
  controls.staticInputTitle_Func2:SetShow(false)
  controls.button_Pad_Func1:SetShow(false)
  controls.button_Pad_Func2:SetShow(false)
  updateKeyConfig()
  controls.scrollbarBtn = UI.getChildControl(controls.scrollbar, "Scroll_CtrlButton")
  controls.scrollbar:addInputEvent("Mouse_LPress", "KeyCustom_OnSlider()")
  controls.scrollbarBtn:addInputEvent("Mouse_LPress", "KeyCustom_OnButton()")
  Panel_KeyCustom_Action:addInputEvent("Mouse_UpScroll", "KeyCustom_Action_Scroll( true )")
  Panel_KeyCustom_Action:addInputEvent("Mouse_DownScroll", "KeyCustom_Action_Scroll( false )")
  controls.scrollbarBtn:SetSize(controls.scrollbarBtn:GetSizeX(), controls.scrollbar:GetSizeY() / (INPUT_COUNT_END - keyConfigListShowCount))
end
local function registEventHandler()
  controls.confirm:addInputEvent("Mouse_LUp", "KeyCustom_Action_Confirm()")
  controls.cancel:addInputEvent("Mouse_LUp", "KeyCustom_Action_Cancel()")
  controls.apply:addInputEvent("Mouse_LUp", "KeyCustom_Action_Apply()")
end
function KeyCustom_Action_Show()
  Panel_KeyCustom_Action:SetShow(true)
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_Wait)
  keyCustom_StartEdit()
  KeyCustom_Action_UpdateButtonText_Key()
  KeyCustom_Action_UpdateButtonText_Pad()
  configDataIndex = 0
  controls.scrollbar:SetControlPos(0)
  updateKeyConfig()
end
function KeyCustom_Action_Close()
  Panel_KeyCustom_Action:SetShow(false)
  SetUIMode(Defines.UIMode.eUIMode_Default)
end
function KeyCustom_Action_UpdateButtonText_Key()
  for ii = INPUT_COUNT_START, INPUT_COUNT_END do
    setKeyConfigDataConfigButton(ii, keyCustom_GetString_ActionKey(ii))
  end
  updateKeyConfig()
end
function KeyCustom_Action_UpdateButtonText_Pad()
  keyConfigData[-2].padKeyText = keyCustom_GetString_ActionPadFunc1()
  keyConfigData[-1].padKeyText = keyCustom_GetString_ActionPadFunc2()
  for ii = INPUT_COUNT_START, INPUT_COUNT_END do
    setKeyConfigDataConfigPad(ii, keyCustom_GetString_ActionPad(ii))
  end
  updateKeyConfig()
end
function KeyCustom_Action_GetInputType()
  return INPUT_TYPE
end
function KeyCustom_Action_Confirm()
  keyCustom_applyChange()
  KeyCustom_Action_Close()
end
function KeyCustom_Action_Cancel()
  keyCustom_RollBack()
  KeyCustom_Action_Close()
end
function KeyCustom_Action_Apply()
  KeyCustom_Action_Close()
end
function KeyCustom_Action_ButtonPushed_Key(inputTypeIndex)
  local inputType = configDataIndex + inputTypeIndex - 2
  if inputType >= 0 then
    INPUT_TYPE = inputType
    SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionKey)
  else
  end
end
function KeyCustom_Action_ButtonPushed_Pad(inputTypeIndex)
  local inputType = configDataIndex + inputTypeIndex - 2
  if inputType >= 0 then
    INPUT_TYPE = inputType
    SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPad)
  elseif -1 == inputType then
    KeyCustom_Action_ButtonPushed_PadFunc2()
  else
    KeyCustom_Action_ButtonPushed_PadFunc1()
  end
end
function KeyCustom_Action_ButtonPushed_PadFunc1()
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPadFunc1)
end
function KeyCustom_Action_ButtonPushed_PadFunc2()
  SetUIMode(Defines.UIMode.eUIMode_KeyCustom_ActionPadFunc2)
end
function KeyCustom_Action_Scroll(isUp)
  if isUp then
    configDataIndex = configDataIndex - 1
  else
    configDataIndex = configDataIndex + 1
  end
  configDataIndex = math.min(math.max(configDataIndex, 0), INPUT_COUNT_END - keyConfigListShowCount + 2)
  controls.scrollbar:SetControlPos(configDataIndex / (INPUT_COUNT_END - keyConfigListShowCount + 2))
  updateKeyConfig()
end
Panel_KeyCustom_Action:SetShow(false, false)
Panel_KeyCustom_Action:ActiveMouseEventEffect(true)
Panel_KeyCustom_Action:setGlassBackground(true)
init()
registEventHandler()
