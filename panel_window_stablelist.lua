Panel_Window_StableList:SetShow(false, false)
Panel_Window_StableList:setMaskingChild(true)
Panel_Window_StableList:ActiveMouseEventEffect(true)
Panel_Window_StableList:setGlassBackground(true)
Panel_Window_HorseLookChange:SetShow(false)
Panel_Window_HorseLookChange:ActiveMouseEventEffect(true)
Panel_Window_HorseLookChange:setGlassBackground(true)
Panel_Window_StableList:RegisterShowEventFunc(true, "StableListShowAni()")
Panel_Window_StableList:RegisterShowEventFunc(false, "StableListHideAni()")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local UI_SW = CppEnums.ServantWhereType
local servantInvenAlert = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SELL_WITHITEM_MSG")
local isContentsEnable = ToClient_IsContentsGroupOpen("61")
local isContentsEnableSupply = ToClient_IsContentsGroupOpen("42")
local isContentsStallionEnable = ToClient_IsContentsGroupOpen("243")
local isContentsNineTierEnable = ToClient_IsContentsGroupOpen("80")
function StableListShowAni()
  local isShow = Panel_Window_StableList:IsShow()
  if isShow then
    Panel_Window_StableList:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo1 = Panel_Window_StableList:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo1:SetStartIntensity(3)
    aniInfo1:SetEndIntensity(1)
    aniInfo1.IsChangeChild = true
    aniInfo1:SetHideAtEnd(true)
    aniInfo1:SetDisableWhileAni(true)
  else
    UIAni.fadeInSCR_Down(Panel_Window_StableList)
    Panel_Window_StableList:SetShow(true, false)
  end
end
function StableListHideAni()
  Inventory_SetFunctor(nil)
  Panel_Window_StableList:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_StableList:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
