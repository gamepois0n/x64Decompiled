local UI_color = Defines.Color
local UI_TM = CppEnums.TextMode
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local ePcWorkingType = CppEnums.PcWorkType
local UI_Class = CppEnums.ClassType
local const_64 = Defines.s64_const
local UCT_BUTTON = CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_BUTTON
local UCT_RADIOBUTTON = CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_RADIOBUTTON
local UCT_STATICTEXT = CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT
local UCT_STATIC = CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATIC
local isAwakenOpen = {
  [UI_Class.ClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
  [UI_Class.ClassType_Ranger] = ToClient_IsContentsGroupOpen("902"),
  [UI_Class.ClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
  [UI_Class.ClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
  [UI_Class.ClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
  [UI_Class.ClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
  [UI_Class.ClassType_BladeMasterWomen] = ToClient_IsContentsGroupOpen("907"),
  [UI_Class.ClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
  [UI_Class.ClassType_Wizard] = ToClient_IsContentsGroupOpen("909"),
  [UI_Class.ClassType_WizardWomen] = ToClient_IsContentsGroupOpen("910"),
  [UI_Class.ClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
  [UI_Class.ClassType_NinjaWomen] = ToClient_IsContentsGroupOpen("912"),
  [UI_Class.ClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
  [UI_Class.ClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
  [UI_Class.ClassType_CombattantWomen] = ToClient_IsContentsGroupOpen("918"),
  [UI_Class.ClassType_Lahn] = ToClient_IsContentsGroupOpen("916"),
  [UI_Class.ClassType_Temp1] = false,
  [UI_Class.ClassType_Temp2] = false,
  [UI_Class.ClassType_ShyWomen] = false,
  [UI_Class.ClassType_Shy] = false,
  [UI_Class.ClassType_Temp] = false
}
Panel_CharacterSelect:SetShow(false, false)
local CCSC_Frame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_CharacterSelect")
local _frameContents = UI.getChildControl(CCSC_Frame, "Frame_1_Content")
local _frameScroll = UI.getChildControl(CCSC_Frame, "Frame_1_VerticalScroll")
local bottomFrame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_BottomDesc")
local _frameBottomDesc = UI.getChildControl(bottomFrame, "Frame_1_Content")
local Panel_Lobby_ClassUI = {
  ClassButtons = {},
  ClassNames = {},
  ClassStatus = {}
}
local txt_BottomDesc = UI.getChildControl(_frameBottomDesc, "StaticText_Desc")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Warrior] = UI.getChildControl(_frameContents, "RadioButton_Select_Warrior")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Ranger] = UI.getChildControl(_frameContents, "RadioButton_Select_Ranger")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Sorcerer] = UI.getChildControl(_frameContents, "RadioButton_Select_Sorcer")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Giant] = UI.getChildControl(_frameContents, "RadioButton_Select_Giant")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Tamer] = UI.getChildControl(_frameContents, "RadioButton_Select_Tamer")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_BladeMaster] = UI.getChildControl(_frameContents, "RadioButton_Select_BladeMaster")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_BladeMasterWomen] = UI.getChildControl(_frameContents, "RadioButton_Select_BladeMasterWomen")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Valkyrie] = UI.getChildControl(_frameContents, "RadioButton_Select_Valkyrie")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Wizard] = UI.getChildControl(_frameContents, "RadioButton_Select_Wizard")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_WizardWomen] = UI.getChildControl(_frameContents, "RadioButton_Select_WizardWomen")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_NinjaWomen] = UI.getChildControl(_frameContents, "RadioButton_Select_NinjaWomen")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_NinjaMan] = UI.getChildControl(_frameContents, "RadioButton_Select_Kunoichi")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_ShyWomen] = UI.getChildControl(_frameContents, "RadioButton_Select_ShyWomen")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Shy] = UI.getChildControl(_frameContents, "RadioButton_Select_Shy")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Temp] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_DarkElf] = UI.getChildControl(_frameContents, "RadioButton_Select_DarkElf")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Temp1] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp1")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Temp2] = UI.getChildControl(_frameContents, "RadioButton_Select_Temp2")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Lahn] = UI.getChildControl(_frameContents, "RadioButton_Select_Angle")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_Combattant] = UI.getChildControl(_frameContents, "RadioButton_Select_Combattant")
Panel_Lobby_ClassUI.ClassButtons[UI_Class.ClassType_CombattantWomen] = UI.getChildControl(_frameContents, "RadioButton_Select_CombattantWomen")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Warrior] = UI.getChildControl(_frameContents, "StaticText_WarriorName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Ranger] = UI.getChildControl(_frameContents, "StaticText_RangerName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Sorcerer] = UI.getChildControl(_frameContents, "StaticText_SorcerName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Giant] = UI.getChildControl(_frameContents, "StaticText_GiantName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Tamer] = UI.getChildControl(_frameContents, "StaticText_TamerName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMaster] = UI.getChildControl(_frameContents, "StaticText_BladeMasterName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMasterWomen] = UI.getChildControl(_frameContents, "StaticText_BladeMasterWomenName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Valkyrie] = UI.getChildControl(_frameContents, "StaticText_ValkyrieName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Wizard] = UI.getChildControl(_frameContents, "StaticText_WizardName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_WizardWomen] = UI.getChildControl(_frameContents, "StaticText_WizardWomenName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaWomen] = UI.getChildControl(_frameContents, "StaticText_NinjaWomenName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaMan] = UI.getChildControl(_frameContents, "StaticText_KunoichiName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_ShyWomen] = UI.getChildControl(_frameContents, "StaticText_ShyWomenName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Shy] = UI.getChildControl(_frameContents, "StaticText_ShyName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp] = UI.getChildControl(_frameContents, "StaticText_TempName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_DarkElf] = UI.getChildControl(_frameContents, "StaticText_DarkElfName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp1] = UI.getChildControl(_frameContents, "StaticText_Temp1Name")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp2] = UI.getChildControl(_frameContents, "StaticText_Temp2Name")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Lahn] = UI.getChildControl(_frameContents, "StaticText_AngleName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Combattant] = UI.getChildControl(_frameContents, "StaticText_CombattantName")
Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_CombattantWomen] = UI.getChildControl(_frameContents, "StaticText_CombattantWomenName")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Warrior] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Warrior")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Ranger] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Ranger")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Sorcerer] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Sorcerer")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Giant] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Giant")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Tamer] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BeastMaster")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_BladeMaster] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BladerMaster")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_BladeMasterWomen] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_BladerMasterWomen")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Valkyrie] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Valkyrie")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Wizard] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Wizard")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_WizardWomen] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Wizard")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_NinjaWomen] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_NinjaMan] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_ShyWomen] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Shy] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_NinjaWomen")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Temp] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_DarkElf] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_DarkElf")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Combattant] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Striker")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Temp1] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp1")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Temp2] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp2")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_Lahn] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Angle")
Panel_Lobby_ClassUI.ClassStatus[UI_Class.ClassType_CombattantWomen] = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Temp5")
local Panel_Lobby_UI = {
  CC_CharacterCreateText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CharacterCreate"),
  CC_CharacterNameEdit = UI.getChildControl(Panel_CharacterCreate, "Edit_CharacterName"),
  CC_CreateButton = UI.getChildControl(Panel_CharacterCreate, "Button_CharacterCreateStart"),
  CC_BackButton = UI.getChildControl(Panel_CharacterCreate, "Button_Back"),
  CC_DumiText1 = UI.getChildControl(Panel_CharacterCreate, "StaticText_1"),
  CC_characterCreateBG = UI.getChildControl(Panel_CharacterCreate, "Static_BG"),
  CC_DumiText3 = UI.getChildControl(Panel_CharacterCreate, "StaticText_3"),
  CC_DumiText4 = UI.getChildControl(Panel_CharacterCreate, "StaticText_4"),
  CC_FrameHead = UI.getChildControl(Panel_CharacterCreate, "Frame_Head"),
  CC_FrameHead_Content = nil,
  CC_FrameHead_Content_Image = nil,
  CC_FrameHead_Scroll = nil,
  CC_FrameHair = UI.getChildControl(Panel_CharacterCreate, "Frame_Hair"),
  CC_FrameHair_Content = nil,
  CC_FrameHair_Content_Image = nil,
  CC_FrameHair_Scroll = nil,
  CC_SelectClassButton = UI.getChildControl(Panel_CharacterCreate, "Button_SelectClass"),
  CC_CBTText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CBT"),
  CCSC_CreateTitle = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Title"),
  CCSC_ClassName = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_ClassName"),
  CCSC_PartLine = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_PartLine"),
  CCSC_ClassDescBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Desc_BG"),
  CCSC_ClassDesc = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Description"),
  CCSC_CreateButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_CharacterCreateStart"),
  CCSC_CreateBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_BG"),
  CCSC_RadioNormalMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Normal"),
  CCSC_RadioAwakenMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Awaken"),
  CCSC_ClassMovie = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_CharacterCreateSelectClass, "Static_ClassMovie"),
  CCSC_BackButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_Back"),
  CCSC_SelectClassButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_SelectClass"),
  CCSC_NoMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_NoMovie"),
  CM_StaticText_CharacterName = UI.getChildControl(Panel_CustomizationMain, "StaticText_CharacterName"),
  CM_Edit_CharacterName = UI.getChildControl(Panel_CustomizationMain, "Edit_CharacterName")
}
local Character_Status = {
  _stat_Ctrl = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Ctrl"),
  _stat_Att = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Att"),
  _stat_Def = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Def"),
  _stat_Evd = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Evd"),
  _stat_Cmb = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Cmb")
}
local Panel_Lobby_Global_Variable = {
  UIList = {},
  UiMaker = nil,
  characterSelect = -1,
  notClearValueCharacterSelect = -1,
  characterSelectType = -1,
  selectRegionInfo = nil,
  isWaitLine = false,
  selectCharacterLevel = -1
}
local Panel_Lobby_Enum = {
  eRotate_Left = 0,
  eRotate_Right = 1,
  eDistance_Far = 2,
  eDistance_Near = 3,
  eArrow_Up = 4,
  eArrow_Down = 5,
  eArrow_Left = 6,
  eArrow_Right = 7,
  eCharacterCustomization_HeadMesh = 0,
  eCharacterCustomization_HairMesh = 1
}
local sortCharacterCount = 1
local columnCountByRaw = 4
local columnCount = 0
local rowCount = 0
local classNameStartX = 18
local classNameStartY = 120
local classNameGapX = 17
local classNameGapY = 130
local classButtonStartX = 15
local classButtonGapX = 10
local classButtonGapY = 5
local _CharInfo_BG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_BG")
_CharInfo_BG:setGlassBackground(false)
local Panel_CharacterDoing = {
  _CharInfo_Name = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Name"),
  _CharInfo_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_GaugeBG"),
  _CharInfo_Gauge = UI.getChildControl(Panel_CharacterSelect, "Progress2_CharInfo_Gauge"),
  _CharInfo_DoText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Do"),
  _CharInfo_NowPos = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_NowPos"),
  _CharInfo_WhereText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Where"),
  _ticketNoByRegion = UI.getChildControl(Panel_CharacterSelect, "StaticText_TicketNoByRegion")
}
local characterSelect_DoWork = {
  _doWork_BG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_BG"),
  _doWork_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_GaugeBG"),
  _doWork_Gauge = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Gauge"),
  _doWork_Icon = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Icon")
}
local Panel_Customization = {
  group = {}
}
local Panel_Lobby_LDownCheck_ViewControl = {}
local _headContentImage = {}
local _hairContentImage = {}
local characterTicketAbleUI = {}
local isSpecialCharacter = false
function FGlobal_SetSpecialCharacter(isSC)
  isSpecialCharacter = isSC
