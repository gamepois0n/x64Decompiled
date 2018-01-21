local UI_TM = CppEnums.TextMode
PaGlobal_CharacterInfoTitle = {
  _filterText = "",
  _currentCategoryIdx = 0,
  _currentCategoryCount = 0,
  _category = {
    _world = 0,
    _battle = 1,
    _life = 2,
    _fish = 3
  },
  _categoryStirng = {
    [0] = "LUA_CHARACTERINFO_TITLE_LISTALL",
    [1] = "LUA_CHARACTERINFO_TITLE_LISTCOMBAT",
    [2] = "LUA_CHARACTERINFO_TITLE_LISTPRODUCT",
    [3] = "LUA_CHARACTERINFO_TITLE_LISTFISH"
  },
  _comboBoxList = {
    _all = 0,
    _have = 1,
    _absence = 2
  },
  _comboBoxString = {
    [0] = "\236\160\132 \236\178\180",
    [1] = "\235\179\180 \236\156\160",
    [2] = "\235\175\184\235\179\180\236\156\160"
  },
  _ui = {
    _radioButtonCategory = {
      [0] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Taste_AllRound"),
      [1] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Taste_Combat"),
      [2] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Taste_Product"),
      [3] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Taste_Fishing")
    },
    _radioButtonSubCategory = {
      [0] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Top_AllRound"),
      [1] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Top_Combat"),
      [2] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Top_Product"),
      [3] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "RadioButton_Top_Fish")
    },
    _Progress2Total_Progress = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "Static_TotalProgress_Progress"),
    _staticTextTotal_Value = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_TotalProgress_Percent"),
    _staticTextTitle_Value = {
      [0] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_AllRound_CountValue"),
      [1] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Combat_CountValue"),
      [2] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Product_CountValue"),
      [3] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Fishing_CountValue")
    },
    _staticTextTitle_Percent = {
      [0] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_AllRound_PercentValue"),
      [1] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Combat_PercentValue"),
      [2] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Product_PercentValue"),
      [3] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Fishing_PercentValue")
    },
    _circularProgressTitle = {
      [0] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "CircularProgress_AllRound"),
      [1] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "CircularProgress_Combat"),
      [2] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "CircularProgress_Product"),
      [3] = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "CircularProgress_Fishing")
    },
    _staticText_TotalReward = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_TotalProgressReward"),
    _staticText_TotalReward_Value = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_TotalProgressReward_Value"),
    _staticText_PartDesc = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_SelectedType"),
    _staticText_SubTitleBar = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_LeftSubTitle"),
    _staticText_LastUpdateTime = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_AcceptCooltime"),
    _list2Title = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "List2_CharacterInfo_TitleList"),
    _comboBoxSort = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "Combobox_List_Sort"),
    _editSearch = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "EditSearchText"),
    _buttonSearch = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "BtnSearch"),
    _staticText_Nothing = UI.getChildControl(Panel_Window_CharInfo_TitleInfo, "StaticText_Nothing")
  }
}
function PaGlobal_CharacterInfoTitle:initialize()
  self._ui._list2Title:setMinScrollBtnSize(float2(10, 50))
  self._ui._list2Title:createChildContent(CppEnums.PAUIList2ElementManagerType.list)
  self._ui._comboBoxSort:DeleteAllItem(0)
  for index = 0, #self._comboBoxString do
    self._ui._comboBoxSort:AddItem(self._comboBoxString[index])
  end
  self._ui._comboBoxSort:GetListControl():SetSize(self._ui._comboBoxSort:GetSizeX(), (#self._comboBoxString + 1) * 22)
  self._ui._staticText_TotalReward_Value:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self._ui._staticText_PartDesc:SetTextMode(UI_TM.eTextMode_AutoWrap)
  if isGameTypeKorea() then
    self._ui._editSearch:SetMaxInput(20)
  else
    self._ui._editSearch:SetMaxInput(40)
  end
  self._ui._staticText_Nothing:SetShow(false)
end
function PaGlobal_CharacterInfoTitle:update()
  self._ui._staticText_SubTitleBar:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_SUBTITLEBAR_COUNT", "count", ToClient_GetTotalAcquiredTitleCount()))
  self._ui._staticText_TotalReward_Value:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_TOTALREWARD_VALUE"))
  if "" == self._ui._staticText_PartDesc:GetText() or nil == self._ui._staticText_PartDesc:GetText() then
    self._ui._staticText_PartDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_PARTDESC"))
  end
  local coolTime = ToClient_GetUpdateTitleDelay()
  self._ui._staticText_LastUpdateTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TITLE_LASTUPDATETIME", "coolTime", coolTime))
  local titleCountByAll = ToClient_GetTotalTitleCount()
  local acquiredTitleCountByAll = ToClient_GetTotalAcquiredTitleCount()
  local titleTotalCount = ToClient_GetTotalTitleBuffCount()
  if nil ~= titleCountByAll and nil ~= acquiredTitleCountByAll and nil ~= titleTotalCount then
    local totalPercent = acquiredTitleCountByAll / titleCountByAll * 100
    self._ui._Progress2Total_Progress:SetProgressRate(totalPercent)
    self._ui._staticTextTotal_Value:SetText(string.format("%.1f", totalPercent) .. "%")
    for index = 0, titleTotalCount - 1 do
      local titleBuffWrapper = ToClient_GetTitleBuffWrapper(index)
      if nil ~= titleBuffWrapper then
        local buffDescription = titleBuffWrapper:getBuffDescription()
        self._ui._staticText_TotalReward_Value:SetText(buffDescription)
      end
    end
  end
  for key, index in pairs(self._category) do
    local titleCurrentCount = ToClient_GetCategoryTitleCount(index)
    local titleCurrentGetCount = ToClient_GetAcquiredTitleCount(index)
    if nil == titleCurrentCount or nil == titleCurrentGetCount then
      break
    end
    local titleCurrentPercent = titleCurrentGetCount / titleCurrentCount * 100
    self._ui._staticTextTitle_Value[index]:SetText(titleCurrentGetCount .. "/" .. titleCurrentCount)
    self._ui._circularProgressTitle[index]:SetProgressRate(titleCurrentPercent)
    self._ui._staticTextTitle_Percent[index]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, self._categoryStirng[index], "percent", string.format("%.1f", titleCurrentPercent)))
  end
  self:updateList()
