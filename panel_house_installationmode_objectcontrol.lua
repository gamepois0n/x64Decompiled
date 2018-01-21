local UI_TM = CppEnums.TextMode
local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_color = Defines.Color
local UI_CIT = CppEnums.InstallationType
local IM = CppEnums.EProcessorInputMode
Panel_House_InstallationMode_ObjectControl:SetShow(false)
local isContentsElephant = ToClient_IsContentsGroupOpen("36")
local isContentsWoodenwall = ToClient_IsContentsGroupOpen("242")
local isContentsSiegeDefenceTower = ToClient_IsContentsGroupOpen("221")
local HouseInstallationControl = {
  btn_Confirm = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Confirm"),
  btn_Rotate_Right = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Rotate_Right"),
  btn_Rotate_Left = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Rotate_Left"),
  btn_Delete = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Delete"),
  btn_Move = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Move"),
  btn_Cancel = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Cancel"),
  btn_Resize = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "Button_Resize"),
  staticText_DetailGuide = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "StaticText_DetailGuide"),
  txt_RotateDesc = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "StaticText_RotateDesc"),
  warCountInstallationCountTitle = UI.getChildControl(Panel_House_WarInformation, "StaticText_ObjectCountTitle"),
  warCountInstallationCount = UI.getChildControl(Panel_House_WarInformation, "StaticText_ObjectCount"),
  warCountInnerObjectTitle = UI.getChildControl(Panel_House_WarInformation, "StaticText_EnalbeSizeTitle"),
  warCountInnerObjectMaxSize = UI.getChildControl(Panel_House_WarInformation, "StaticText_MaxInnerSize"),
  warCountInnerBigTitle_Limit = UI.getChildControl(Panel_House_WarInformation, "StaticText_InnerObjectMaxCountTitle"),
  templateInnerObjectName = UI.getChildControl(Panel_House_WarInformation, "StaticText_InnerObjectName"),
  templateInnerObjectCount = UI.getChildControl(Panel_House_WarInformation, "StaticText_InnerObjectCurrentCount"),
  telplateInnerObjectSize = UI.getChildControl(Panel_House_WarInformation, "StaticText_InnerObjectSize"),
  templateInnerObjectMaxCount = UI.getChildControl(Panel_House_WarInformation, "StaticText_InnerObjectMaxCount")
}
local _txt_btnDesc = UI.getChildControl(Panel_House_InstallationMode_ObjectControl, "StaticText_Desc")
local _isInnterOjbectCount = 13
local innerObjectName = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_HEALINGTOWER"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBSERVATORY"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ELEPHANTBARN"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CATAPULTFACTORY"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_FLAMEFACTORY"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DISTRIBUTOR"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_BARRICADE"),
  [7] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_BARRICADEGATE"),
  [8] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_WOODENFENCE"),
  [9] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DEFFENCETOWER"),
  [10] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_SIEGETOWER"),
  [11] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_LARGESIEGETOWER"),
  [12] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ADVANCEBASETOWER")
}
local innerObjectSize = {
  [0] = 1,
  3,
  5,
  3,
  3,
  5,
  1,
  2,
  1,
  0,
  3,
  5,
  3
}
local innerObjectKind = {
  [0] = 10,
  11,
  12,
  17,
  18,
  19,
  3,
  20,
  21,
  22,
  23,
  24,
  26
}
if isGameTypeSA() then
  _isInnterOjbectCount = 9
  innerObjectName = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_HEALINGTOWER"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBSERVATORY"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CATAPULTFACTORY"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_FLAMEFACTORY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DISTRIBUTOR"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_BARRICADE"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_BARRICADEGATE"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_DEFFENCETOWER"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_ADVANCEBASETOWER")
  }
  innerObjectSize = {
    [0] = 1,
    [1] = 3,
    [2] = 3,
    [3] = 3,
    [4] = 5,
    [5] = 1,
    [6] = 2,
    [7] = 0,
    [8] = 3
  }
  innerObjectKind = {
    [0] = 10,
    [1] = 11,
    [2] = 17,
    [3] = 18,
    [4] = 19,
    [5] = 3,
    [6] = 20,
    [7] = 22,
    [8] = 26
  }