end
function FGlobal_getIsSpecialCharacter()
  return isSpecialCharacter
end
local function Panel_Lobby_Function_Initialize()
  UI.ASSERT(nil ~= Panel_CharacterCreateSelectClass, "createCharacter_SelectClass\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassName, "CCSC_ClassName\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_PartLine, "CCSC_PartLine\t\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDescBG, "CCSC_ClassDescBG\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDesc, "CCSC_ClassDesc\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_CreateButton, "CCSC_CreateButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassMovie, "CCSC_ClassMovie\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_BackButton, "CCSC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_SelectClassButton, "CCSC_SelectClassButton\t\tnil")
  UI.ASSERT(nil ~= Panel_CharacterCreate, "createCharacter\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterCreateText, "CC_CharacterCreateText\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterNameEdit, "CC_CharacterNameEdit\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CreateButton, "CC_CreateButton\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_BackButton, "CC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_SelectClassButton, "CC_SelectClassButton\t\tnil")
  if isGameServiceTypeKor() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  elseif isGameServiceTypeDev() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  else
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(30)
  end
  Panel_Lobby_UI.CC_FrameHead_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Content")
  Panel_Lobby_UI.CC_FrameHead_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead_Content, "Frame_Head_Content_Image")
  Panel_Lobby_UI.CC_FrameHead_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Scroll")
  Panel_Lobby_UI.CC_FrameHair_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Content")
  Panel_Lobby_UI.CC_FrameHair_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair_Content, "Frame_Hair_Content_Image")
  Panel_Lobby_UI.CC_FrameHair_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Scroll")
  Panel_CharacterCreate:SetShow(false, false)
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  Panel_Lobby_UI.CCSC_CreateBG:SetSize(450, getScreenSizeY())
  Panel_Lobby_UI.CC_characterCreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_CreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_ClassName:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_PartLine:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDescBG:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDesc:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_CreateButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode()")
  Panel_Lobby_UI.CCSC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  Panel_Lobby_UI.CCSC_SelectClassButton:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Warrior]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Ranger]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Sorcerer]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Giant]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Tamer]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMaster]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMasterWomen]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Valkyrie]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Wizard]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_WizardWomen]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaWomen]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaMan]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_ShyWomen]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Shy]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_DarkElf]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Combattant]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp1]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp2]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_CombattantWomen]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Lahn]:SetTextMode(UI_TM.eTextMode_AutoWrap)
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Warrior]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WARRIOR"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Ranger]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_RANGER"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Sorcerer]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_SOCERER"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Giant]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_GIANT"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Tamer]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_TAMER"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMaster]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_BLADERMASTER"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_BladeMasterWomen]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_BLADERMASTERWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Valkyrie]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_VALKYRIE"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Wizard]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WIZARD"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_WizardWomen]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_WIZARDWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaWomen]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_KUNOICHI"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_NinjaMan]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_NINJA"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_ShyWomen]:SetText("\236\131\164\236\157\180 \236\151\172\236\158\144")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Shy]:SetText("\236\131\164\236\157\180 \235\130\168\236\158\144")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp]:SetText("\236\158\132\236\139\156")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_DarkElf]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_DARKELF"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Combattant]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE_SELECTCLASS_STRIKER"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp1]:SetText("\236\158\132\236\139\1561")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Temp2]:SetText("\236\158\132\236\139\1562")
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_CombattantWomen]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_COMBATTANTWOMEN"))
  Panel_Lobby_ClassUI.ClassNames[UI_Class.ClassType_Lahn]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_CLASSTYPE_RAN"))
  for index = 0, UI_Class.ClassType_Count - 1 do
    if Panel_Lobby_ClassUI.ClassButtons[index] ~= nil then
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_LUp", "Panel_Lobby_function_SelectClassType(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_On", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_Out", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", false)")
    end
  end
  local count = getPossibleClassCount()
  for index = 0, count - 1 do
    local classType = getPossibleClassTypeFromIndex(index)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
    local className = Panel_Lobby_ClassUI.ClassNames[classType]
    if classButton ~= nil and classButton:GetShow() then
      classButton:SetPosX(classButtonStartX + classButton:GetPosX() + (classButton:GetSizeX() + classButtonGapX) * columnCount)
      classButton:SetPosY(classButton:GetPosY() + (classButton:GetSizeY() + classButtonGapY) * rowCount)
      className:SetPosX(classNameStartX + className:GetPosX() + (className:GetSizeX() + classNameGapX) * columnCount)
      className:SetPosY(classButton:GetPosY() + classButton:GetSizeY() - className:GetTextSizeY() - 10)
      if 0 == sortCharacterCount % columnCountByRaw then
        columnCount = 0
        rowCount = rowCount + 1
      else
        columnCount = columnCount + 1
      end
      sortCharacterCount = sortCharacterCount + 1
      className:SetSize(88, Panel_Lobby_ClassUI.ClassNames[classType]:GetTextSizeY() + 5)
    end
  end
  Panel_Lobby_UI.CC_SelectClassButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode_SelectClass()")
  Panel_Lobby_UI.CC_CreateButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateOk()")
  Panel_Lobby_UI.CC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Lobby_UI.CCSC_ClassMovie:SetPosX(scrX - 441)
  Panel_Lobby_UI.CCSC_ClassMovie:SetPosY(scrY - 372)
  Panel_Lobby_UI.CCSC_ClassMovie:SetUrl(422, 237, "coui://UI_Data/UI_Html/Class_Movie.html")
  Panel_Lobby_UI.CCSC_ClassMovie:SetSize(422, 237)
  Panel_Lobby_UI.CCSC_ClassMovie:SetSpanSize(-1, 0)
  Panel_Lobby_UI.CCSC_ClassMovie:SetShow(true)
  local checkAgeType = ToClient_isAdultUser()
  if checkAgeType then
    Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(false)
  else
    Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(true)
  end
  Panel_Lobby_UI.CCSC_NoMovie:SetPosX(scrX - 441)
  Panel_Lobby_UI.CCSC_NoMovie:SetPosY(scrY - 372)
  Panel_Lobby_UI.CCSC_NoMovie:SetSpanSize(-1, 0)
  Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
  Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 0 .. ")")
  Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 1 .. ")")
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
end
local function Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_Lobby_function_SelectClassType(UI_Class.ClassType_Warrior)
  Panel_Lobby_Global_Variable.UiMaker = Panel_CharacterCreateSelectClass
  Panel_Lobby_Global_Variable.UiMaker:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeX(), getScreenSizeY())
  _frameContents:ComputePos()
  for _, value in pairs(Character_Status) do
    value:ComputePos()
  end
  for _, value in pairs(Panel_Lobby_UI) do
    value:ComputePos()
  end
  bottomFrame:ComputePos()
  bottomFrame:GetVScroll():SetControlTop()
  bottomFrame:UpdateContentPos()
  bottomFrame:UpdateContentScroll()
  CCSC_Frame:ComputePos()
  CCSC_Frame:GetVScroll():SetControlTop()
  CCSC_Frame:UpdateContentPos()
  CCSC_Frame:UpdateContentScroll()
  local scrSizeY = getScreenSizeY()
  local sumSizeY = scrSizeY - (Panel_Lobby_UI.CCSC_ClassName:GetSizeY() + Panel_Lobby_UI.CCSC_ClassMovie:GetSizeY() + Panel_Lobby_UI.CCSC_ClassDescBG:GetSizeY() + 112)
  CCSC_Frame:SetSize(_frameContents:GetSizeX(), sumSizeY)
  if sumSizeY < _frameContents:GetSizeY() then
    _frameScroll:SetShow(true)
  else
    _frameScroll:SetShow(false)
  end
  Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosX(CCSC_Frame:GetPosX() + 17)
  Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosX(Panel_Lobby_UI.CCSC_RadioNormalMovie:GetPosX() + Panel_Lobby_UI.CCSC_RadioNormalMovie:GetSizeX() + 5)
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
  for classIndex = 0, UI_Class.ClassType_Count - 1 do
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    local classStatus = Panel_Lobby_ClassUI.ClassStatus[classIndex]
    if classButton ~= nil then
      classButton:SetShow(false)
      classButton:ComputePos()
    end
    if className ~= nil then
      className:SetShow(false)
      className:ComputePos()
    end
    if classStatus ~= nil then
      classStatus:ComputePos()
    end
  end
  local function ClassBtn_Show(classIndex)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    if classButton ~= nil then
      classButton:SetShow(true)
    end
    if className ~= nil then
      className:SetShow(true)
    end
  end
  local count = getPossibleClassCount()
  for index = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(index)
    ClassBtn_Show(classType)
  end
