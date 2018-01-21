local UI_TM = CppEnums.TextMode
PaGlobal_MovieGuide_Web = {
  btn_Close = UI.getChildControl(Panel_MovieGuide_Web, "Button_Close")
}
local _Web = UI.createControl(CppEnums.PA_UI_CONTROL_TYPE.PA_UI_CONTROL_WEBCONTROL, Panel_MovieGuide_Web, "WebControl_MovieGuideWeb_WebLink")
_Web:SetShow(true)
_Web:SetPosX(12)
_Web:SetPosY(50)
_Web:SetSize(320, 430)
_Web:ResetUrl()
function PaGlobal_MovieGuide_Web:init()
  self.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MovieGuide_Web:Close()")
  local checkAgeType = ToClient_isAdultUser()
  if checkAgeType then
    _Web:SetMonoTone(false)
  else
    _Web:SetMonoTone(true)
  end
end
function PaGlobal_MovieGuide_Web:Open()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local movieGuideWeb = PaGlobal_URL_Check(worldNo)
  Panel_MovieGuide_Web:SetPosX(getScreenSizeX() / 2 - Panel_MovieGuide_Web:GetSizeX() / 2)
  Panel_MovieGuide_Web:SetPosY(getScreenSizeY() / 2 - Panel_MovieGuide_Web:GetSizeY() / 2)
  if nil ~= movieGuideWeb then
    local url = movieGuideWeb .. "/MovieGuide/Index"
    _Web:SetUrl(320, 430, url, false, true)
    Panel_MovieGuide_Web:SetShow(true)
  end
end
function PaGlobal_MovieGuide_Web:Close()
  Panel_MovieGuide_Web:SetShow(false)
  _Web:ResetUrl()
end
function PaGlobal_MovieGuide_Web:GuideWebCodeExecute(titleName, youtubeUrl)
end
PaGlobal_MovieGuide_Web:init()