end
local innerObjectCount = _isInnterOjbectCount
local gapY = 20
local basePosY = HouseInstallationControl.templateInnerObjectName:GetPosY()
local innerObject = {}
function InnerObject_ControlInit()
  local temp = {}
  local self = HouseInstallationControl
  for index = 0, innerObjectCount - 1 do
    temp[index] = {}
    innerObject[index] = {}
    temp[index]._name = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_House_WarInformation, "StaticText_InnerObjectName_" .. index)
    CopyBaseProperty(self.templateInnerObjectName, temp[index]._name)
    temp[index]._name:SetPosY(basePosY + gapY * index)
    temp[index]._name:SetText(innerObjectName[index])
    temp[index]._name:SetShow(true)
    temp[index]._count = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_House_WarInformation, "StaticText_InnerObjectCount_" .. index)
    CopyBaseProperty(self.templateInnerObjectCount, temp[index]._count)
    temp[index]._count:SetPosY(basePosY + gapY * index)
    temp[index]._count:SetShow(true)
    temp[index]._size = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_House_WarInformation, "StaticText_InnerObjectSize_" .. index)
    CopyBaseProperty(self.telplateInnerObjectSize, temp[index]._size)
    temp[index]._size:SetPosY(basePosY + gapY * index)
    temp[index]._size:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", innerObjectSize[index]))
    temp[index]._size:SetShow(true)
    temp[index]._maxCount = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_STATICTEXT, Panel_House_WarInformation, "StaticText_InnerObjectMaxCount_" .. index)
    CopyBaseProperty(self.templateInnerObjectMaxCount, temp[index]._maxCount)
    temp[index]._maxCount:SetPosY(basePosY + gapY * index)
    temp[index]._maxCount:SetShow(true)
    innerObject[index] = temp[index]
  end
  self.txt_RotateDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_CART_ROTATE_DESC"))
  Panel_House_WarInformation:SetSize(Panel_House_WarInformation:GetSizeX(), 150 + innerObjectCount * 20)
  self.warCountInnerObjectTitle:ComputePos()
  self.warCountInnerObjectMaxSize:ComputePos()
  self.warCountInstallationCountTitle:ComputePos()
  self.warCountInstallationCount:ComputePos()
end
InnerObject_ControlInit()
function HouseInstallationControl:Initialize()
  self.btn_Confirm:SetShow(false)
  self.btn_Rotate_Right:SetShow(false)
  self.btn_Rotate_Left:SetShow(false)
  self.btn_Delete:SetShow(false)
  self.btn_Move:SetShow(false)
  self.btn_Cancel:SetShow(false)
  self.btn_Resize:SetShow(false)
  self.staticText_DetailGuide:SetShow(false)
end
local HouseInstallationControl_Is_Open = false
local isConfirmStep = false
local typeIsHavest = false
function HouseInstallationControl:Close()
  Panel_House_InstallationMode_ObjectControl:SetShow(false)
  HouseInstallationControl_Is_Open = false
end
function Is_Show_HouseInstallationControl()
  return HouseInstallationControl_Is_Open
end
function Panel_House_ObjectControlDescFunc(isOn, btnType)
  if isOn == true then
    _txt_btnDesc:SetAlpha(0)
    _txt_btnDesc:SetFontAlpha(0)
    _txt_btnDesc:ResetVertexAni()
    local AniInfo = UIAni.AlphaAnimation(1, _txt_btnDesc, 0, 0.2)
    _txt_btnDesc:SetShow(true)
    if btnType == 1 then
      if false == FGlobal_HouseInstallationControl_IsConfirmStep() then
        _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM"))
      else
        _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM") .. "(SpaceBar)")
      end
    elseif btnType == 2 then
      _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_RIGHTROTATION"))
    elseif btnType == 3 then
      _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_LEFTROTATION"))
    elseif btnType == 4 then
      if typeIsHavest then
        _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DELETE"))
      else
        _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_RETURN"))
      end
    elseif btnType == 5 then
      _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_MOVE"))
    elseif btnType == 6 then
      _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CANCEL"))
    elseif btnType == 7 then
      _txt_btnDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_ZOOMIN"))
    end
    _txt_btnDesc:SetSize(_txt_btnDesc:GetTextSizeX() + 50 + _txt_btnDesc:GetSpanSize().x, _txt_btnDesc:GetSizeY())
  else
    _txt_btnDesc:ResetVertexAni()
    local AniInfo = UIAni.AlphaAnimation(0, _txt_btnDesc, 0, 0.2)
    AniInfo:SetHideAtEnd(true)
  end
  _txt_btnDesc:ComputePos()
