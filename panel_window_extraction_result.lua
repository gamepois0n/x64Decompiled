local UI_PUCT = CppEnums.PA_UI_CONTROL_TYPE
local UI_color = Defines.Color
PaGlobal_ExtractionResult = {
  _uiResultMsgBG = UI.getChildControl(Panel_Window_Extraction_Result, "Static_Finish"),
  _uiTextResultMsg = UI.getChildControl(Panel_Window_Extraction_Result, "StaticText_Finish")
}
function PaGlobal_ExtractionResult:setTextResultMsg(text)
  self._uiTextResultMsg:SetText(text)
end
function PaGlobal_ExtractionResult:initialize()
  self:resetPanel()
  self:resetChildControl()
  self:resetAnimation()
end
function PaGlobal_ExtractionResult:resetPanel()
  Panel_Window_Extraction_Result:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_Extraction_Result:SetPosX(0)
  Panel_Window_Extraction_Result:SetPosY(0)
  Panel_Window_Extraction_Result:SetColor(UI_color.C_00FFFFFF)
  Panel_Window_Extraction_Result:SetIgnore(true)
  Panel_Window_Extraction_Result:SetShow(false)
end
function PaGlobal_ExtractionResult:resetChildControl()
  self._uiResultMsgBG:SetSize(getScreenSizeX() + 40, 90)
  self._uiResultMsgBG:SetPosX(-20)
  self._uiResultMsgBG:ComputePos()
  self._uiTextResultMsg:SetSize(getScreenSizeX(), 90)
  self._uiTextResultMsg:ComputePos()
end
function PaGlobal_ExtractionResult:resetAnimation()
  self._uiResultMsgBG:ResetVertexAni()
  self._uiResultMsgBG:SetVertexAniRun("Ani_Scale_0", true)
end
function PaGlobal_ExtractionResult:getShow()
  return Panel_Window_Extraction_Result:GetShow()
end
function PaGlobal_ExtractionResult:setShow()
  Panel_Window_Extraction_Result:SetShow(true)
end
function PaGlobal_ExtractionResult:setHide()
  Panel_Window_Extraction_Result:SetShow(false)
end
function PaGlobal_ExtractionResult_Resize()
  PaGlobal_ExtractionResult:initialize()
end
function PaGlobal_ExtractionResult:registMessageHandler()
  registerEvent("onScreenResize", "PaGlobal_ExtractionResult_Resize")
end
PaGlobal_ExtractionResult:initialize()
PaGlobal_ExtractionResult:registMessageHandler()