local stableList = {
  _const = {
    eTypeSealed = 0,
    eTypeUnsealed = 1,
    eTypeTaming = 2
  },
  _config = {
    slot = {
      startX = 15,
      startY = 15,
      gapY = 158
    },
    icon = {
      startX = 0,
      startY = 0,
      startNameX = 5,
      startNameY = 120,
      startEffectX = -1,
      startEffectY = -1,
      startSexIconX = 0,
      startSexIconY = 0,
      startStateX = 23,
      startStateY = 3
    },
    unseal = {
      startX = 230,
      startY = 0,
      startTitleX = -15,
      startTitleY = 0,
      startButtonX = 25,
      startButtonY = 25,
      startIconX = 25,
      startIconY = 35,
      startEffectX = -1,
      startEffectY = -1
    },
    taming = {
      startX = 230,
      startY = 50,
      startTitleX = 30,
      startTitleY = 0,
      startButtonX = 25,
      startButtonY = 25,
      startIconX = 25,
      startIconY = 35,
      startEffectX = -1,
      startEffectY = -1
    },
    button = {
      startX = 180,
      startY = 0,
      startButtonX = 15,
      startButtonY = 10,
      gapY = 40,
      sizeY = 40,
      sizeYY = 10
    },
    slotCount = 4
  },
  _staticListBG = UI.getChildControl(Panel_Window_StableList, "Static_ListBG"),
  _staticButtonListBG = UI.getChildControl(Panel_Window_StableList, "Static_PopupBG"),
  _staticNotice = UI.getChildControl(Panel_Window_StableList, "StaticText_Notice"),
  _staticSlotCount = UI.getChildControl(Panel_Window_StableList, "StaticText_Slot_Count"),
  _scroll = UI.getChildControl(Panel_Window_StableList, "Scroll_Slot_List"),
  _slots = Array.new(),
  _selectSlotNo = nil,
  _startSlotIndex = 0,
  _selectSceneIndex = -1,
  _unseal = {},
  _taming = {},
  _servantMaxLevel = 30,
  _lookChangeMaxSlotCount = 5,
  _btnClose = UI.getChildControl(Panel_Window_HorseLookChange, "Button_Close"),
  _btnLeft = UI.getChildControl(Panel_Window_HorseLookChange, "Button_LargCraftInfo_Slide_Left"),
  _btnRight = UI.getChildControl(Panel_Window_HorseLookChange, "Button_LargCraftInfo_Slide_Right"),
  _LCSelectSlot = UI.getChildControl(Panel_Window_HorseLookChange, "Static_SelectSlot"),
  _textPage = UI.getChildControl(Panel_Window_HorseLookChange, "StaticText_Page"),
  _btnChange = UI.getChildControl(Panel_Window_HorseLookChange, "Button_LookChange"),
  _btnPremium = UI.getChildControl(Panel_Window_HorseLookChange, "Button_PremiumLookChange"),
  _textCurrentLook = UI.getChildControl(Panel_Window_HorseLookChange, "StaticText_CurrentLook"),
  _comboBox = UI.getChildControl(Panel_Window_HorseLookChange, "Combobox_Tier")
}
local lookChangeSlot = {
  [1] = UI.getChildControl(Panel_Window_HorseLookChange, "Static_LookChange_Slot_1"),
  [2] = UI.getChildControl(Panel_Window_HorseLookChange, "Static_LookChange_Slot_2"),
  [3] = UI.getChildControl(Panel_Window_HorseLookChange, "Static_LookChange_Slot_3"),
  [4] = UI.getChildControl(Panel_Window_HorseLookChange, "Static_LookChange_Slot_4"),
  [5] = UI.getChildControl(Panel_Window_HorseLookChange, "Static_LookChange_Slot_5")
}
local sellCheck = true
function stableList:init()
  for ii = 0, self._config.slotCount - 1 do
    local slot = {}
    slot.slotNo = ii
    slot.panel = Panel_Window_StableList
    slot.button = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button", self._staticListBG, "StableList_Slot_" .. ii)
    slot.effect = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button_Effect", slot.button, "StableList_Slot_Effect_" .. ii)
    slot.icon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Icon", slot.button, "StableList_Slot_Icon_" .. ii)
    slot.name = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Name", slot.button, "StableList_Slot_Name_" .. ii)
    slot.maleIcon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_MaleIcon", slot.button, "StableList_Slot_IconMale_" .. ii)
    slot.femaleIcon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_FemaleIcon", slot.button, "StableList_Slot_IconFemale_" .. ii)
    slot.pcroomIcon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_PCRoom", slot.button, "StableList_Slot_IconPcroom_" .. ii)
    slot.registerMating = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_RegisterMating", slot.button, "ServantList_Slot_RegisterMating_" .. ii)
    slot.registerMarket = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_RegisterMarket", slot.button, "ServantList_Slot_RegisterMarket_" .. ii)
    slot.coma = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_Coma", slot.button, "ServantList_Slot_Coma_" .. ii)
    slot.link = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_Link", slot.button, "ServantList_Slot_Link_" .. ii)
    slot.grade = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_HorseGrade", slot.button, "ServantList_Slot_Grade_" .. ii)
    slot.mating = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_Mating", slot.button, "ServantList_Slot_Mating_" .. ii)
    slot.matingComplete = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_MatingComplete", slot.button, "ServantList_Slot_MatingCompletes_" .. ii)
    slot.training = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_Training", slot.button, "ServantList_Slot_Training_" .. ii)
    slot.isSeized = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_Attachment", slot.button, "ServantList_Slot_Seized" .. ii)
    slot.stallion = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_iconStallion", slot.button, "ServantList_Slot_Stallion" .. ii)
    local slotConfig = self._config.slot
    slot.button:SetPosX(slotConfig.startX)
    slot.button:SetPosY(slotConfig.startY + slotConfig.gapY * ii)
    if isGameTypeKorea() then
      slot.pcroomIcon:SetSize(18, 13)
      slot.pcroomIcon:ChangeTextureInfoName("new_ui_common_forlua/default/default_etc_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slot.pcroomIcon, 93, 231, 111, 244)
      slot.pcroomIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      slot.pcroomIcon:setRenderTexture(slot.pcroomIcon:getBaseTexture())
    elseif isGameTypeRussia() then
      slot.pcroomIcon:SetSize(24, 24)
      slot.pcroomIcon:ChangeTextureInfoName("new_ui_common_forlua/Widget/BuffList/PremiumPackage3.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slot.pcroomIcon, 0, 0, 32, 32)
      slot.pcroomIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      slot.pcroomIcon:setRenderTexture(slot.pcroomIcon:getBaseTexture())
    end
    local iconConfig = self._config.icon
    slot.icon:SetPosX(iconConfig.startX)
    slot.icon:SetPosY(iconConfig.startY)
    slot.name:SetPosX(iconConfig.startNameX)
    slot.name:SetPosY(iconConfig.startNameY)
    slot.effect:SetPosX(iconConfig.startEffectX)
    slot.effect:SetPosY(iconConfig.startEffectY)
    slot.maleIcon:SetPosX(iconConfig.startSexIconX)
    slot.maleIcon:SetPosY(iconConfig.startSexIconY)
    slot.femaleIcon:SetPosX(iconConfig.startSexIconX)
    slot.femaleIcon:SetPosY(iconConfig.startSexIconY)
    slot.pcroomIcon:SetPosX(iconConfig.startSexIconX + 25)
    slot.pcroomIcon:SetPosY(iconConfig.startSexIconY + 5)
    slot.registerMating:SetPosX(iconConfig.startStateX)
    slot.registerMating:SetPosY(iconConfig.startStateY)
    slot.registerMarket:SetPosX(iconConfig.startStateX)
    slot.registerMarket:SetPosY(iconConfig.startStateY)
    slot.coma:SetPosX(iconConfig.startStateX)
    slot.coma:SetPosY(iconConfig.startStateY)
    slot.link:SetPosY(iconConfig.startStateY)
    slot.grade:SetPosY(iconConfig.startStateY)
    slot.mating:SetPosX(iconConfig.startStateX)
    slot.mating:SetPosY(iconConfig.startStateY)
    slot.matingComplete:SetPosX(iconConfig.startStateX)
    slot.matingComplete:SetPosY(iconConfig.startStateY)
    slot.training:SetPosX(iconConfig.startStateX)
    slot.training:SetPosY(iconConfig.startStateY)
    slot.isSeized:SetPosX(iconConfig.startStateX)
    slot.isSeized:SetPosY(iconConfig.startStateY)
    slot.stallion:SetPosX(iconConfig.startStateX + 95)
    slot.stallion:SetPosY(iconConfig.startStateY + 17)
    slot.icon:ActiveMouseEventEffect(true)
    slot.button:addInputEvent("Mouse_LUp", "StableList_SlotSelect(" .. ii .. ")")
    slot.button:addInputEvent("Mouse_RUp", "StableList_Mix(" .. ii .. ")")
    UIScroll.InputEventByControl(slot.button, "StableList_ScrollEvent")
    slot.stallion:SetShow(false)
    self._slots[ii] = slot
  end
  self._unseal._bg = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_BG", Panel_Window_StableList, "StableList_Unseal_BG")
  self._unseal._stallion = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_unsealStallion", Panel_Window_StableList, "StableList_Unseal_Stallion")
  self._unseal._title = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_SubTitle", self._unseal._bg, "StableList_Unseal_Title")
  self._unseal._button = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button", self._unseal._bg, "StableList_Unseal_Button")
  self._unseal._icon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Icon", self._unseal._bg, "StableList_Unseal_Icon")
  self._unseal._pcroomIcon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_PCRoom", self._unseal._bg, "StableList_Unseal_PcRoomIcon")
  self._unseal._effect = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button_UnSeal_Effect", self._unseal._bg, "StableList_Unseal_Effect")
  self._unseal._grade = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_HorseGrade", self._unseal._bg, "ServantList_Slot_Grade")
  self._unseal._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_NOW_VEHICLE"))
  local unsealConfig = self._config.unseal
  self._unseal._bg:SetPosX(unsealConfig.startX)
  self._unseal._bg:SetPosY(unsealConfig.startY)
  self._unseal._title:SetPosX(unsealConfig.startTitleX)
  self._unseal._title:SetPosY(unsealConfig.startTitleY)
  self._unseal._stallion:SetPosX(unsealConfig.startTitleX + 390)
  self._unseal._stallion:SetPosY(unsealConfig.startTitleY + 48)
  self._unseal._button:SetPosX(unsealConfig.startButtonX)
  self._unseal._button:SetPosY(unsealConfig.startButtonY)
  self._unseal._grade:SetPosX(120)
  self._unseal._grade:SetPosY(unsealConfig.startButtonY + 5)
  self._unseal._icon:SetPosX(unsealConfig.startIconX)
  self._unseal._icon:SetPosY(unsealConfig.startIconY)
  self._unseal._pcroomIcon:SetPosX(unsealConfig.startIconX + 15)
  self._unseal._pcroomIcon:SetPosY(unsealConfig.startIconY + 0)
  self._unseal._effect:SetPosX(unsealConfig.startButtonX - 2)
  self._unseal._effect:SetPosY(unsealConfig.startButtonY - 2)
  self._unseal._button:addInputEvent("Mouse_LUp", "StableList_ButtonOpen( 1, 0 )")
  self._taming._bg = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_BG", Panel_Window_StableList, "StableList_Taming_BG")
  self._taming._title = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "StaticText_SubTitle", self._taming._bg, "StableList_Taming_Title")
  self._taming._button = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button", self._taming._bg, "StableList_Taming_Button")
  self._taming._icon = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Icon", self._taming._bg, "StableList_Taming_Icon")
  self._taming._effect = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Static_Button_Taming_Effect", self._taming._bg, "StableList_Taming_Effect")
  self._taming._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_TAME_VEHICLE"))
  local taminglConfig = self._config.taming
  self._taming._bg:SetPosX(taminglConfig.startX)
  self._taming._bg:SetPosY(taminglConfig.startY)
  self._taming._title:SetPosX(taminglConfig.startTitleX)
  self._taming._title:SetPosY(taminglConfig.startTitleY)
  self._taming._button:SetPosX(taminglConfig.startButtonX)
  self._taming._button:SetPosY(taminglConfig.startButtonY)
  self._taming._icon:SetPosX(taminglConfig.startIconX)
  self._taming._icon:SetPosY(taminglConfig.startIconY)
  self._taming._effect:SetPosX(taminglConfig.startButtonX - 2)
  self._taming._effect:SetPosY(taminglConfig.startButtonY - 2)
  self._taming._button:addInputEvent("Mouse_LUp", "StableList_ButtonOpen( 2, 0 )")
  self._buttonRegister = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Register", self._staticButtonListBG, "StableList_Button_Register")
  self._buttonSeal = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Seal", self._staticButtonListBG, "StableList_Button_Seal")
  self._buttonCompulsionSeal = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_CompulsionSeal", self._staticButtonListBG, "StableList_Button_CompulsionSeal")
  self._buttonRecoveryUnseal = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_RecoveryUnseal", self._staticButtonListBG, "StableList_Button_RecoveryUnseal")
  self._buttonRepairUnseal = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_RepairUnseal", self._staticButtonListBG, "StableList_Button_RepairUnseal")
  self._buttonUnseal = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Unseal", self._staticButtonListBG, "StableList_Button_Unseal")
  self._buttonRepair = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Repair", self._staticButtonListBG, "StableList_Button_Repair")
  self._buttonRecovery = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Recovery", self._staticButtonListBG, "StableList_Button_Recovery")
  self._buttonSell = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Sell", self._staticButtonListBG, "StableList_Button_Sell")
  self._buttonSupply = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Supply", self._staticButtonListBG, "StableList_Button_Supply")
  self._buttonRelease = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Release", self._staticButtonListBG, "StableList_Button_Release")
  self._buttonChangeName = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_ChangeName", self._staticButtonListBG, "StableList_Button_ChangeName")
  self._buttonRegisterMating = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_RegisterMating", self._staticButtonListBG, "StableList_Button_RegisterMating")
  self._buttonRegisterMarket = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_RegisterMarket", self._staticButtonListBG, "StableList_Button_RegisterMarket")
  self._buttonReceiveChild = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_ReceiveChildServant", self._staticButtonListBG, "StableList_Button_ReceiveChildServant")
  self._buttonReturnMale = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_ReturnMating", self._staticButtonListBG, "StableList_Button_ReturnMating")
  self._buttonClearDeadCount = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_KillReset", self._staticButtonListBG, "StableList_Button_DeadCountReset")
  self._buttonClearMatingCount = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_IncreaseMatingCount", self._staticButtonListBG, "StableList_Button_MatingCountReset")
  self._buttonImprint = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_Imprint", self._staticButtonListBG, "StableList_Button_Imprint")
  self._buttonReleaseImprint = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_ReleaseImprint", self._staticButtonListBG, "StableList_Button_ReleaseImprint")
  self._buttonAddCarriage = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_AddToCarriage", self._staticButtonListBG, "StableList_Button_AddToCarriage")
  self._buttonReleaseCarriage = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_ReleaseToCarriage", self._staticButtonListBG, "StableList_Button_ReleaseToCarriage")
  self._buttonHorseLookChange = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_LookChange", self._staticButtonListBG, "StableList_Button_LookChange")
  self._buttonTrainingFinish = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_TrainingFinish", self._staticButtonListBG, "StableList_Button_TrainingFinish")
  self._buttonStallionTraining = UI.createAndCopyBasePropertyControl(Panel_Window_StableList, "Button_StallionTraining", self._staticButtonListBG, "StableList_Button_StallionTraining")
  self._buttonRelease:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE"))
  self._scroll:SetControlPos(0)
  Panel_Window_StableList:SetChildIndex(self._staticButtonListBG, 9999)
end
function stableList:clear()
  self._selectSlotNo = nil
  self._startSlotIndex = 0
end
function stableList:update()
  local servantCount = stable_count()
  if 0 == servantCount then
    stableList._staticNotice:SetShow(true)
  else
    stableList._staticNotice:SetShow(false)
    stableList_ServantCountInit(servantCount)
  end
  if isSiegeStable() then
    self._staticSlotCount:SetText(servantCount .. " / " .. servantCount)
  else
    self._staticSlotCount:SetText(stable_currentSlotCount() .. " / " .. stable_maxSlotCount())
  end
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    slot.index = -1
    slot.button:SetShow(false)
  end
  stable_SortDataupdate()
  local slotNo = 0
  local linkedHorseCount = 0
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  for ii = self._startSlotIndex, servantCount - 1 do
    local sortIndex = 0
    sortIndex = stable_SortByWayPointKey(ii)
    local servantInfo = stable_getServant(sortIndex)
    if nil ~= servantInfo then
      local servantRegionName = servantInfo:getRegionName()
      local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType()
      local regionKey = servantInfo:getRegionKeyRaw()
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      local exploerKey = regionInfoWrapper:getExplorationKey()
      local getState = servantInfo:getStateType()
      local vehicleType = servantInfo:getVehicleType()
      if slotNo <= self._config.slotCount - 1 then
        local slot = self._slots[slotNo]
        slot.maleIcon:SetShow(false)
        slot.femaleIcon:SetShow(false)
        slot.pcroomIcon:SetShow(false)
        slot.isSeized:SetShow(false)
        slot.registerMating:SetShow(false)
        slot.registerMarket:SetShow(false)
        slot.coma:SetShow(false)
        slot.link:SetShow(false)
        slot.grade:SetShow(false)
        slot.mating:SetShow(false)
        slot.matingComplete:SetShow(false)
        slot.stallion:SetShow(false)
        slot.training:SetShow(false)
        if isLinkedHorse then
          slot.link:SetShow(true)
        end
        slot.name:SetText(servantInfo:getName(ii) .. [[

(]] .. servantInfo:getRegionName(ii) .. ")")
        slot.icon:ChangeTextureInfoName(servantInfo:getIconPath1())
        if regionName == servantRegionName then
          slot.button:SetMonoTone(false)
        elseif 0 == servantInfo:getHp() and (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_MountainGoat == vehicleType) and not servantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState then
          slot.button:SetMonoTone(false)
        elseif not isSiegeStable() then
          slot.button:SetMonoTone(true)
        end
        if servantInfo:isSeized() then
          slot.isSeized:SetShow(true)
        elseif CppEnums.ServantStateType.Type_RegisterMarket == getState then
          slot.registerMarket:SetShow(true)
        elseif CppEnums.ServantStateType.Type_RegisterMating == getState then
          slot.registerMating:SetShow(true)
        elseif CppEnums.ServantStateType.Type_Mating == getState then
          if servantInfo:isMatingComplete() then
            slot.matingComplete:SetShow(true)
          else
            slot.mating:SetShow(true)
          end
        elseif CppEnums.ServantStateType.Type_Coma == getState then
          slot.coma:SetShow(true)
          if vehicleType == CppEnums.VehicleType.Type_Carriage or vehicleType == CppEnums.VehicleType.Type_CowCarriage or vehicleType == CppEnums.VehicleType.Type_RepairableCarriage then
            slot.coma:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_REPAIR"))
          else
            slot.coma:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_HURT"))
          end
        elseif CppEnums.ServantStateType.Type_SkillTraining == getState then
          if stable_isSkillExpTrainingComplete(sortIndex) then
            slot.training:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINFINISH"))
          else
            slot.training:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINING"))
          end
          slot.training:SetShow(true)
        elseif CppEnums.ServantStateType.Type_StallionTraining == getState and isContentsStallionEnable and isContentsNineTierEnable then
          slot.training:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINING"))
          slot.training:SetShow(true)
        end
        if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse then
          if servantInfo:isMale() then
            slot.maleIcon:SetShow(true)
            slot.femaleIcon:SetShow(false)
          else
            slot.maleIcon:SetShow(false)
            slot.femaleIcon:SetShow(true)
          end
          slot.grade:SetShow(true)
          if 9 == servantInfo:getTier() then
            slot.grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
          else
            slot.grade:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
          end
          if servantInfo:isStallion() then
          end
        else
          slot.grade:SetShow(false)
          slot.maleIcon:SetShow(false)
          slot.femaleIcon:SetShow(false)
        end
        if servantInfo:isPcroomOnly() then
          slot.pcroomIcon:SetShow(true)
        end
        slot.button:SetShow(true)
        slot.index = ii
        slotNo = slotNo + 1
        if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse and 9 ~= servantInfo:getTier() and false == servantInfo:isPcroomOnly() and isContentsStallionEnable then
          slot.stallion:SetShow(true)
          local stallion = servantInfo:isStallion()
          if true == stallion and regionName == servantRegionName then
            slot.stallion:SetMonoTone(false)
          else
            slot.stallion:SetMonoTone(true)
          end
        else
          slot.stallion:SetShow(false)
        end
      end
    end
  end
  self._unseal._bg:SetShow(false)
  self._unseal._stallion:SetShow(false)
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  if nil ~= servantInfo then
    if servantInfo:getVehicleType() ~= CppEnums.VehicleType.Type_BabyElephant then
      self._unseal._icon:ChangeTextureInfoName(servantInfo:getIconPath1())
      self._unseal._bg:SetShow(true)
      if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse and 9 ~= servantInfo:getTier() and false == servantInfo:isPcroomOnly() and isContentsStallionEnable then
        self._unseal._stallion:SetShow(true)
        local isStallion = servantInfo:isStallion()
        if true == isStallion then
          self._unseal._stallion:SetMonoTone(false)
        else
          self._unseal._stallion:SetMonoTone(true)
        end
      else
        self._unseal._stallion:SetShow(false)
      end
    end
    if servantInfo:isPcroomOnly() then
      if isGameTypeKorea() then
        self._unseal._pcroomIcon:SetSize(18, 13)
        self._unseal._pcroomIcon:ChangeTextureInfoName("new_ui_common_forlua/default/default_etc_02.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self._unseal._pcroomIcon, 93, 231, 111, 244)
        self._unseal._pcroomIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        self._unseal._pcroomIcon:setRenderTexture(self._unseal._pcroomIcon:getBaseTexture())
      elseif isGameTypeRussia() then
        self._unseal._pcroomIcon:SetSize(24, 24)
        self._unseal._pcroomIcon:ChangeTextureInfoName("new_ui_common_forlua/Widget/BuffList/PremiumPackage3.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(self._unseal._pcroomIcon, 0, 0, 32, 32)
        self._unseal._pcroomIcon:getBaseTexture():setUV(x1, y1, x2, y2)
        self._unseal._pcroomIcon:setRenderTexture(self._unseal._pcroomIcon:getBaseTexture())
      end
      self._unseal._pcroomIcon:SetShow(true)
    else
      self._unseal._pcroomIcon:SetShow(false)
    end
  end
  local servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
  local horseWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.VehicleType.Type_Horse)
  if nil ~= horseWrapper then
    if 0 < servantInfo:getTier() then
      self._unseal._grade:SetShow(true)
      if 9 == servantInfo:getTier() then
        self._unseal._grade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9"))
      else
        self._unseal._grade:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", servantInfo:getTier()))
      end
    else
      self._unseal._grade:SetShow(false)
    end
  else
    self._unseal._grade:SetShow(false)
  end
  self._taming._bg:SetShow(false)
  local characterKey = stable_getTamingServantCharacterKey()
  if nil ~= characterKey then
    local servantInfo = stable_getServantByCharacterKey(characterKey, 1)
    if nil ~= servantInfo then
      if servantInfo:getVehicleType() ~= CppEnums.VehicleType.Type_BabyElephant then
        self._taming._icon:ChangeTextureInfoName(servantInfo:getIconPath1())
        self._taming._bg:SetShow(true)
      end
      if self._unseal._bg:GetShow() then
        self._taming._bg:SetPosY(self._config.taming.startButtonY + self._unseal._bg:GetSizeY() + 10)
      else
        self._taming._bg:SetPosY(self._config.taming.startButtonY)
      end
    end
  end
  UIScroll.SetButtonSize(self._scroll, self._config.slotCount, servantCount)
  FGlobal_NeedStableRegistItem_Print()
end
function stableList:registEventHandler()
  UIScroll.InputEvent(self._scroll, "StableList_ScrollEvent")
  Panel_Window_StableList:addInputEvent("Mouse_UpScroll", "StableList_ScrollEvent( true )")
  Panel_Window_StableList:addInputEvent("Mouse_DownScroll", "StableList_ScrollEvent( false )")
  self._buttonRegister:addInputEvent("Mouse_LUp", "StableList_RegisterFromTaming()")
  self._buttonSeal:addInputEvent("Mouse_LUp", "StableList_Seal( false )")
  self._buttonCompulsionSeal:addInputEvent("Mouse_LUp", "StableList_Seal( true )")
  self._buttonRepair:addInputEvent("Mouse_LUp", "StableList_Recovery()")
  self._buttonRecoveryUnseal:addInputEvent("Mouse_LUp", "StableList_RecoveryUnseal()")
  self._buttonRepairUnseal:addInputEvent("Mouse_LUp", "StableList_RecoveryUnseal()")
  self._buttonRecovery:addInputEvent("Mouse_LUp", "StableList_Recovery()")
  self._buttonSell:addInputEvent("Mouse_LUp", "StableList_SellToNpc()")
  self._buttonSupply:addInputEvent("Mouse_LUp", "StableList_SupplyToNpc()")
  self._buttonRelease:addInputEvent("Mouse_LUp", "StableList_Release()")
  self._buttonChangeName:addInputEvent("Mouse_LUp", "StableList_ChangeName()")
  self._buttonRegisterMating:addInputEvent("Mouse_LUp", "StableList_RegisterMating()")
  self._buttonRegisterMarket:addInputEvent("Mouse_LUp", "StableList_RegisterMarket()")
  self._buttonReceiveChild:addInputEvent("Mouse_LUp", "StableList_ReceiveChildServant()")
  self._buttonReturnMale:addInputEvent("Mouse_LUp", "StableList_RegisterCancel()")
  self._buttonClearDeadCount:addInputEvent("Mouse_LUp", "StableList_ClearDeadCount()")
  self._buttonClearMatingCount:addInputEvent("Mouse_LUp", "StableList_ClearMatingCount()")
  self._buttonImprint:addInputEvent("Mouse_LUp", "StableList_Imprint( true )")
  self._buttonReleaseImprint:addInputEvent("Mouse_LUp", "StableList_Imprint( false )")
  self._buttonReleaseCarriage:addInputEvent("Mouse_LUp", "StableList_Unlink()")
  self._buttonStallionTraining:addInputEvent("Mouse_LUp", "StableList_StartStallionTraining()")
  self._btnClose:addInputEvent("Mouse_LUp", "Panel_HorseLookChange_Close()")
  self._btnLeft:addInputEvent("Mouse_LUp", "HorseLookChange_Set(" .. -1 .. ")")
  self._btnRight:addInputEvent("Mouse_LUp", "HorseLookChange_Set(" .. 1 .. ")")
  self._btnChange:addInputEvent("Mouse_LUp", "HorseLookChange_ChangeConfirm()")
  self._btnPremium:addInputEvent("Mouse_LUp", "HorseLookChange_PremiumChangeConfirm()")
  self._comboBox:addInputEvent("Mouse_LUp", "HandleClicked_LookCombo()")
  self._comboBox:GetListControl():addInputEvent("Mouse_LUp", "Set_LookChange()")
  self._btnLeft:SetAutoDisableTime(0.2)
  self._btnRight:SetAutoDisableTime(0.2)
  for index = 1, self._lookChangeMaxSlotCount do
    lookChangeSlot[index]:addInputEvent("Mouse_LUp", "HandleClicked_LookSlot(" .. index - 1 .. ")")
  end
end
function stableList:registMessageHandler()
  registerEvent("onScreenResize", "StableList_Resize")
  registerEvent("FromClient_ServantRegisterToAuction", "StableList_UpdateSlotData")
  registerEvent("FromClient_ServantUpdate", "StableList_UpdateSlotData")
  registerEvent("FromClient_ServantTaming", "StableList_UpdateSlotData")
  registerEvent("FromClient_GroundMouseClick", "StableList_ButtonClose")
  registerEvent("FromClient_RegisterServantFail", "StableList_PopMessageBox")
  registerEvent("FromClient_ServantSeal", "FromClient_ServantSeal")
  registerEvent("FromClient_ServantUnseal", "FromClient_ServantUnseal")
  registerEvent("FromClient_ServantToReward", "FromClient_ServantToReward")
  registerEvent("FromClient_ServantRecovery", "FromClient_ServantRecovery")
  registerEvent("FromClient_ServantChangeName", "FromClient_ServantChangeName")
  registerEvent("FromClient_ServantRegisterAuction", "FromClient_ServantRegisterAuction")
  registerEvent("FromClient_ServantCancelAuction", "FromClient_ServantCancelAuction")
  registerEvent("FromClient_ServantReceiveAuction", "FromClient_ServantReceiveAuction")
  registerEvent("FromClient_ServantBuyMarket", "FromClient_ServantBuyMarket")
  registerEvent("FromClient_ServantStartMating", "FromClient_ServantStartMating")
  registerEvent("FromClient_ServantChildMating", "FromClient_ServantChildMating")
  registerEvent("FromClient_ServantClearDeadCount", "FromClient_ServantClearDeadCount")
  registerEvent("FromClient_ServantImprint", "FromClient_ServantImprint")
  registerEvent("FromClient_ServantClearMatingCount", "FromClient_ServantClearMatingCount")
  registerEvent("FromClient_ServantLink", "FromClient_ServantLink")
  registerEvent("FromClient_ServantStartSkillTraining", "FromClient_ServantStartSkillTraining")
  registerEvent("FromClient_ServantEndSkillTraining", "FromClient_ServantEndSkillTraining")
  registerEvent("FromClient_StartStallionSkillTraining", "FromClient_StartStallionSkillTraining")
  registerEvent("FromClient_EndStallionSkillTraining", "FromClient_EndStallionSkillTraining")
  registerEvent("FromClient_IncreaseStallionSkillExpAck", "FromClient_IncreaseStallionSkillExpAck")
end
function StableList_Resize()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local self = stableList
  local panelSize = 0
  local panelBGSize = 0
  local scrollSize = 0
  local slotCount = 4
  if screenY > 1000 then
    panelSize = 700
    panelBGSize = 660
    scrollSize = 660
    slotCount = 4
    if nil ~= self._slots[3] then
      self._slots[3].button:SetShow(true)
    end
  else
    panelSize = 540
    panelBGSize = 500
    scrollSize = 500
    slotCount = 3
    if nil ~= self._slots[3] then
      self._slots[3].button:SetShow(false)
    end
  end
  Panel_Window_StableList:SetSize(Panel_Window_StableList:GetSizeX(), panelSize)
  self._staticListBG:SetSize(self._staticListBG:GetSizeX(), panelBGSize)
  self._scroll:SetSize(self._scroll:GetSizeX(), scrollSize)
  self._config.slotCount = slotCount
end
local currentButtonServantNo
function StableList_UnsealByServantNo()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  stable_unsealByServantNo(currentButtonServantNo)
  local servantInfo = stable_getContectedNpcServantByServant(currentButtonServantNo)
  if nil == servantInfo then
    return
  end
  reset_ServantHP(servantInfo:getHp())
  stableList._scroll:SetControlTop()
  _startSlotIndex = 0
end
function StableList_RegistButtonEventHandler(servantInfo)
  local self = stableList
  currentButtonServantNo = servantInfo:getServantNo()
  self._buttonUnseal:addInputEvent("Mouse_LUp", "StableList_UnsealByServantNo()")
end
local beforeSlotNo, beforeEType
function StableList_ButtonOpen(eType, slotNo)
  if Panel_AddToCarriage:GetShow() or Panel_Window_StableMix:GetShow() then
    return
  end
  local self = stableList
  if self._staticButtonListBG:GetShow() and nil ~= beforeSlotNo and beforeSlotNo == slotNo and nil ~= beforeEType and beforeEType == eType then
    self._staticButtonListBG:SetShow(false)
    return
  end
  beforeSlotNo = slotNo
  beforeEType = eType
  if Panel_Window_HorseLookChange:GetShow() then
    Panel_HorseLookChange_Close()
  end
  self._buttonRegister:SetShow(false)
  self._buttonSeal:SetShow(false)
  self._buttonCompulsionSeal:SetShow(false)
  self._buttonRecoveryUnseal:SetShow(false)
  self._buttonRepairUnseal:SetShow(false)
  self._buttonUnseal:SetShow(false)
  self._buttonRepair:SetShow(false)
  self._buttonSell:SetShow(false)
  self._buttonSupply:SetShow(false)
  self._buttonChangeName:SetShow(false)
  self._buttonRecovery:SetShow(false)
  self._buttonRelease:SetShow(false)
  self._buttonRegisterMating:SetShow(false)
  self._buttonRegisterMarket:SetShow(false)
  self._buttonReceiveChild:SetShow(false)
  self._buttonReturnMale:SetShow(false)
  self._buttonClearDeadCount:SetShow(false)
  self._buttonClearMatingCount:SetShow(false)
  self._buttonImprint:SetShow(false)
  self._buttonReleaseImprint:SetShow(false)
  self._buttonAddCarriage:SetShow(false)
  self._buttonReleaseCarriage:SetShow(false)
  self._buttonHorseLookChange:SetShow(false)
  self._buttonTrainingFinish:SetShow(false)
  self._buttonStallionTraining:SetShow(false)
  local buttonList = {}
  local buttonConfig = self._config.button
  local positionX = 0
  local positionY = 0
  local buttonSlotNo = 0
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  if eType == self._const.eTypeSealed then
    local index = StableList_SelectSlotNo()
    local servantInfo = stable_getServant(index)
    if nil == servantInfo then
      return
    end
    StableList_RegistButtonEventHandler(servantInfo)
    local vehicleType = servantInfo:getVehicleType()
    local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType()
    local servantRegionName = servantInfo:getRegionName(index)
    local servantLevel = servantInfo:getLevel()
    local getState = servantInfo:getStateType()
    local isPcroomOnly = servantInfo:isPcroomOnly()
    local stable = CppEnums.ServantStateType.Type_Stable
    local nowMating = CppEnums.ServantStateType.Type_Mating
    local regMarket = CppEnums.ServantStateType.Type_RegisterMarket
    local regMating = CppEnums.ServantStateType.Type_RegisterMating
    local training = CppEnums.ServantStateType.Type_SkillTraining
    local stallionTraining = CppEnums.ServantStateType.Type_StallionTraining
    if isSiegeStable() then
      buttonList[buttonSlotNo] = self._buttonUnseal
      buttonSlotNo = buttonSlotNo + 1
    elseif regionName == servantRegionName then
      audioPostEvent_SystemUi(1, 0)
      if isLinkedHorse and stallionTraining ~= getState then
        buttonList[buttonSlotNo] = self._buttonReleaseCarriage
        buttonSlotNo = buttonSlotNo + 1
        positionX = self._slots[slotNo].button:GetPosX() + buttonConfig.startX
        positionY = self._slots[slotNo].button:GetPosY() + buttonConfig.startY + 30
      else
        if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
          if nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
            buttonList[buttonSlotNo] = self._buttonUnseal
            buttonSlotNo = buttonSlotNo + 1
          end
        else
          buttonList[buttonSlotNo] = self._buttonUnseal
          buttonSlotNo = buttonSlotNo + 1
        end
        if (servantInfo:getHp() < servantInfo:getMaxHp() or servantInfo:getMp() < servantInfo:getMaxMp()) and (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_MountainGoat == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType) and not servantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonRecovery
          buttonSlotNo = buttonSlotNo + 1
        else
        end
        if CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
          if servantInfo:getHp() < servantInfo:getMaxHp() or servantInfo:getMp() < servantInfo:getMaxMp() then
            buttonList[buttonSlotNo] = self._buttonRepair
            buttonSlotNo = buttonSlotNo + 1
          end
        elseif (CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType) and servantInfo:getHp() < servantInfo:getMaxHp() and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonRepair
          buttonSlotNo = buttonSlotNo + 1
        end
        if not servantInfo:isMatingComplete() or stallionTraining == getState or servantInfo:isMale() then
        else
          buttonList[buttonSlotNo] = self._buttonReceiveChild
          buttonSlotNo = buttonSlotNo + 1
        end
        if stable_isMarket() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType) and regionName == servantRegionName then
          buttonList[buttonSlotNo] = self._buttonRegisterMarket
          buttonSlotNo = buttonSlotNo + 1
        end
        if stable_isMating() and servantInfo:doMating() and servantInfo:isMale() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState and CppEnums.ServantStateType.Type_Stable == servantInfo:getStateType() and regionName == servantRegionName then
          buttonList[buttonSlotNo] = self._buttonRegisterMating
          buttonSlotNo = buttonSlotNo + 1
        end
        if false == isPcroomOnly and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and FGlobal_IsCommercialService() and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonChangeName
          buttonSlotNo = buttonSlotNo + 1
        end
        if false == isPcroomOnly then
          if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant and stallionTraining ~= getState then
            self._buttonClearDeadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET"))
          elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Carriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_CowCarriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage and stallionTraining ~= getState then
            self._buttonClearDeadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_DESTROYCOUNTRESET"))
          elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Boat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Raft or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_FishingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_SailingBoat and stallionTraining ~= getState then
            self._buttonClearDeadCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_DESTROYCOUNTRESET"))
          end
          if nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and FGlobal_IsCommercialService() and stallionTraining ~= getState then
            buttonList[buttonSlotNo] = self._buttonClearDeadCount
            buttonSlotNo = buttonSlotNo + 1
          end
        end
        if servantInfo:doClearCountByMating() and servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse and training ~= getState and FGlobal_IsCommercialService() and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonClearMatingCount
          buttonSlotNo = buttonSlotNo + 1
        end
        if false == isPcroomOnly and servantInfo:doImprint() and FGlobal_IsCommercialService() and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonImprint
          buttonSlotNo = buttonSlotNo + 1
        end
        if false == isPcroomOnly and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and regionName == servantRegionName and isContentsEnable and stallionTraining ~= getState then
          buttonList[buttonSlotNo] = self._buttonHorseLookChange
          buttonSlotNo = buttonSlotNo + 1
          self._buttonHorseLookChange:addInputEvent("Mouse_LUp", "StableList_LookChange(" .. slotNo .. ")")
        end
        if false == isPcroomOnly then
          if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType and stallionTraining ~= getState then
            if nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState then
              if stable_isMarket() and servantLevel >= 15 and CppEnums.VehicleType.Type_Horse == vehicleType and isContentsEnableSupply then
                buttonList[buttonSlotNo] = self._buttonSupply
                buttonSlotNo = buttonSlotNo + 1
              elseif stallionTraining ~= getState then
                buttonList[buttonSlotNo] = self._buttonRelease
                buttonSlotNo = buttonSlotNo + 1
              end
            end
          else
            buttonList[buttonSlotNo] = self._buttonSell
            buttonSlotNo = buttonSlotNo + 1
          end
        end
        if CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType() and true == servantInfo:isStallion() and stable_isPossibleStallionSkillExpTraining() and isContentsStallionEnable and isContentsNineTierEnable and 30 == servantInfo:getLevel() and 8 == servantInfo:getTier() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState then
          buttonList[buttonSlotNo] = self._buttonStallionTraining
          buttonSlotNo = buttonSlotNo + 1
        end
      end
    elseif not isLinkedHorse and 0 == servantInfo:getHp() and (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_MountainGoat == vehicleType) and not servantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState and training ~= getState and stallionTraining ~= getState then
      buttonList[buttonSlotNo] = self._buttonRecovery
      buttonSlotNo = buttonSlotNo + 1
      buttonList[buttonSlotNo] = self._buttonUnseal
      buttonSlotNo = buttonSlotNo + 1
    end
    if stable_isSkillExpTrainingComplete(index) then
      buttonList[buttonSlotNo] = self._buttonTrainingFinish
      self._buttonTrainingFinish:addInputEvent("Mouse_LUp", "StableList_TrainFinish(" .. index .. ")")
      buttonSlotNo = buttonSlotNo + 1
    elseif isContentsStallionEnable and stable_isEndStallionSkillExpTraining(index) and isContentsNineTierEnable then
      buttonList[buttonSlotNo] = self._buttonTrainingFinish
      self._buttonTrainingFinish:addInputEvent("Mouse_LUp", "StableList_StallionTrainFinish(" .. index .. ")")
      buttonSlotNo = buttonSlotNo + 1
    end
    positionX = self._slots[slotNo].button:GetPosX() + buttonConfig.startX
    positionY = self._slots[slotNo].button:GetPosY() + buttonConfig.startY + 20
  elseif eType == self._const.eTypeUnsealed then
    if false == isSiegeStable() then
      stableList:clear()
      for ii = 0, self._config.slotCount - 1 do
        self._slots[ii].effect:SetShow(false)
      end
      self._unseal._effect:SetShow(true)
      self._taming._effect:SetShow(false)
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil == temporaryWrapper then
        return
      end
      local unSealServantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
      local vehicleType = unSealServantInfo:getVehicleType()
      local getState = unSealServantInfo:getStateType()
      local nowMating = CppEnums.ServantStateType.Type_Mating
      local regMarket = CppEnums.ServantStateType.Type_RegisterMarket
      local regMating = CppEnums.ServantStateType.Type_RegisterMating
      buttonList[buttonSlotNo] = self._buttonSeal
      buttonSlotNo = buttonSlotNo + 1
      buttonList[buttonSlotNo] = self._buttonCompulsionSeal
      buttonSlotNo = buttonSlotNo + 1
      if (unSealServantInfo:getHp() < unSealServantInfo:getMaxHp() or unSealServantInfo:getMp() < unSealServantInfo:getMaxMp()) and (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_MountainGoat == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType) and not unSealServantInfo:isMatingComplete() and nowMating ~= getState and regMarket ~= getState and regMating ~= getState then
        buttonList[buttonSlotNo] = self._buttonRecoveryUnseal
        buttonSlotNo = buttonSlotNo + 1
      end
      if CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
        if unSealServantInfo:getHp() < unSealServantInfo:getMaxHp() or unSealServantInfo:getMp() < unSealServantInfo:getMaxMp() then
          buttonList[buttonSlotNo] = self._buttonRepairUnseal
          buttonSlotNo = buttonSlotNo + 1
        end
      elseif (CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType) and unSealServantInfo:getHp() < unSealServantInfo:getMaxHp() then
        buttonList[buttonSlotNo] = self._buttonRepairUnseal
        buttonSlotNo = buttonSlotNo + 1
      end
      positionX = self._unseal._bg:GetPosX() + buttonConfig.startX + 20
      positionY = self._unseal._bg:GetPosY() + buttonConfig.startY
      FGlobal_StableList_UnsealInfo(1)
    end
  else
    stableList:clear()
    for ii = 0, self._config.slotCount - 1 do
      self._slots[ii].effect:SetShow(false)
    end
    self._unseal._effect:SetShow(false)
    self._taming._effect:SetShow(true)
    buttonList[buttonSlotNo] = self._buttonRegister
    buttonSlotNo = buttonSlotNo + 1
    positionX = self._taming._bg:GetPosX() + buttonConfig.startX + 30
    positionY = self._taming._bg:GetPosY() + buttonConfig.startY
  end
  local sizeX = self._staticButtonListBG:GetSizeX()
  local sizeY = buttonConfig.sizeYY
  for index, button in pairs(buttonList) do
    button:SetShow(true)
    button:SetPosX(buttonConfig.startButtonX)
    button:SetPosY(buttonConfig.startButtonY + buttonConfig.gapY * index)
    sizeY = sizeY + buttonConfig.sizeY
  end
  if 0 ~= buttonSlotNo then
    self._staticButtonListBG:SetPosX(positionX)
    self._staticButtonListBG:SetPosY(positionY)
    self._staticButtonListBG:SetSize(sizeX, sizeY)
    self._staticButtonListBG:SetShow(true)
  else
    self._staticButtonListBG:SetShow(false)
  end
end
function StableList_ButtonClose()
  local self = stableList
  if not self._staticButtonListBG:GetShow() then
    return false
  end
  self._staticButtonListBG:SetShow(false)
  Panel_HorseLookChange_Close()
  return false
end
function StableList_SlotSelect(slotNo)
  if Panel_Window_StableStallion_Effect:GetShow() then
    return
  end
  if Panel_Window_StableStallion:GetShow() then
    return
  end
  if nil == slotNo then
    return
  end
  if stable_WindowOpenCheck() or not Panel_Window_StableList:GetShow() then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  local self = stableList
  if slotNo >= self._config.slotCount then
    self._startSlotIndex = slotNo - self._config.slotCount
    self:update()
    return
  end
  if -1 == self._slots[slotNo].index then
    return
  end
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii].effect:SetShow(false)
  end
  self._unseal._effect:SetShow(false)
  self._taming._effect:SetShow(false)
  self._slots[slotNo].effect:SetShow(true)
  self._selectSlotNo = self._slots[slotNo].index
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  self._selectSceneIndex = Servant_ScenePushObject(servantInfo, self._selectSceneIndex)
  if nil ~= servantInfo:getActionIndex() then
    showSceneCharacter(self._selectSceneIndex, false)
    showSceneCharacter(self._selectSceneIndex, true, servantInfo:getActionIndex())
  end
  StableInfo_Open()
  StableList_ButtonOpen(self._const.eTypeSealed, slotNo)
end
function StableList_CharacterSceneReset(slotNo)
  local self = stableList
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  self._selectSceneIndex = Servant_ScenePushObject(servantInfo, self._selectSceneIndex)
  if nil ~= servantInfo:getActionIndex() then
    showSceneCharacter(self._selectSceneIndex, false)
    showSceneCharacter(self._selectSceneIndex, true, servantInfo:getActionIndex())
  end
end
function StableList_CharacterSceneResetServantNo(servantNo)
  local self = stableList
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  self._selectSceneIndex = Servant_ScenePushObject(servantInfo, self._selectSceneIndex)
  if nil ~= servantInfo:getActionIndex() then
    showSceneCharacter(self._selectSceneIndex, false)
    showSceneCharacter(self._selectSceneIndex, true, servantInfo:getActionIndex())
  end
end
function StableList_Mix(slotNo)
  local self = stableList
  if nil == slotNo then
    return
  end
  if -1 == self._slots[slotNo].index then
    return
  end
  local sortIndex = stable_SortByWayPointKey(self._slots[slotNo].index)
  local servantInfo = stable_getServant(sortIndex)
  if nil == servantInfo then
    return
  end
  if servantInfo:isSeized() or CppEnums.ServantStateType.Type_RegisterMarket == servantInfo:getStateType() or CppEnums.ServantStateType.Type_RegisterMating == servantInfo:getStateType() or CppEnums.ServantStateType.Type_Mating == servantInfo:getStateType() or servantInfo:isMatingComplete() or CppEnums.ServantStateType.Type_Coma == servantInfo:getStateType() or CppEnums.ServantStateType.Type_SkillTraining == servantInfo:getStateType() or servantInfo:isLink() then
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  local servantRegionName = servantInfo:getRegionName(sortIndex)
  if regionName ~= servantRegionName then
    return
  end
  if Panel_AddToCarriage:GetShow() then
    stableCarriage_Set(sortIndex)
    return
  end
  if not Panel_Window_StableMix:GetShow() then
    return
  end
  local function doMixServant()
    StableMix_Set(sortIndex)
  end
  local matingCount = servantInfo:getMatingCount()
  if matingCount > 0 then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SELECTSERVANT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_EXCHANGE_CONFIRM"),
      content = messageBoxMemo,
      functionYes = doMixServant,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    doMixServant()
  end
end
function StableList_Seal(isCompulsion)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local function seal_Go()
    stable_seal(isCompulsion)
  end
  if isCompulsion then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_ISCOMPULSION_MESSAGEBOX")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionYes = seal_Go,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    seal_Go()
  end
end
function StableList_Unseal()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  stable_unseal(StableList_SelectSlotNo())
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  reset_ServantHP(servantInfo:getHp())
  stableList._scroll:SetControlTop()
  _startSlotIndex = 0
end
function StableList_RecoveryUnseal()
  StableList_ButtonClose()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
  if nil == servantWrapper then
    return
  end
  local imprintMoney = makeDotMoney(servantWrapper:getRecoveryOriginalCost_s64())
  local needMoney = makeDotMoney(servantWrapper:getRecoveryCost_s64())
  if servantWrapper:getRecoveryOriginalCost_s64() <= Defines.s64_const.s64_1 then
    return
  end
  if servantWrapper:isImprint() then
    if servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
      Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    else
      Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    end
  elseif servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_NOT")
  elseif servantWrapper:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney)
  else
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney)
  end
  local RecoveryUnseal = function()
    StableList_RecoveryUnsealXXX()
  end
  local vehicleType = servantWrapper:getVehicleType()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_TITLE"),
    content = Imprint_Notify_Title,
    functionApply = RecoveryUnseal,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBox(messageBoxData)
  stableList._scroll:SetControlTop()
  _startSlotIndex = 0
