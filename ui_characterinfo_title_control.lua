local IM = CppEnums.EProcessorInputMode
local self = PaGlobal_CharacterInfoTitle
function FromClient_UI_CharacterInfo_Title_Update()
  if Panel_Window_CharInfo_Status:IsShow() == false then
    return
  end
  self:update()
end
function FromClient_UI_CharacterInfo_Title_CreateList(content, key)
  local titleIndex = Int64toInt32(key)
  local titleWrapper = ToClient_GetTitleStaticStatusWrapper(titleIndex)
  if nil == titleWrapper then
    return
  end
  local titleBG = UI.getChildControl(content, "List2_Static_TitleList_TitleBG")
  titleBG:setNotImpactScrollEvent(true)
  local titleName = UI.getChildControl(content, "List2_StaticText_TitleList_Title")
  local titleSet = UI.getChildControl(content, "List2_Button_SetTitle")
  if titleWrapper:isAcquired() == true then
    titleName:SetText(titleWrapper:getName())
    titleSet:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_Title(" .. self._currentCategoryIdx .. ", " .. titleIndex .. ")")
    if ToClient_IsAppliedTitle(titleWrapper:getKey()) then
      titleSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_RELEASE"))
    else
      titleSet:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_APPLICATION"))
    end
    titleSet:SetShow(true)
  else
    titleName:SetText("<PAColor0xFF444444>" .. titleWrapper:getName() .. "<PAOldColor>")
    titleSet:SetShow(false)
  end
  titleBG:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_Description(" .. self._currentCategoryIdx .. "," .. titleIndex .. ")")
end
function PaGlobal_CharacterInfoTitle:handleClicked_SearchButton()
  self._filterText = self._ui._editSearch:GetEditText()
  ClearFocusEdit()
  self:updateList()
end
function PaGlobal_CharacterInfoTitle:handleClicked_SearchText()
  self:clearSearchText()
  SetFocusEdit(self._ui._editSearch)
end
function PaGlobal_CharacterInfoTitle:handleClicked_Category(categoryIdx)
  for key, index in pairs(self._category) do
    self._ui._radioButtonCategory[index]:SetCheck(false)
    self._ui._radioButtonSubCategory[index]:SetCheck(false)
    self._ui._radioButtonSubCategory[index]:SetFontColor(4291083966)
  end
  ToClient_SetCurrentTitleCategory(categoryIdx)
  self._currentCategoryCount = ToClient_GetCategoryTitleCount(categoryIdx)
  self._currentCategoryIdx = categoryIdx
  self._ui._radioButtonCategory[categoryIdx]:SetCheck(true)
  self._ui._radioButtonSubCategory[categoryIdx]:SetCheck(true)
  local color = {
    [self._category._world] = 4294959762,
    [self._category._battle] = 4294940310,
    [self._category._life] = 4292935574,
    [self._category._fish] = 4288076287
  }
  self._ui._radioButtonSubCategory[categoryIdx]:SetFontColor(color[categoryIdx])
  self:clearSearchText()
  self:updateList()
end
function PaGlobal_CharacterInfoTitle:handleClicked_ComboBox()
  self._ui._comboBoxSort:ToggleListbox()
end
function PaGlobal_CharacterInfoTitle:handleClicked_ComboBoxText()
  self._ui._comboBoxSort:SetSelectItemIndex(self._ui._comboBoxSort:GetSelectIndex())
  self._ui._comboBoxSort:ToggleListbox()
  self:clearSearchText()
  self:updateList()
end
function PaGlobal_CharacterInfoTitle:handleClicked_Description(categoryIdx, titleIdx)
  ToClient_SetCurrentTitleCategory(categoryIdx)
  local titleWrapper = ToClient_GetTitleStaticStatusWrapper(titleIdx)
  self._ui._staticText_PartDesc:SetText(titleWrapper:getDescription())
end
function PaGlobal_CharacterInfoTitle:handleClicked_Title(categoryIdx, titleIdx)
  self:handleClicked_Description(categoryIdx, titleIdx)
  ToClient_TitleSetRequest(categoryIdx, titleIdx)
end
function PaGlobal_CharacterInfoTitle:handleMouseOver_Category(isShow, tipType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local string = {
    [self._category._world] = "UI_WINDOW_CHARACTERINFO_TITLE_TOOLTIP_ALLROUND",
    [self._category._battle] = "UI_WINDOW_CHARACTERINFO_TITLE_TOOLTIP_COMBAT",
    [self._category._life] = "UI_WINDOW_CHARACTERINFO_TITLE_TOOLTIP_LIFE",
    [self._category._fish] = "UI_WINDOW_CHARACTERINFO_TITLE_TOOLTIP_FISH"
  }
  local uiControl, name, desc
  uiControl = self._ui._radioButtonCategory[tipType]
  name = PAGetString(Defines.StringSheet_RESOURCE, string[tipType])
  registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobal_CharacterInfoTitle:showWindow()
  self:handleClicked_Category(self._category._world)
  self._ui._comboBoxSort:SetSelectItemIndex(self._comboBoxList._all)
  self:clearSearchText()
  self:update()
end
function PaGlobal_CharacterInfoTitle:updateList()
  ToClient_MakeTitleList(self._filterText, self._ui._comboBoxSort:GetSelectIndex())
  local listCount = ToClient_GetFilteredTitleCount()
  self._ui._list2Title:getElementManager():clearKey()
  for index = 0, listCount - 1 do
    local titleIdx = ToClient_GetTitleIndexFromFilteredList(index)
    self._ui._list2Title:getElementManager():pushKey(toInt64(0, titleIdx))
  end
  if listCount == 0 then
    self._ui._staticText_Nothing:SetShow(true)
  else
    self._ui._staticText_Nothing:SetShow(false)
  end
end
function PaGlobal_CharacterInfoTitle:clearSearchText()
  self._ui._editSearch:SetEditText("", false)
  self._filterText = ""
  ClearFocusEdit()
end