end
function Panel_House_ObjectControl_Confirm()
  if housing_isInstallMode() then
    local function doit()
      housing_InstallObject()
      FGlobal_House_InstallationModeCart_Update()
      HouseInstallationControl:Close()
    end
    local doCancel = function()
      FGlobal_HouseInstallationControl_Close()
      return
    end
    local installationType = UI_CIT.TypeCount
    local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
    if nil ~= characterStaticWrapper then
      installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
      if installationType == UI_CIT.eType_WallPaper or installationType == UI_CIT.eType_FloorMaterial then
        local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_TITLE_WALLPAPERDONTCANCLE")
        local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSING_MEMO_WALLPAPERDONTCANCLE")
        local messageboxData = {
          title = titleString,
          content = contentString,
          functionYes = doit,
          functionCancel = doCancel,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
        return
      end
    end
    doit()
  elseif housing_isBuildMode() then
    local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
    if nil ~= characterStaticWrapper then
      local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
      local isVillageTent = objectStaticWrapper:isVillageTent()
      if isVillageTent then
        FGlobal_VillageTent_SelectPopup()
        return
      end
    end
    local regionKeyRaw = 0
    if nil ~= characterStaticWrapper then
      local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
      if objectStaticWrapper:isAdvancedBase() then
        local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
        if nil ~= myGuildInfo then
          local guildNo = myGuildInfo:getGuildNo_s64()
          if ToClient_IsInSiegeBattle(guildNo) then
            regionKeyRaw = Panel_HouseGetRegionRaw()
          end
        end
      end
    end
    housing_InstallObject(regionKeyRaw)
    FGlobal_HouseInstallationControl_Close()
    FGlobal_House_InstallationMode_Close()
  else
    FGlobal_House_InstallationMode_Close()
  end
end
function Panel_HouseGetRegionRaw()
  local tempregionKeyRaw = 0
  local position = housing_getInstallationPos()
  local currentDay = ToClient_GetCurrentInstallableTentDayOfWeek(position)
  local dayCount = housing_getInstallableSiegeKeyList(position)
  for ii = 0, dayCount - 1 do
    local regionInfoWrapper = housing_getInstallableSiegeRegionInfo(ii)
    local day = regionInfoWrapper:getVillageSiegeType()
    if currentDay == day then
      tempregionKeyRaw = regionInfoWrapper:get()._regionKey:get()
      return tempregionKeyRaw
    end
  end
  return tempregionKeyRaw
end
function HandleClicked_HouseInstallationControl_Confirm()
  Panel_House_ObjectControl_Confirm()
end
function HandleClicked_HouseInstallationControl_Rotate(isRight)
  if true == isRight then
    housing_rotateObject(2)
  else
    housing_rotateObject(1)
  end
end
function HandleClicked_HouseInstallationControl_Delete()
  housing_deleteObject()
  HouseInstallationControl:Close()
  FGlobal_House_InstallationModeCart_Update()
end
function HandleClicked_HouseInstallationControl_Move()
  housing_moveObject()
  HouseInstallationControl:Close()
end
function HandleClicked_HouseInstallationControl_Cancel()
  housing_CancelInstallObject()
  HouseInstallationControl:Close()
  PAHousing_FarmInfo_Close()
  FGlobal_House_InstallationModeCart_Update()
end
function FGlobal_HouseInstallationControl_Open(installMode, posX, posY, isShow, isShowMove, isShowFix, isShowDelete, isShowCancel)
  if Panel_Win_System:GetShow() then
    return
  end
  local self = HouseInstallationControl
  local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
  local installationType
  local isCurtain = false
  if nil ~= characterStaticWrapper then
    installationType = characterStaticWrapper:getObjectStaticStatus():getInstallationType()
  end
  _txt_btnDesc:SetShow(false)
  local houseBuildMode = housing_isBuildMode()
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  local isFixed
  if nil ~= houseWrapper then
    isFixed = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isFixedHouse() or houseWrapper:getStaticStatusWrapper():getObjectStaticStatus():isInnRoom()
  end
  local tempShow = isShow
  if 2 == installMode and false == houseBuildMode then
    tempShow = false
  end
  local tempisShowDelete = isShowDelete
  self.btn_Resize:SetShow(false)
  self.btn_Confirm:SetShow(tempShow)
  self.btn_Rotate_Right:SetShow(tempShow)
  self.btn_Rotate_Left:SetShow(tempShow)
  self.btn_Delete:SetShow(tempisShowDelete)
  self.btn_Move:SetShow(isShowMove)
  self.btn_Cancel:SetShow(isShowCancel)
  if self.btn_Confirm:GetShow() and 3 == installMode then
    isConfirmStep = true
  else
    isConfirmStep = false
  end
  Panel_House_InstallationMode_ObjectControl:SetIgnore(false)
  if installMode > 0 and not housing_isBuildMode() then
    self.staticText_DetailGuide:SetShow(true)
  else
    self.staticText_DetailGuide:SetShow(false)
  end
  self.staticText_DetailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DESC"))
  if isShowMove then
    self.staticText_DetailGuide:SetPosY(120)
  else
    self.staticText_DetailGuide:SetPosY(98)
  end
  if UI_CIT.eType_Chandelier == installationType and 2 == installMode then
    Panel_House_InstallationMode_ObjectControl:SetIgnore(true)
    self.staticText_DetailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DETAILGUIDE1"))
    typeIsHavest = false
  elseif (UI_CIT.eType_Curtain == installationType or UI_CIT.eType_Curtain_Tied == installationType) and 2 == installMode then
    Panel_House_InstallationMode_ObjectControl:SetIgnore(true)
    self.staticText_DetailGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_DETAILGUIDE2"))
    typeIsHavest = false
  elseif UI_CIT.eType_WallPaper == installationType and 3 == installMode then
    self.btn_Rotate_Right:SetShow(false)
    self.btn_Rotate_Left:SetShow(false)
    typeIsHavest = false
  elseif UI_CIT.eType_FloorMaterial == installationType and 3 == installMode then
    self.btn_Rotate_Right:SetShow(false)
    self.btn_Rotate_Left:SetShow(false)
    typeIsHavest = false
  elseif (UI_CIT.eType_Havest == installationType or UI_CIT.eType_LivestockHarvest == installationType) and false == isFixed then
    typeIsHavest = true
    self.btn_Rotate_Right:SetShow(false)
    self.btn_Rotate_Left:SetShow(false)
  else
    typeIsHavest = false
  end
  local isRotatePossible = housing_isAvailableRotateSelectedObject()
  if isRotatePossible then
    self.txt_RotateDesc:SetShow(true)
    self.txt_RotateDesc:SetPosY(self.staticText_DetailGuide:GetPosY() + self.staticText_DetailGuide:GetSizeY())
  else
    self.txt_RotateDesc:SetShow(false)
  end
  if nil ~= characterStaticWrapper then
    local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
    local isPersonalTent = objectStaticWrapper:isPersonalTent()
    if isPersonalTent then
      self.btn_Rotate_Right:SetShow(false)
      self.btn_Rotate_Left:SetShow(false)
    end
  end
  if houseBuildMode then
    self.btn_Cancel:SetShow(false)
  end
  Panel_House_InstallationMode_ObjectControl:SetPosX(posX)
  Panel_House_InstallationMode_ObjectControl:SetPosY(posY)
  Panel_House_InstallationMode_ObjectControl:SetShow(isShow)
  HouseInstallationControl_Is_Open = true
end
function FGlobal_HouseInstallation_MinorWar_Open(buildingInfo)
  local houseWrapper = housing_getHouseholdActor_CurrentPosition()
  if nil == buildingInfo then
    if nil ~= houseWrapper and nil ~= houseWrapper:getStaticStatusWrapper() then
      Panel_House_WarInformation:SetShow(true)
      Panel_House_WarInformation:SetSpanSize(50, 50)
      local actorKeyRaw = houseWrapper:getActorKey()
      local buildingInfo = ToClient_getBuildingInfo(actorKeyRaw)
      if nil ~= buildingInfo then
        local allCount = buildingInfo:getAllInstanceObjectCount()
        local cOSW = houseWrapper:getStaticStatusWrapper():getObjectStaticStatus()
        for index = 0, innerObjectCount - 1 do
          innerObject[index]._maxCount:SetShow(true)
          innerObject[index]._count:SetShow(true)
        end
        if isGameTypeSA() then
          innerObject[0]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getHealingTownerMaxCount()))
          innerObject[1]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getObservatoryMaxCount()))
          innerObject[2]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getCatapultFactoryMaxCount()))
          innerObject[3]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getFlameFactoryMaxCount()))
          innerObject[4]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getDistributorMaxCount()))
          innerObject[5]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getBarricadeMaxCount()))
          innerObject[6]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getBarricadeGateMaxCount()))
          innerObject[7]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getDefenceTowerMaxCount()))
          innerObject[8]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getAdvancedBaseTowerMaxCount()))
          innerObject[0]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[0])))
          innerObject[1]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[1])))
          innerObject[2]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[3])))
          innerObject[3]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[4])))
          innerObject[4]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[5])))
          innerObject[5]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[6])))
          innerObject[6]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[7])))
          innerObject[7]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[9])))
          innerObject[8]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[12])))
        else
          innerObject[0]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getHealingTownerMaxCount()))
          innerObject[1]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getObservatoryMaxCount()))
          innerObject[2]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getElephantBarnMaxCount()))
          innerObject[3]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getCatapultFactoryMaxCount()))
          innerObject[4]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getFlameFactoryMaxCount()))
          innerObject[5]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getDistributorMaxCount()))
          innerObject[6]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getBarricadeMaxCount()))
          innerObject[7]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getBarricadeGateMaxCount()))
          innerObject[8]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getWoodenFenceMaxCount()))
          innerObject[9]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getDefenceTowerMaxCount()))
          innerObject[10]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getSiegeTowerMaxCount()))
          innerObject[11]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getLargeSiegeTowerMaxCount()))
          innerObject[12]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", cOSW:getAdvancedBaseTowerMaxCount()))
          innerObject[0]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[0])))
          innerObject[1]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[1])))
          innerObject[2]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[2])))
          innerObject[3]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[3])))
          innerObject[4]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[4])))
          innerObject[5]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[5])))
          innerObject[6]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[6])))
          innerObject[7]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[7])))
          innerObject[8]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[8])))
          innerObject[9]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[9])))
          innerObject[10]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[10])))
          innerObject[11]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[11])))
          innerObject[12]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildingInfo:getInstanceObjectCount(innerObjectKind[12])))
        end
        local usedCount = 0
        for index = 0, innerObjectCount - 1 do
          usedCount = usedCount + innerObjectSize[index] * buildingInfo:getInstanceObjectCount(innerObjectKind[index])
        end
        HouseInstallationControl.warCountInnerObjectMaxSize:SetShow(true)
        HouseInstallationControl.warCountInnerObjectTitle:SetShow(true)
        HouseInstallationControl.warCountInnerBigTitle_Limit:SetShow(true)
        HouseInstallationControl.warCountInstallationCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", allCount))
        HouseInstallationControl.warCountInnerObjectMaxSize:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", cOSW:getInnerObjectSize()) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTLEFTCOUNT", "count", cOSW:getInnerObjectSize() - usedCount))
        Panel_House_WarInformation:ComputePos()
      end
    end
  else
    Panel_House_WarInformation:SetShow(true)
    Panel_House_WarInformation:SetPosY(string.format("%d", buildingInfo:GetPosY()) + 50)
    Panel_House_WarInformation:SetPosX(string.format("%d", buildingInfo:GetPosX()) + 50)
    local buildInfo = buildingInfo:ToClient_getBuildingStaticStatus()
    if nil ~= buildInfo then
      local CSSW = buildInfo:getCharacterStaticStatusWrapper()
      if nil ~= CSSW then
        local OSSW = CSSW:getObjectStaticStatus()
        local allCount = buildInfo:getAllInstanceObjectCount()
        if isGameTypeSA() then
          innerObject[0]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getHealingTownerMaxCount()))
          innerObject[1]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getObservatoryMaxCount()))
          innerObject[2]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getCatapultFactoryMaxCount()))
          innerObject[3]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getFlameFactoryMaxCount()))
          innerObject[4]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getDistributorMaxCount()))
          innerObject[5]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getBarricadeMaxCount()))
          innerObject[6]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getBarricadeGateMaxCount()))
          innerObject[7]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getDefenceTowerMaxCount()))
          innerObject[8]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getAdvancedBaseTowerMaxCount()))
          innerObject[0]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[0])))
          innerObject[1]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[1])))
          innerObject[2]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[3])))
          innerObject[3]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[4])))
          innerObject[4]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[5])))
          innerObject[5]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[6])))
          innerObject[6]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[7])))
          innerObject[7]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[9])))
          innerObject[8]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[12])))
        else
          innerObject[0]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getHealingTownerMaxCount()))
          innerObject[1]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getObservatoryMaxCount()))
          innerObject[2]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getElephantBarnMaxCount()))
          innerObject[3]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getCatapultFactoryMaxCount()))
          innerObject[4]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getFlameFactoryMaxCount()))
          innerObject[5]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getDistributorMaxCount()))
          innerObject[6]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getBarricadeMaxCount()))
          innerObject[7]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getBarricadeGateMaxCount()))
          innerObject[8]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getWoodenFenceMaxCount()))
          innerObject[9]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getDefenceTowerMaxCount()))
          innerObject[10]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getSiegeTowerMaxCount()))
          innerObject[11]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getLargeSiegeTowerMaxCount()))
          innerObject[12]._maxCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", OSSW:getAdvancedBaseTowerMaxCount()))
          innerObject[0]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[0])))
          innerObject[1]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[1])))
          innerObject[2]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[2])))
          innerObject[3]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[3])))
          innerObject[4]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[4])))
          innerObject[5]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[5])))
          innerObject[6]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[6])))
          innerObject[7]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[7])))
          innerObject[8]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[8])))
          innerObject[9]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[9])))
          innerObject[10]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[10])))
          innerObject[11]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[11])))
          innerObject[12]._count:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", buildInfo:getInstanceObjectCount(innerObjectKind[12])))
        end
        local usedCount = 0
        for index = 0, innerObjectCount - 1 do
          usedCount = usedCount + innerObjectSize[index] * buildInfo:getInstanceObjectCount(innerObjectKind[index])
        end
        HouseInstallationControl.warCountInstallationCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTMAXCOUNT", "count", allCount))
        HouseInstallationControl.warCountInnerObjectMaxSize:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTSIZE", "size", OSSW:getInnerObjectSize()) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_INNEROBJECTLEFTCOUNT", "count", OSSW:getInnerObjectSize() - usedCount))
      end
    end
  end