end
function Panel_Lobby_Function_showCharacterCreate_SelectClass()
  FGlobal_CharacterSelect_Close()
  Panel_Lobby_function_DeleteButton()
  Panel_Lobby_function_ClearData()
  Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_CharacterCreate:SetShow(false, false)
  Panel_Customization_Control:SetShow(false, false)
  Panel_CustomizationMotion:SetShow(false, false)
  Panel_CustomizationExpression:SetShow(false, false)
  Panel_CustomizationCloth:SetShow(false, false)
  Panel_CustomizationTest:SetShow(false, false)
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  Panel_CustomizationMesh:SetShow(false, false)
  Panel_CustomizationMain:SetShow(false, false)
  Panel_CustomizationStatic:SetShow(false, false)
  Panel_CustomizationMessage:SetShow(false, false)
  Panel_CustomizationFrame:SetShow(false, false)
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeY(), getScreenSizeX())
end
function Panel_Lobby_Function_showCharacterCustomization(customizationData)
  Panel_Lobby_function_DeleteButton()
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  Panel_Lobby_UI.CM_Edit_CharacterName:SetEditText("")
  resizeUIScale()
  ShowCharacterCustomization(customizationData, Panel_Lobby_Global_Variable.characterSelectType, false)
  viewCharacterCreateMode(Panel_Lobby_Global_Variable.characterSelectType)