end
function StableList_RecoveryUnsealXXX()
  audioPostEvent_SystemUi(5, 7)
  stable_recoveryUnseal(MessageBoxCheck.isCheck())
end
function StableList_Recovery()
  StableList_ButtonClose()
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  local needMoney = 0
  local confirmFunction
  local vehicleType = servantInfo:getVehicleType()
  local servantHp = servantInfo:getHp()
  if 0 == servantHp then
    imprintMoney = makeDotMoney(servantInfo:getReviveOriginalCost_s64())
    needMoney = makeDotMoney(servantInfo:getReviveCost_s64())
    confirmFunction = StableList_ReviveXXX
  else
    imprintMoney = makeDotMoney(servantInfo:getRecoveryOriginalCost_s64())
    needMoney = makeDotMoney(servantInfo:getRecoveryCost_s64())
    confirmFunction = StableList_RecoveryXXX
  end
  if servantInfo:isImprint() then
    if vehicleType == CppEnums.VehicleType.Type_RepairableCarriage then
      Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    else
      Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_DISCOUNT", "needMoney", needMoney)
    end
  elseif vehicleType == CppEnums.VehicleType.Type_Horse or vehicleType == CppEnums.VehicleType.Type_Camel or vehicleType == CppEnums.VehicleType.Type_Donkey or vehicleType == CppEnums.VehicleType.Type_Elephant then
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney) .. PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_NOT")
  elseif vehicleType == CppEnums.VehicleType.Type_RepairableCarriage then
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REPAIRABLECARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney)
  else
    Imprint_Notify_Title = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_MSG", "needMoney", imprintMoney)
  end
  local Recovery_Notify_Title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_RECOVERY_NOTIFY_TITLE")
  if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType or CppEnums.VehicleType.Type_Boat == vehicleType or CppEnums.VehicleType.Type_Raft == vehicleType then
    local messageData = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_CARRIAGE_RECOVERY_NOTIFY_MSG", "needMoney", needMoney)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageData,
      functionApply = confirmFunction,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBoxCheck.showMessageBox(messageBoxData)
  else
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = Imprint_Notify_Title,
      functionApply = confirmFunction,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBoxCheck.showMessageBox(messageBoxData)
  end