end
function PaGlobal_CharacterInfoTitle:registEventHandler()
  for key, idx in pairs(self._category) do
    self._ui._radioButtonCategory[idx]:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_Category(" .. idx .. ")")
    self._ui._radioButtonCategory[idx]:addInputEvent("Mouse_On", "PaGlobal_CharacterInfoTitle:handleMouseOver_Category(true, " .. idx .. ")")
    self._ui._radioButtonCategory[idx]:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfoTitle:handleMouseOver_Category(false)")
    self._ui._radioButtonSubCategory[idx]:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_Category(" .. idx .. ")")
  end
  self._ui._comboBoxSort:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_ComboBox()")
  self._ui._comboBoxSort:GetListControl():addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_ComboBoxText()")
  self._ui._buttonSearch:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_SearchButton()")
  self._ui._editSearch:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfoTitle:handleClicked_SearchText()")
  self._ui._editSearch:RegistReturnKeyEvent("PaGlobal_CharacterInfoTitle:handleClicked_SearchButton()")
end
function PaGlobal_CharacterInfoTitle:registMessageHandler()
  registerEvent("FromClient_TitleInfo_UpdateText", "FromClient_UI_CharacterInfo_Title_Update")
  self._ui._list2Title:registEvent(CppEnums.PAUIList2EventType.luaChangeContent, "FromClient_UI_CharacterInfo_Title_CreateList")
end
PaGlobal_CharacterInfoTitle:initialize()
PaGlobal_CharacterInfoTitle:registEventHandler()
PaGlobal_CharacterInfoTitle:registMessageHandler()