end
function Panel_Lobby_function_ClearData()
  Panel_Lobby_Global_Variable.characterSelect = -1
  Panel_Lobby_Global_Variable.characterSelectType = -1
  Panel_Lobby_Global_Variable.selectRegionInfo = nil
end
local _index
function Panel_Lobby_function_SelectClassType(index, isOn)
  if index < UI_Class.ClassType_Count then
    if false == ToClient_checkCreatePossibleClass(index, isSpecialCharacter) then
      return
    end
    for key, value in pairs(Panel_Lobby_ClassUI.ClassButtons) do
      value:SetMonoTone(true)
      value:SetVertexAniRun("Ani_Color_Reset", true)
      value:EraseAllEffect()
    end
    Panel_Lobby_ClassUI.ClassButtons[index]:SetMonoTone(false)
    Panel_Lobby_ClassUI.ClassButtons[index]:AddEffect("UI_CharactorSelcect_Line", true, 10, 4)
    local movieName = getClassMovie(index, isSpecialCharacter)
    if movieName ~= nil then
      Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
    end
    Panel_Lobby_UI.CCSC_RadioNormalMovie:SetCheck(true)
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(isAwakenOpen[index])
    _index = index
    viewCharacterCreateSelectClassMode(index)
    Panel_Lobby_Global_Variable.characterSelectType = index
    Panel_Lobby_UI.CCSC_ClassName:SetText(getClassName(index, isSpecialCharacter))
    Panel_Lobby_UI.CCSC_ClassDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
    Panel_Lobby_UI.CCSC_ClassDesc:SetText(getClassDescription(index, isSpecialCharacter))
    Panel_Lobby_UI.CCSC_ClassDesc:SetShow(false)
    txt_BottomDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
    txt_BottomDesc:SetText(getClassDescription(index, isSpecialCharacter))
    _frameBottomDesc:SetSize(_frameBottomDesc:GetSizeX(), txt_BottomDesc:GetTextSizeY())
    for _, value in pairs(Panel_Lobby_ClassUI.ClassStatus) do
      value:SetShow(false)
    end
    Panel_Lobby_ClassUI.ClassStatus[index]:SetShow(true)
  end