end
function StableList_RecoveryXXX()
  audioPostEvent_SystemUi(5, 7)
  stable_recovery(StableList_SelectSlotNo(), MessageBoxCheck.isCheck())
  StableInfo_Open()
end
function StableList_ReviveXXX()
  audioPostEvent_SystemUi(5, 7)
  stable_revive(StableList_SelectSlotNo(), MessageBoxCheck.isCheck())
  StableInfo_Open()
end
function StableList_SellToNpc()
  StableList_ButtonClose()
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  Servant_Confirm(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_MSG", "resultMoney", resultMoney) .. servantInvenAlert, StableList_ReleaseXXX, MessageBox_Empty_function)
end
function StableList_SupplyToNpc()
  StableList_ButtonClose()
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  local title = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_BTN_SUPPLY")
  local content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABLE_SUPPLY", "resultMoney", resultMoney) .. servantInvenAlert
  Servant_Confirm(title, content, StableList_SellToNpcXXX, MessageBox_Empty_function)
end
function StableList_SellToNpcXXX()
  stable_changeToReward(StableList_SelectSlotNo(), CppEnums.ServantToRewardType.Type_Money)
  sellCheck = true
end
function StableList_Release()
  StableList_ButtonClose()
  local servantInfo = stable_getServant(StableList_SelectSlotNo())
  if nil == servantInfo then
    return
  end
  local resultMoney = makeDotMoney(servantInfo:getSellCost_s64())
  if servantInfo:isPcroomOnly() then
    resultMoney = 0
  end
  Servant_Confirm(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_TITLE"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_SELL_NOTIFY_MSG", "resultMoney", resultMoney) .. servantInvenAlert, StableList_ReleaseXXX, MessageBox_Empty_function)