end
function FGlobal_HouseInstallation_MinorWar_Close()
  Panel_House_WarInformation:SetShow(false)
end
function FGlobal_HouseInstallationControl_Close()
  housing_CancelInstallObject()
  Panel_House_InstallationMode_ObjectControl:SetShow(false)
  HouseInstallationControl_Is_Open = false
  VillageTent_Close()
end
function FGlobal_HouseInstallationControl_Move()
  housing_moveObject()
  HouseInstallationControl:Close()
end
function FGlobal_HouseInstallationControl_CloseOuter()
  HouseInstallationControl:Close()
end
function FGlobal_HouseInstallationControl_Confirm()
  Panel_House_ObjectControl_Confirm()
end
function FGlobal_HouseInstallationControl_IsConfirmStep()
  return isConfirmStep
end
function HouseInstallationControl:registEventHandler()
  self.btn_Confirm:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Confirm()")
  self.btn_Rotate_Right:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Rotate( true )")
  self.btn_Rotate_Left:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Rotate( false )")
  self.btn_Delete:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Delete()")
  self.btn_Move:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Move()")
  self.btn_Cancel:addInputEvent("Mouse_LUp", "HandleClicked_HouseInstallationControl_Cancel()")
  self.btn_Confirm:ActiveMouseEventEffect(true)
  self.btn_Rotate_Right:ActiveMouseEventEffect(true)
  self.btn_Rotate_Left:ActiveMouseEventEffect(true)
  self.btn_Delete:ActiveMouseEventEffect(true)
  self.btn_Move:ActiveMouseEventEffect(true)
  self.btn_Cancel:ActiveMouseEventEffect(true)
  self.btn_Confirm:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 1 .. ")")
  self.btn_Rotate_Right:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 2 .. ")")
  self.btn_Rotate_Left:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 3 .. ")")
  self.btn_Delete:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 4 .. ")")
  self.btn_Move:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 5 .. ")")
  self.btn_Cancel:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 6 .. ")")
  self.btn_Resize:addInputEvent("Mouse_On", "Panel_House_ObjectControlDescFunc( true, " .. 7 .. ")")
  self.btn_Confirm:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 1 .. ")")
  self.btn_Rotate_Right:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 2 .. ")")
  self.btn_Rotate_Left:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 3 .. ")")
  self.btn_Delete:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 4 .. ")")
  self.btn_Move:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 5 .. ")")
  self.btn_Cancel:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 6 .. ")")
  self.btn_Resize:addInputEvent("Mouse_Out", "Panel_House_ObjectControlDescFunc( false," .. 7 .. ")")
end
function HouseInstallationControl:registMessageHandler()
end
HouseInstallationControl:Initialize()
HouseInstallationControl:registEventHandler()
HouseInstallationControl:registMessageHandler()