end
function Panel_Lobby_SetMovie()
  local movieName = getClassMovie(_index, isSpecialCharacter)
  if movieName ~= nil then
    if Panel_Lobby_UI.CCSC_RadioAwakenMovie:IsCheck() then
      movieName = string.gsub(movieName, ".webm", "_A.webm")
    end
    Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
  end
end
function Panel_Lobby_SelectClass_MouseEvent(index, isOn)
  local classButton = Panel_Lobby_ClassUI.ClassButtons[index]
  if classButton ~= nil then
    if isOn == true then
      classButton:SetVertexAniRun("Ani_Color_Bright", true)
    else
      classButton:ResetVertexAni()
    end
  end
end
function Panel_CharacterCreateOk()
  chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, Panel_Lobby_UI.CC_CharacterNameEdit:GetEditText(), isSpecialCharacter)
end
function Panel_CharacterCreateOK_NewCustomization()
  local _edit_CharacterName = Panel_Lobby_UI.CM_Edit_CharacterName:GetEditText()
  local function createCharacterFunc()
    chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, isSpecialCharacter)
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
end
function Panel_CharacterCreateCancel()
  Panel_CharacterCreateSelectClass:SetShow(false)
  characterCreateCancel(FGlobal_getIsSpecialCharacter())
  TooltipSimple_Hide()
end
function Panel_Lobby_function_DeleteButton()
  if nil == Panel_Lobby_Global_Variable.UiMaker then
    return
  end
  for _, value in pairs(Panel_Lobby_Global_Variable.UIList) do
    UI.deleteControl(value)
  end
  Panel_Lobby_Global_Variable.UIList = {}
  Panel_Lobby_Global_Variable.UiMaker = nil
end
function Panel_Lobby_TooltipShow(buttonType)
  local uiControl, name, desc
  if 0 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONDESC")
  elseif 1 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONDESC")
  end
  if nil ~= uiControl then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function Panel_Lobby_TooltipHide()
  TooltipSimple_Hide()
end
Panel_Lobby_Function_Initialize()
registerEvent("EventChangeLobbyStageToCharacterCreate_SelectClass", "Panel_Lobby_Function_showCharacterCreate_SelectClass")
registerEvent("EventCharacterCustomizationInitUi", "Panel_Lobby_Function_showCharacterCustomization")