end
function StableList_ReleaseXXX()
  stable_changeToReward(StableList_SelectSlotNo(), CppEnums.ServantToRewardType.Type_Experience)
  sellCheck = true
end
function StableList_ChangeName()
  StableList_ButtonClose()
  local executeChangeName = function()
    StableRegister_OpenByEventType(CppEnums.ServantRegist.eEventType_ChangeName)
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_POPMSGBOX_CHANGENAME_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = executeChangeName,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function StableList_RegisterMating()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  Servant_Confirm(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMATING_NOTIFY_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMATING_NOTIFY_MSG"), StableList_RegisterMatingXXX, MessageBox_Empty_function)
end
function StableList_RegisterMatingXXX()
  local slotNo = StableList_SelectSlotNo()
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  StableRegister_OpenByEventType(CppEnums.ServantRegist.eEventType_RegisterMating)
end
function StableList_RegisterMatingXXXXX(s64_inputNumber, slotNo)
  stable_registerServantToSomeWhereElse(StableList_SelectSlotNo(), CppEnums.AuctionType.AuctionGoods_ServantMating, StableRegister_GetTransferType(), s64_inputNumber)
end
function StableList_RegisterMarket()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  Servant_Confirm(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMARKET_NOTIFY_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STABEL_REGISTERMARKET_NOTIFY_MSG"), StableList_RegisterMarketXXX, MessageBox_Empty_function)
end
function StableList_RegisterMarketXXX()
  local slotNo = StableList_SelectSlotNo()
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  StableRegister_OpenByEventType(CppEnums.ServantRegist.eEventType_RegisterMarket)
end
function StableList_RegisterMarketXXXXXX(s64_inputNumber, slotNo)
  stable_registerServantToSomeWhereElse(StableList_SelectSlotNo(), CppEnums.AuctionType.AuctionGoods_ServantMarket, CppEnums.TransferType.TransferType_Normal, s64_inputNumber)
end
function StableList_RegisterCancel()
  StableList_ButtonClose()
  StableMating_Cancel(StableList_SelectSlotNo())
end
function StableList_RegisterFromTaming()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  StableRegister_OpenByTaming()
  Panel_FrameLoop_Widget:SetShow(false)
end
function StableList_ReceiveChildServant()
  StableList_ButtonClose()
  stable_getServantMatingChildInfo(StableList_SelectSlotNo())
end
function StableList_ClearDeadCount()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local clearDeadCountDo = function()
    stable_clearDeadCount(StableList_SelectSlotNo())
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET_ALLRECOVERY")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = clearDeadCountDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function StableList_ClearMatingCount()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local clearMatingCountDo = function()
    stable_clearMatingCount(StableList_SelectSlotNo())
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MATINGCOUNTRESET")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = clearMatingCountDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function StableList_Imprint(isImprint)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local function imprint()
    stable_imprint(StableList_SelectSlotNo(), isImprint)
  end
  if false == isImprint then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_ISIMPRINT_RECOVERY")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_STAMPING_IS_DISCOUNT")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = imprint,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function StableList_AddToCarriage()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  stableCarriage_Set(slotNo)
end
function StableList_Unlink()
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  local carriageNo = servantInfo:getOwnerServantNo_s64()
  local carriageCheck = false
  for index = 0, stable_count() - 1 do
    local sInfo = stable_getServant(index)
    local sNo = sInfo:getServantNo()
    if carriageNo == sNo then
      ReleaseFromCarriage(slotNo, index)
      carriageCheck = true
    end
  end
  if false == carriageCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CARRIAGE_CANCEL"))
  end
end
function StableList_LookChange(index)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  Panel_HorseLookChange_Open()
  stableList._comboBox:SetSelectItemIndex(0)
  Set_LookChange()
end
function StableList_TrainFinish(index)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  stable_endServantSkillExpTraining(index)
end
function StableList_StartStallionTraining()
  if not isContentsStallionEnable and not isContentsNineTierEnable then
    return
  end
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  local servantNo = servantInfo:getServantNo()
  if CppEnums.ServantStateType.Type_StallionTraining == servantInfo:getStateType() then
    StableStallion_Open(servantNo)
    ItemNotify_Open()
    return
  end
  ToClient_startStallionSkillExpTraining(servantNo)
end
function FromClient_StartStallionSkillTraining(servantNo)
  Panel_Window_StableStallion:SetShow(true)
end
function StableList_StallionTrainFinish(index)
  StableList_ButtonClose()
  audioPostEvent_SystemUi(0, 0)
  stable_endStallionSkillExpTraining(index)
end
local lookIndex = 0
local beforeActionIndex = -1
local currentPage = 0
function HorseLookChange_Set(isNext, index)
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  local self = stableList
  local servantActionIndex = servantInfo:getActionIndex()
  local tierIndex = stableList._comboBox:GetSelectIndex()
  local formManager = getServantFormManager()
  local lookCount = 1
  if nil ~= isNext then
    currentPage = currentPage + isNext
  end
  if nil == index then
    index = 0
  end
  lookIndex = currentPage * self._lookChangeMaxSlotCount + index
  if tierIndex > 0 then
    lookCount = formManager:getFormTierSize(tierIndex)
  else
    lookCount = formManager:getFormTierSize(0) + 1
  end
  local maxPage = math.ceil(lookCount / self._lookChangeMaxSlotCount)
  if maxPage > 1 then
    self._textPage:SetText("( " .. currentPage + 1 .. " / " .. maxPage .. " )")
    self._textPage:SetShow(true)
  else
    self._textPage:SetShow(false)
  end
  local showCount = 1
  if maxPage - currentPage - 1 > 0 then
    showCount = self._lookChangeMaxSlotCount
    self._btnRight:SetShow(true)
  else
    local leftCount = lookCount % self._lookChangeMaxSlotCount
    if 0 == leftCount then
      showCount = self._lookChangeMaxSlotCount
    else
      showCount = leftCount
    end
    self._btnRight:SetShow(false)
  end
  if currentPage > 0 then
    self._btnLeft:SetShow(true)
  else
    self._btnLeft:SetShow(false)
  end
  local function lookChangeSlotInit()
    for ii = 1, self._lookChangeMaxSlotCount do
      lookChangeSlot[ii]:SetShow(false)
    end
  end
  lookChangeSlotInit()
  local formInfo
  if showCount > 0 then
    for ii = 1, showCount do
      lookChangeSlot[ii]:SetShow(true)
      if tierIndex > 0 then
        formInfo = formManager:getFormTierStaticWrapper(tierIndex, currentPage * self._lookChangeMaxSlotCount + ii - 1)
        lookChangeSlot[ii]:ChangeTextureInfoName(formInfo:getIcon1())
        self._textCurrentLook:SetShow(false)
      elseif lookCount == currentPage * self._lookChangeMaxSlotCount + ii then
        lookChangeSlot[ii]:ChangeTextureInfoName(servantInfo:getBaseIconPath1())
        self._textCurrentLook:SetShow(true)
        self._textCurrentLook:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_BASELOOK"))
        self._textCurrentLook:SetPosX(lookChangeSlot[ii]:GetPosX() + lookChangeSlot[ii]:GetSizeX() - self._textCurrentLook:GetTextSizeX())
      else
        formInfo = formManager:getFormTierStaticWrapper(0, currentPage * self._lookChangeMaxSlotCount + ii - 1)
        lookChangeSlot[ii]:ChangeTextureInfoName(formInfo:getIcon1())
        self._textCurrentLook:SetShow(false)
      end
    end
  end
  self._LCSelectSlot:SetShow(true)
  self._LCSelectSlot:SetPosX(lookChangeSlot[index + 1]:GetPosX() - 5)
  self._LCSelectSlot:SetPosY(lookChangeSlot[index + 1]:GetPosY())
  if nil ~= formInfo then
    if tierIndex > 0 then
      formInfo = formManager:getFormTierStaticWrapper(tierIndex, currentPage * self._lookChangeMaxSlotCount + index)
    else
      formInfo = formManager:getFormTierStaticWrapper(0, currentPage * self._lookChangeMaxSlotCount + index)
    end
    Servant_ScenePopObject(self._selectSceneIndex)
    local actionIndex = formInfo:getActionIndex()
    if servantActionIndex == actionIndex then
      self._btnChange:SetIgnore(true)
      self._btnChange:SetMonoTone(true)
      self._btnPremium:SetIgnore(true)
      self._btnPremium:SetMonoTone(true)
    else
      self._btnChange:SetIgnore(false)
      self._btnChange:SetMonoTone(false)
      self._btnPremium:SetIgnore(false)
      self._btnPremium:SetMonoTone(false)
    end
    if -1 ~= beforeActionIndex then
      showSceneCharacter(self._selectSceneIndex, false, beforeActionIndex)
    end
    showSceneCharacter(self._selectSceneIndex, true, actionIndex)
    beforeActionIndex = actionIndex
  else
    Servant_ScenePopObject(self._selectSceneIndex)
    local actionIndex = servantInfo:getBaseActionIndex()
    if servantActionIndex == actionIndex then
      self._btnChange:SetIgnore(true)
      self._btnChange:SetMonoTone(true)
      self._btnPremium:SetIgnore(true)
      self._btnPremium:SetMonoTone(true)
    else
      self._btnChange:SetIgnore(false)
      self._btnChange:SetMonoTone(false)
      self._btnPremium:SetIgnore(false)
      self._btnPremium:SetMonoTone(false)
    end
    if -1 ~= beforeActionIndex then
      showSceneCharacter(self._selectSceneIndex, false, beforeActionIndex)
    end
    showSceneCharacter(self._selectSceneIndex, true, actionIndex)
    beforeActionIndex = actionIndex
  end
  local isPossibleLearnSkill = stable_isPossibleLearnServantSkill(slotNo)
  if 30 == servantInfo:getLevel() and not isPossibleLearnSkill then
    stableList._btnPremium:SetIgnore(true)
    stableList._btnPremium:SetMonoTone(true)
  end
end
function HandleClicked_LookSlot(index)
  HorseLookChange_Set(nil, index)
end
function HandleClicked_LookCombo()
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local servantInfo = stable_getServant(slotNo)
  if nil == servantInfo then
    return
  end
  local servantTier = servantInfo:getTier()
  local self = stableList
  self._comboBox:DeleteAllItem()
  self._comboBox:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL"), 0)
  if servantTier > 1 then
    for tierIndex = 1, servantTier - 1 do
      self._comboBox:AddItem(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL_TIER", "tierIndex", tierIndex), tierIndex)
    end
  end
  self._comboBox:ToggleListbox()
end
function Set_LookChange()
  local tierIndex = stableList._comboBox:GetSelectIndex()
  if tierIndex <= 0 then
    stableList._comboBox:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL"))
  else
    stableList._comboBox:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOKCHANGE_SPECIAL_TIER", "tierIndex", tierIndex))
  end
  stableList._comboBox:ToggleListbox()
  currentPage = 0
  HorseLookChange_Set()
end
function HorseLookChange_ChangeConfirm()
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local formManager = getServantFormManager()
  local formIndex
  local tierIndex = stableList._comboBox:GetSelectIndex()
  if tierIndex <= 0 then
    tierIndex = 0
  end
  lookCount = formManager:getFormTierSize(tierIndex)
  if lookIndex < lookCount then
    local formInfo = formManager:getFormTierStaticWrapper(tierIndex, lookIndex)
    if nil == formInfo then
      return
    end
    formIndex = formInfo:getIndexRaw()
  else
    local servantInfo = stable_getServant(slotNo)
    if nil == servantInfo then
      return
    end
    formIndex = 0
  end
  local function changeConfirm()
    stable_changeForm(slotNo, formIndex, 0)
    stableList:update()
    Panel_HorseLookChange_Close()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_TITLE"),
    content = messageBoxMemo,
    functionYes = changeConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HorseLookChange_PremiumChangeConfirm()
  local slotNo = StableList_SelectSlotNo()
  if nil == slotNo then
    return
  end
  local isPossibleLearnSkill = stable_isPossibleLearnServantSkill(slotNo)
  local formManager = getServantFormManager()
  local formIndex
  local tierIndex = stableList._comboBox:GetSelectIndex()
  if tierIndex <= 0 then
    tierIndex = 0
  end
  lookCount = formManager:getFormTierSize(tierIndex)
  if lookIndex < lookCount then
    local formInfo = formManager:getFormTierStaticWrapper(tierIndex, lookIndex)
    if nil == formInfo then
      return
    end
    formIndex = formInfo:getIndexRaw()
  else
    local servantInfo = stable_getServant(slotNo)
    if nil == servantInfo then
      return
    end
    formIndex = 0
  end
  local function changeConfirm()
    stable_changeForm(slotNo, formIndex, 1, isPossibleLearnSkill)
    stableList:update()
    Panel_HorseLookChange_Close()
  end
  local function isContinueLookChange()
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_PREMIUMCHANGEALERT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_TITLE"),
      content = messageBoxMemo,
      functionYes = changeConfirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  local yesFunction
  if isPossibleLearnSkill then
    yesFunction = changeConfirm
  else
    yesFunction = isContinueLookChange
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_PREMIUMCHANGECONFIRM_MEMO")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_TITLE"),
    content = messageBoxMemo,
    functionYes = yesFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FGlobal_StableList_Update()
  stableList:update()
end
function StableList_SelectSlotNo()
  local self = stableList
  return (stable_SortByWayPointKey(self._selectSlotNo))
end
function StableList_ScrollEvent(isScrollUp)
  local self = stableList
  local servantCount = stable_count()
  local linkedHorseCount = 0
  for ii = 0, servantCount - 1 do
    local servantInfo = stable_getServant(ii)
    if nil ~= servantInfo then
      local isLinkedHorse = servantInfo:isLink() and CppEnums.VehicleType.Type_Horse == servantInfo:getVehicleType()
      if isLinkedHorse then
        linkedHorseCount = linkedHorseCount + 1
      end
    end
  end
  self._startSlotIndex = UIScroll.ScrollEvent(self._scroll, isScrollUp, self._config.slotCount, servantCount, self._startSlotIndex, 1)
  self:update()
  StableList_ButtonClose()
end
function Stable_SlotSound(slotNo)
  if isFirstSlot == true then
    StableList_SlotLClick(slotNo)
    isFirstSlot = false
  else
    audioPostEvent_SystemUi(1, 0)
    StableList_SlotLClick(slotNo)
  end
end
function stable_WindowOpenCheck()
  if Panel_Win_System:GetShow() or Panel_Window_StableRegister:GetShow() or Panel_Servant_Market_Input:GetShow() then
    return true
  end
  return false
end
local sortByExploreKey = {}
function stableList_ServantCountInit(nums)
  sortByExploreKey = {}
  for i = 1, nums do
    sortByExploreKey[i] = {
      _index = nil,
      _servantNo = nil,
      _exploreKey = nil
    }
  end
end
function stable_SortDataupdate()
  local maxStableServantCount = stable_count()
  stableList_ServantCountInit(maxStableServantCount)
  for ii = 1, maxStableServantCount do
    local servantInfo = stable_getServant(ii - 1)
    if nil ~= servantInfo then
      local regionKey = servantInfo:getRegionKeyRaw()
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      sortByExploreKey[ii]._index = ii - 1
      sortByExploreKey[ii]._servantNo = servantInfo:getServantNo()
      sortByExploreKey[ii]._exploreKey = regionInfoWrapper:getExplorationKey()
    end
  end
  local sortExplaoreKey = function(a, b)
    return a._exploreKey < b._exploreKey
  end
  table.sort(sortByExploreKey, sortExplaoreKey)
  local myRegionKey = getSelfPlayer():getRegionKey():get()
  local myRegionInfoWrapper = getRegionInfoWrapper(myRegionKey)
  local myWayPointKey = myRegionInfoWrapper:getExplorationKey()
  local matchCount = 0
  local temp = {}
  for i = 1, maxStableServantCount do
    if myWayPointKey == sortByExploreKey[i]._exploreKey then
      temp[matchCount] = sortByExploreKey[i]
      matchCount = matchCount + 1
    end
  end
  for i = 1, maxStableServantCount do
    if myWayPointKey ~= sortByExploreKey[i]._exploreKey then
      temp[matchCount] = sortByExploreKey[i]
      matchCount = matchCount + 1
    end
  end
  for i = 1, maxStableServantCount do
    sortByExploreKey[i] = temp[i - 1]
  end
  local affiliatedTerritory = function(exploerKey)
    local territoryKey = -1
    if exploerKey > 0 and exploerKey <= 300 then
      territoryKey = 0
    elseif exploerKey > 300 and exploerKey <= 600 then
      territoryKey = 1
    elseif exploerKey > 600 and exploerKey <= 1100 then
      territoryKey = 2
    elseif exploerKey > 1100 and exploerKey <= 1300 then
      territoryKey = 3
    elseif exploerKey > 1300 then
      territoryKey = 4
    end
    return territoryKey
  end
  local sIndex = 0
  local function sortByTerritory(territoryKey)
    for servantIndex = 1, maxStableServantCount do
      if affiliatedTerritory(sortByExploreKey[servantIndex]._exploreKey) == territoryKey then
        temp[sIndex] = sortByExploreKey[servantIndex]
        sIndex = sIndex + 1
      end
    end
  end
  local myTerritoriKey = affiliatedTerritory(myWayPointKey)
  if 0 == myTerritoriKey then
    sortByTerritory(0)
    sortByTerritory(1)
    sortByTerritory(2)
    sortByTerritory(3)
  elseif 1 == myTerritoriKey then
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(2)
    sortByTerritory(3)
  elseif 2 == myTerritoriKey then
    sortByTerritory(2)
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(3)
  elseif 3 == myTerritoriKey then
    sortByTerritory(3)
    sortByTerritory(1)
    sortByTerritory(0)
    sortByTerritory(2)
  end
  for i = 1, maxStableServantCount do
    sortByExploreKey[i] = temp[i - 1]
  end
end
function stable_SortByWayPointKey(index)
  if nil == index then
    return nil
  else
    return sortByExploreKey[index + 1]._index
  end
end
function StableList_UpdateSlotData()
  if not Panel_Window_StableList:GetShow() then
    return
  end
  local self = stableList
  self:clear()
  self:update()
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii].effect:SetShow(false)
  end
  StableInfo_Close()
  if nil == StableList_SelectSlotNo() then
    StableInfo_Open(1)
  else
    StableInfo_Open()
  end
  StableEquipInfo_Close()
  StableList_ButtonClose()
  StableList_ScrollEvent(true)
end
function StableList_PopMessageBox(possibleTime_s64)
  local stringText = convertStringFromDatetime(possibleTime_s64)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_POPMSGBOX_MEMO", "stringText", stringText)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_ServantSeal(servantNo, regionKey, servantWhereType)
  if not Panel_Window_StableList:GetShow() then
    return
  end
  if UI_SW.ServantWhereTypeUser ~= servantWhereType and UI_SW.ServantWhereTypePcRoom ~= servantWhereType then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
  if nil == servantInfo then
    return
  end
  stableList:clear()
  StableList_UpdateSlotData()
  FGlobal_Window_Servant_ColorBlindUpdate()
  StableList_SlotSelect(0)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GIVE_SERVANT_ACK"))
end
function FromClient_ServantUnseal(servantNo, servantWhereType)
  if not Panel_Window_StableList:GetShow() then
    return
  end
  if UI_SW.ServantWhereTypeUser ~= servantWhereType and UI_SW.ServantWhereTypePcRoom ~= servantWhereType then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
  if nil == servantInfo then
    return
  end
  FGlobal_Window_Servant_ColorBlindUpdate()
  if Panel_Window_StableList:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GET_SERVANT_ACK"))
  end
end
function FromClient_ServantToReward(servantNo, servantWhereType)
  if not Panel_Window_StableList:GetShow() then
    return
  end
  if UI_SW.ServantWhereTypeUser ~= servantWhereType then
    return
  end
  Servant_ScenePopObject(self._selectSceneIndex)
  if sellCheck == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SELL_SERVANT_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOSE_SERVANT_ACK"))
  end
end
function FromClient_ServantRecovery(servantNo, servantWhereType)
  if UI_SW.ServantWhereTypeUser ~= servantWhereType and UI_SW.ServantWhereTypePcRoom ~= servantWhereType then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
  if nil == servantInfo then
    return
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_MountainGoat then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_RECOVERY_ACK"))
  elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Carriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Boat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_CowCarriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Raft or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_FishingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_SailingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REPAIR_ACK"))
  end
  StableList_UpdateSlotData()
end
function FromClient_ServantChangeName(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_CHANGENAME_ACK"))
end
function FromClient_ServantRegisterAuction(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REGISTMARKET_ACK"))
end
function FromClient_ServantCancelAuction(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REGISTMARKETCANCEL_ACK"))
end
function FromClient_ServantReceiveAuction(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_GETREGISTMARKET_ACK"))
end
function FromClient_ServantBuyMarket(doRemove)
  if nil == doRemove then
    return
  end
  if doRemove then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SELL_SERVANT_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_MARKETBUY_ACK"))
  end
end
function FromClient_ServantStartMating(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MATINGSTART_ACK"))
end
function FromClient_ServantChildMating(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GETCOLT_ACK"))
end
function FromClient_ServantClearDeadCount()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET_ACK"))
end
function FromClient_ServantImprint(servantNo, isImprint)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  if true == isImprint then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_STAMPING_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_ISIMPRINT_ACK"))
  end
end
function FromClient_ServantClearMatingCount(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_MATINGCOUNTRESET_ACK"))
end
function FromClient_ServantLink(horseNo, carriageNo, isLinkSuccess)
  StableList_UpdateSlotData()
  local horseInfo = stable_getServantByServantNo(horseNo)
  local carriageInfo = stable_getServantByServantNo(carriageNo)
  if isLinkSuccess then
    if nil == horseInfo or nil == carriageInfo then
      return
    end
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_LINK", "carriageName", stable_getServantByServantNo(carriageNo):getName(), "horseName", stable_getServantByServantNo(horseNo):getName()))
  else
    if nil == horseInfo then
      return
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_UNLINK", "horseName", stable_getServantByServantNo(horseNo):getName()))
  end
end
function FromClient_ServantStartSkillTraining(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINSTART", "servantName", servantInfo:getName()))
end
function FromClient_ServantEndSkillTraining(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINEND", "servantName", servantInfo:getName()))
end
function FromClient_StartStallionSkillTraining(servantNo)
  if not isContentsStallionEnable and not isContentsNineTierEnable then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  stableList:update()
  StableStallion_Open(servantNo)
  ItemNotify_Open()
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINSTART", "servantName", servantInfo:getName()))
end
function FromClient_EndStallionSkillTraining(servantNo)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  stableList:update()
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINEND", "servantName", servantInfo:getName()))
end
function FromClient_IncreaseStallionSkillExpAck(servantNo, skillKey, skillExp)
end
function StableList_Open()
  local self = stableList
  self:clear()
  self:update()
  UIAni.fadeInSCR_Down(Panel_Window_StableList)
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii].effect:SetShow(false)
  end
  if not Panel_Window_StableList:GetShow() then
    Panel_Window_StableList:SetShow(true)
  end
  self._selectSceneIndex = -1
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  if nil ~= servantInfo then
    if self._taming._bg:GetShow() then
      StableList_ButtonOpen(self._const.eTypeTaming, 0)
    else
      StableList_ButtonOpen(self._const.eTypeUnsealed, 0)
    end
  elseif self._taming._bg:GetShow() then
    StableList_ButtonOpen(self._const.eTypeTaming, 0)
  else
    StableList_SlotSelect(0)
  end
end
function StableList_Close()
  if not Panel_Window_StableList:GetShow() then
    return
  end
  local self = stableList
  Servant_ScenePopObject(self._selectSceneIndex)
  self._scroll:SetControlTop()
  _startSlotIndex = 0
  Panel_HorseLookChange_Close()
  StableInfo_Close()
  StableEquipInfo_Close()
  StableRegister_Close()
  StableMarketInput_Close()
  StableList_ButtonClose()
  stableCarriage_Close()
  Panel_Window_StableList:SetShow(false)
end
function Panel_HorseLookChange_Open()
  if Panel_Window_HorseLookChange:GetShow() then
    return
  end
  if Panel_Window_StableInfo:GetShow() then
    Panel_Window_StableInfo:SetShow(false)
  end
  Panel_Window_HorseLookChange:SetShow(true)
  Panel_Window_HorseLookChange:SetPosX(getScreenSizeX() - Panel_Window_HorseLookChange:GetSizeX() - 30)
  Panel_Window_HorseLookChange:SetPosY(30)
  currentPage = 0
end
function Panel_HorseLookChange_Close()
  Panel_Window_HorseLookChange:SetShow(false)
  if -1 ~= beforeActionIndex then
    showSceneCharacter(self._selectSceneIndex, false, beforeActionIndex)
  end
  beforeActionIndex = -1
  if Panel_Window_StableList:GetShow() then
    StableInfo_Open()
  end
end
stableList:init()
stableList:registEventHandler()
stableList:registMessageHandler()
StableList_Resize()
